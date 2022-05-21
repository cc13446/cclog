#!/bin/bash
set -e

BASE_PATH=./build/libs
SERVER_NAME=cclog-0.0.1-SNAPSHOT

JAVA_OPS="-Xms1024m -Xmx1024m"

function stop() {
    echo "[stop] 开始停止 $BASE_PATH/$SERVER_NAME"
    PID=$(ps -ef | grep $SERVER_NAME.jar | grep -v "grep" | awk '{print $2}')
    echo "是否有PID: [$PID]"
    if [ -n "$PID" ]; then
        # 正常关闭
        echo "[stop] $SERVER_NAME.jar 运行中，开始 kill [$PID]"
        kill -15 $PID
        # 等待最大 60 秒，直到关闭完成。
        for ((i = 0; i < 60; i++))
            do
                sleep 1
                PID=$(ps -ef | grep $SERVER_NAME.jar | grep -v "grep" | awk '{print $2}')
                if [ -n "$PID" ]; then
                    echo -e ".\c"
                else
                    echo '[stop] 停止 $BASE_PATH/$SERVER_NAME.jar 成功'
                    break
                fi
            done

        # 如果正常关闭失败，那么进行强制 kill -9 进行关闭
        if [ -n "$PID" ]; then
            echo "[stop] $BASE_PATH/$SERVER_NAME.jar 失败，强制 kill -9 $PID"
            kill -9 $PID
        fi
    # 如果 Java 服务未启动，则无需关闭
    else
        echo "[stop] $BASE_PATH/$SERVER_NAME.jar 未启动，无需停止"
    fi
}

# 启动
function start() {
    # 开启启动前，打印启动参数
    echo "[start] 开始启动 $BASE_PATH/$SERVER_NAME.jar"
    echo "[start] JAVA_OPS: $JAVA_OPS"
    source /etc/profile
    export JENKINS_NODE_COOKIE=dontKillMe
    nohup java -Dhudson.util.ProcessTree.disable=true -jar $BASE_PATH/$SERVER_NAME.jar >/dev/null 2>log &
    echo "[start] 启动 $BASE_PATH/$SERVER_NAME.jar 完成 [$JENKINS_NODE_COOKIE]"
}


# 部署
function deploy() {
    stop
    start
}

deploy
