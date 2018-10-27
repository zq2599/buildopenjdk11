#!/bin/bash
#修改所属人和所属群组
echo "start chown and chgrp"
chown -R root /src/jdk11 && chgrp -R root /src/jdk11

cd /src/jdk11

#配置
echo "start configure"
bash /src/jdk11/configure

#开始编译，如果有入参，就作为make的参数
echo "start make"

if [ $# -gt 0 ]; then
    echo "make param is "$1
    make $1
else
    make
fi

echo "Compile successful!"
