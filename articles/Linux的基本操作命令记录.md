


* 打包文件

    tar -cf archiver.tar foo bar

* 解压文件 .tar.gz

    tar xf java8.tar.gz -C /home/node1/env

将文件解压到/home/node1/env 目录

* 显示用户shell
    echo $SHELL

* 修改用户shell
    vim /etc/passwd

找到用户名，修改最后 sh 为 *bash*.

* 更改文件拥有者

    chown user /file
    chown -R user /file 

    