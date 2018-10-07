#!/usr/bin/env bash

USER_HOME_DIR=$(dirname $0)

function ssldepends()
{
    echo "HERE"	
    
    apt-get install -y git

    if [ -z "`dpkg -l | grep libsasl2-dev`" ] || [ -z "`dpkg -l | grep libssl-dev`" ];
	then
	echo -e "\033[33m *WRAN* set ssl runtime environment , it may take a moment ... \033[0m"
    	apt-get install pkg-config libssl-dev libsasl2-dev -y
    fi

    cd $USER_HOME_DIR
     
    wget https://github.com/mongodb/mongo-c-driver/releases/download/1.10.1/mongo-c-driver-1.10.1.tar.gz --directory-prefix=$USER_HOME_DIR
    if [ ! -f $USER_HOME_DIR/mongo-c-driver-1.10.1.tar.gz ];
    then
        echo "*ERROR* Fail to find the tar file: mongo-c-driver-1.9.2.tar.gz !"
         exit 1
    fi

    tar xzf $USER_HOME_DIR/mongo-c-driver-1.10.1.tar.gz
    
    cd $USER_HOME_DIR/mongo-c-driver-1.10.1
    mkdir cmake-build
    cd cmake-build
    cmake -DENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF ..
    make
    make install
    
    sleep 3

    #./configure --disable-automatic-init-and-cleanup --enable-static
    #make
    #make install
    #cd ..
 
    wget https://github.com/mongodb/mongo-cxx-driver/archive/r3.2.0.tar.gz --directory-prefix=/home/bottos
    if [ ! -f /home/bottos/r3.2.0.tar.gz ];
    then
        echo "*ERROR* Fail to find the tar file: r3.2.0.tar.gz !"
        exit 1
    fi

    tar xzf /home/bottos/r3.2.0.tar.gz
    if [ ! -d /home/bottos/mongo-cxx-driver-r3.2.0 ];
    then
         echo "*ERROR* Fail to find the tar file: mongo-cxx-driver-r3.2.0 !"
 	 exit 1
    fi

    cd /home/bottos/mongo-cxx-driver-r3.2.0/build
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local ..
    make EP_mnmlstc_core
    make
    make install
    cd ..

    #rm -rf $USER_HOME_DIR/mongo-c*
    #rm -rf $USER_HOME_DIR/r3.2.0*
}

apt-get install mongodb-server mongodb -y
ssldepends
