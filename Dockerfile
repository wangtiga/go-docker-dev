FROM golang:latest
MAINTAINER Michele Bertasi

ADD fs/ /

ENV HTTP_PROXY=http://10.155.34.18:10809
ENV HTTPS_PROXY=http://10.155.34.18:10809

# install pagkages
RUN apt-get update                                                      && \
    apt-get install -y ncurses-dev libtolua-dev exuberant-ctags gdb     && \
    ln -s /usr/include/lua5.2/ /usr/include/lua                         && \
    ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/lib/liblua.so     && \
# cleanup
    apt-get clean && rm -rf /var/lib/apt/lists/*

# build and install vim
RUN cd /tmp                                                             && \
    git clone --depth 1 https://github.com/vim/vim.git                  && \
    cd vim                                                              && \
    ./configure --with-features=huge --enable-luainterp                    \
        --enable-gui=no --without-x --prefix=/usr                       && \
    make VIMRUNTIMEDIR=/usr/share/vim/vim82                             && \
    make install                                                        && \
# cleanup
    rm -rf /tmp/* /var/tmp/*

# get go tools
RUN go env -w GO111MODULE=on                                            && \
    go env -w GOPROXY=https://goproxy.cn,direct                         && \
    go get golang.org/x/tools/cmd/godoc                                 && \
    go get github.com/nsf/gocode                                        && \
    go get golang.org/x/tools/cmd/goimports                             && \
    go get github.com/rogpeppe/godef                                    && \
    go get golang.org/x/tools/cmd/gorename                              && \
    go get golang.org/x/lint/golint                                     && \
    go get github.com/kisielk/errcheck                                  && \
    go get github.com/jstemmer/gotags                                   && \
    go get github.com/tools/godep                                       && \
    go get github.com/go-delve/delve/cmd/dlv                            && \
    GO111MODULE=on go get golang.org/x/tools/gopls@latest               && \
    mv /go/bin/* /usr/local/go/bin                                      && \
# cleanup
    rm -rf /go/src/* /go/pkg

# Dockerfile replicate the host user UID and GID to the image
# https://stackoverflow.com/questions/44683119/dockerfile-replicate-the-host-user-uid-and-gid-to-the-image
ARG UNAME=dev
ARG UID=1001
ARG GID=1002
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID $UNAME
RUN chown -R dev:dev /home/dev /go
#RUN adduser dev -u $UID -g $GID --disabled-password --gecos ""          && \
#    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
#    chown -R dev:dev /home/dev /go
#
# RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME                   && \

# # add dev user
# RUN adduser dev --disabled-password --gecos ""                          && \
#     echo "ALL            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers     && \
#     chown -R dev:dev /home/dev /go

USER dev
ENV HOME /home/dev

# install vim plugins
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    vim +PlugInstall +qall
