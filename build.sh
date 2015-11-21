#!/bin/bash

base_dir=`pwd`
tmp_dir=$base_dir/tmp

rm -rf $tmp_dir 
mkdir -p $tmp_dir
git clone -b 0.9.2 https://github.com/apache/thrift.git $tmp_dir  
if [ $? -ne 0 ]
then
    echo -e "\033[31m thrift: download from git error \033[0m"
    exit 1
fi

export LDFLAGS="${LDFLAGS} -lrt"

cd $tmp_dir
./bootstrap.sh \
    && ./configure --enable-tests=no --enable-tutorial=no --with-php=no --with-python=no --with-lua=no --prefix=${base_dir} --enable-shared=no \
        && make && make install
if [ $? -ne 0 ]
then
    echo -e "\033[31m thrift: make error \033[0m"
    exit 1
fi
rm -rf $tmp_dir


