


在本地执行

    ssh-keygen -t rsa

这会在用户目录生成 id_rsa 和 id_rsa.pub 两个文件

将 id_rsa.pub 发送到远程要登陆的linux 服务器

    scp ./id_rsa.pub  username@remotehost:/home/username/

然后追加到 ~/.ssh/authorized_keys

    cat ~/.id_rsa.pub >> ~/.ssh/authorized_keys

然后就可以在本地免密远程登录了。