


ubuntu之前在应用安装软件，觉得太慢，就手动终止了，后面再安装报错： “snap has "install-snap" change in process”。

* 查看改变

    snap changes

!["input cmd result"](../images/snap_changes.png)

* 终止change

    sudo snap abort 6

* 重新安装

    sudo snap install chromium