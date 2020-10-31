"""
linux基本指令
ls pwd cd touch mkdir rm clear cp mv tree chmod find grep |、ln、tar、shutdown, reboot, who, exit, passwd, sudo

ls -lah list/all/human-readable
mkdir -p 递归创建
rm -rf 递归删除/强制删除
cp -rf 递归拷贝/强制拷贝
>输出重定向会覆盖原来的内容，>>输出重定向则会追加到文件的尾部。
软链接：ln -s 源文件 目标文件
硬链接：ln 源文件 目标文件
grep -vni 'a' 1.txt 反选/显示行号/忽略大小写
find path -name/-size/-perm xx
tar -zxvf test.tar.gz -C dir 压缩包/解压/显示进度/指定文件名称 指定解压目录
tar -zcvf test.tar.gz * 压缩包/压缩/显示进度/指定文件名称
gzip -dr 解压/压缩
chmod u/g/o/a +/-/= rwx 文件
chmod 777 -R 文件

scp  要传输的文件  远程用户名@远程主机ip:远程主机的路径

date +%F/+%T
"""

"""
vim 编辑器
命令模式：gg文件头，G文件尾，u撤销，yy复制当前行p粘贴
末行模式：set nu
编辑模式：
"""
