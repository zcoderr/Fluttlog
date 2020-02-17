#!/usr/bin/env bash
# !/bin/bash
# 腾讯云服务器
SERVER_IP="192.144.212.146"

echo "Generate json data file..."
dart pretreatment.dart

echo "Build flutter fo web"
flutter build web

echo "Uploading build file"
ssh root@$SERVER_IP "rm -rf ~/html/"
scp -r ./build/web/ root@$SERVER_IP:/root/html/

echo "Deploy Success!!!"

# 坑点：
# 1. 不仅要杀掉远程的进程，还要删掉原先的可执行文件！！,scp 不会远程已经存在的文件
# 2. 远程执行命令不会返回错误，所以命令和路径一定要确认好!!!
