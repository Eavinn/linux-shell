#!/bin/bash
# 功能：部署代码

# 添加日志功能
log_path="/home/python/data/logs/deploy.log"

write_log(){
    # 2018-04-01  22:14:15  deploy.sh:  打包代码
    date=$(date +%F)
    time=$(date +%T)
    action=$1
    echo "${date}  ${time}  $0 : ${action}" >> "${log_path}"

}


# 获取代码
get_code(){
    
    echo "获取代码"
    write_log "获取代码"

}

# 打包代码
tar_code(){
    
    ssh chenqian@192.168.46.40 "bash /data/scripts/tar_code.sh"    
    echo "打包代码"
    write_log "打包代码"
}

# 传输代码
scp_code(){
    echo "传输代码"
    # 进入服务器的上传代码文件夹
    cd  ~/data/scp_codes/
    # 服务器拉取代码仓库打包好的压缩文件到本地
    scp chenqian@192.168.46.40:/data/codes/index.tar.gz  ./
    write_log "传输代码"
}

# 关闭应用
stop_server(){

    echo "关闭应用"
    # 关闭nginx
    sudo ~/data/nginx/sbin/nginx -s stop
    # 关闭flask
    kill $(lsof -Pti:5000)
    write_log "关闭应用"
}

# 解压代码
untar_code(){

    echo "解压代码"
    cd  ~/data/scp_codes
    tar xf index.tar.gz
    write_log "解压代码"

}


# 放置代码
put_code(){

    echo "放置代码"
    # 备份老的代码
    mv ~/data/server/ihome/index.py  ~/data/backup/index.py-$(date +%Y%m%d%H%M%S)
    # 放置新代码
    cd  ~/data/scp_codes
    mv index.py ~/data/server/ihome/
    write_log "放置代码"

}

# 开启应用
start_server(){

    echo "开启应用"
    # 开启falsk
    source  ~/data/virtual/flask_py3/bin/activate
    cd ~/data/server/ihome/
    python3 index.py >> /dev/null 2>&1 &
    deactivate
    # 开启nginx
    sudo ~/data/nginx/sbin/nginx
    write_log "开启应用"
}


# 检测
check(){

    echo "检测"
    sudo netstat -tnulp | grep ':80'
    write_log "检测"
}

# 添加锁文件功能
lock_path="/home/python/data/scripts/lock"

# 创建锁文件
add_lock(){
    # 创建文件
    touch "${lock_path}"
    # 记录日志
    write_log "创建锁文件"
}
# 删除锁文件
del_lock(){

    # 删除文件
    rm -rf "${lock_path}"
    # 记录日志
    write_log "删除锁文件"
}


# 部署代码
deploy_code(){
    add_lock
    get_code
    tar_code
    scp_code
    stop_server
    untar_code
    put_code
    start_server
    check   
    del_lock
    write_log "部署代码"
}

# 锁文件存在的提示信息
tip_msg(){
    echo "脚本 $0 正在运行，请稍候..."
}

# 脚本执行的提示信息
usage(){

    echo "脚本 $0 的使用方式： bash $0 [ deploy ]"
}


main(){

    case "$1" in
        "deploy")
            # 传入的参数正确取执行部署
            # 判断是否有锁文件存在
            if [ -f "${lock_path}" ]
            then
                # 提示信息
                 tip_msg
            else
                # 执行部署
                deploy_code
            fi
            ;;
        *)
            # 提示脚本执行正确信息
            usage
            ;;
  esac

}

# 脚本入口函数  接受脚本传入参数
if [ "$#" -eq 1 ]
then
    # 入口    
    main $1
else
    # 提示脚本执行的帮助信息
    usage
fi
