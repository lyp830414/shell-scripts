关于MONGODB安装失败的原因
最近源码安装发现cmake总是报以下两个错误
   1. error: could not find git for clone of ep_mnmlstc_core 
   2. No rules to make Ep_mnmlstc_core

发现原因有如下几个
   1. 新VM gcc/g++未升级将不支持C11，即需要升级至4.8以上 
   2. directory-prefix 路径好像没支持当前work dir，导致第二个mdb drv包没下载成功。目前写死内测用。
   3. 新VM没有内置git, cmake download Ep_mnmlstc_core 失败。
