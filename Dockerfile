#Docker image of source for OpenJDK
# VERSION 0.0.1
# Author: bolingcavalry

#基础镜像使用ubuntu:16.04
FROM ubuntu:16.04

#作者
MAINTAINER BolingCavalry <zq2599@gmail.com>

#定义boot jdk文件名
ENV BOOT_JDK_FILE_NAME jdk-10_linux-x64_bin_ri

#定义boot jdk安装目录
ENV BOOT_JDK_PATH /usr/lib/jvm

#定义boot jdk解压后的包名
ENV BOOT_JDK_PACKAGE_NAME jdk-10

#boot jdk的完全路径
ENV BOOT_JDK_HOME $BOOT_JDK_PATH/$BOOT_JDK_PACKAGE_NAME

#boot jdk相关的环境变量
ENV JAVA_HOME $BOOT_JDK_HOME
ENV JRE_HOME $BOOT_JDK_HOME/jre
ENV CLASSPATH .:$BOOT_JDK_HOME/lib:$JRE_HOME/lib
ENV PATH=$BOOT_JDK_HOME/bin:$PATH

#创建文件夹用于安装boot jdk
RUN mkdir $BOOT_JDK_PATH

#将分割好的boot jdk安装文件逐个复制到镜像中，分多步完成，这样下载过程中出现问题时，不至于全部重新开始下载
COPY ./$BOOT_JDK_FILE_NAME-ac $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ag $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ak $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ao $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-as $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ad $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ah $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-al $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ap $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-aa $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ae $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ai $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-am $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-aq $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ab $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-af $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-aj $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-an $BOOT_JDK_PATH/
COPY ./$BOOT_JDK_FILE_NAME-ar $BOOT_JDK_PATH/

#还原成完整的文件，再解压开，将boot JDK配置信息写入环境变量，创建jre目录，把lib放进去
RUN cat $BOOT_JDK_PATH/$BOOT_JDK_FILE_NAME-* > $BOOT_JDK_PATH/$BOOT_JDK_FILE_NAME.tar.gz \
&& tar -zxvf $BOOT_JDK_PATH/$BOOT_JDK_FILE_NAME.tar.gz -C $BOOT_JDK_PATH \
&& rm $BOOT_JDK_PATH/$BOOT_JDK_FILE_NAME.tar.gz \
&& rm $BOOT_JDK_PATH/$BOOT_JDK_FILE_NAME-* \
&& mkdir $BOOT_JDK_HOME/jre \
&& cp -r $BOOT_JDK_HOME/lib $BOOT_JDK_HOME/jre/

#备份旧的源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup

#复制新的源
COPY ./sources.list /etc/apt/

#apt更新
RUN apt-get update \
&& apt-get install -y file autoconf zip libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libcups2-dev libfontconfig1-dev libasound2-dev

#命令行文件复制到工作目录
COPY ./cmd.sh /

#赋予可执行权限
RUN chmod a+x /cmd.sh

#启动执行
#CMD ["/bin/bash", "/cmd.sh"]
ENTRYPOINT ["/cmd.sh"]
