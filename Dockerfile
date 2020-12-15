FROM ubuntu

ENV DISPLAY=10.0.75.1:0.0
ENV USER=dev
ENV GROUP=developers

ENV DEBIAN_FRONTEND=noninteractive

##############################
# VScodeの設定               #
##############################
RUN groupadd $GROUP\
 && useradd -m -G $GROUP $USER

# リポジトリを日本にして、アプデ
RUN sed -i.bak -e "s%http://archive.ubuntu.com/ubuntu/%http://ftp.iij.ad.jp/pub/linux/ubuntu/archive%g" /etc/apt/sources.list \
 && apt-get update 

# 必須なソフトのインストール
RUN apt-get install -y curl apt-transport-https libgtk2.0-0 libxss1 libasound2 xauth x11-apps dbus git gpg \
 && mkdir /var/run/dbus

# リポジトリの追加
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
 && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
 && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
 

# vscodeのインストール
RUN apt-get update\
 && apt-get install -y code\
 && apt-get install -f

# vscodeの設定
RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so.1 /usr/share/code/ \
 && cp /usr/lib/x86_64-linux-gnu/libxcb.so.1.1.0 /usr/share/code/ \
 && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1 \
 && sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/share/code/libxcb.so.1.1.0

##############################
# 日本語の設定               #
##############################

# 日本語のインストール
RUN apt-get install -y ibus-mozc fontconfig dbus-x11 x11-xserver-utils fonts-takao-* language-pack-ja tzdata
 
# 日本語の設定
RUN locale-gen ja_JP.UTF-8 \
 && update-locale LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 \
 && dpkg-reconfigure locales \
 && ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && dpkg-reconfigure tzdata 


#お掃除
RUN  apt-get clean


USER $USER

WORKDIR /home/$USER

ENTRYPOINT /usr/bin/code --verbose

#Ref
##https://qiita.com/Tadahiro_Yamamura/items/0e198910d3efec503742
##https://zukucode.com/2019/07/docker-japanese-input.html