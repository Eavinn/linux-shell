#!/bin/bash
# 普通变量，单引号定义变量不解析，双引号解析
name='liang'
echo "meng $name"

# 命令变量
file_list=$(ls)
echo "$file_list"

# 全局变量
export my_name="012345678"
echo "${my_name}"
echo "------------------------------------------"


:<<!
$0 表示脚本的名称
$n 表示接受脚本传入的参数
$# 表示传入参数的个数
:-可以定义默认值
!
echo "脚本的名称为：$0"
param1=$1
echo "脚本参数1：${param1:-first_param}"
echo "脚本参数2：$2"
echo "脚本参数3：$3"
echo "脚本参数个数：$#"
echo "------------------------------------------"


# 字符串截取
echo ${my_name:0:5}
echo ${my_name:0-2:1}
echo "------------------------------------------"


# sed命令替换, sed -i '行号s#原内容#替换后内容#列号' 文件名
sed "s#sed#SED#" sed.txt
sed "s#sed#SED#g" sed.txt
sed "2s#sed#SED#2" sed.txt
echo "××××××××××××××××××××××××××××××××××××××××××"
# sed命令添加，sed -i '行号i/a\增加的内容' 文件名
sed "1,3a\append" sed.txt
sed "1i\insert" sed.txt
echo "××××××××××××××××××××××××××××××××××××××××××"
# sed命令删除，sed -i '行号d' 文件名
sed "1,2d" sed.txt
echo "------------------------------------------"


# awk命令,NR指定行数，$指定列数
awk 'NR==1,2 {print $1,$3}' awk.txt
awk 'BEGIN{OFS=":"} {print NR,$0}' awk.txt
echo "------------------------------------------"


# 流程控制， 判断
if [ "$1" == "start" ]
then
   echo "服务启动中..."
elif [ "$1" == "stop" ]
then
   echo "服务关闭中..."
elif [ "$1" == "restart" ]
then
   echo "服务重启中..."
else
   echo "$0 脚本的使用方式： $0 [ start | stop | restart ]"
fi

case "$1" in
	"start")
		echo "服务启动中..."
		;;
	"stop")
		echo "服务关闭中..."
		;;
	"restart")
		echo "服务重启中..."
		;;
	*)
		echo "$0 脚本的使用方式： $0 [ start | stop | restart ]"
		;;
esac
echo "------------------------------------------"


# 流程控制，for, while, until循环
for value in $(ls)
do
  echo "${value}"
done

a=1
while [ "${a}" -lt 3 ]
do
   echo "${a}"
   a=$((a+1))
done

a=1
until [ "${a}" -eq 3 ]
do
   echo "${a}"
   a=$((a+1))
done
echo "------------------------------------------"


# 函数
print_func(){
   echo "函数传参：$1"
}
#接受脚本传入的参数
print_func $1
