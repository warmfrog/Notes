


## 系统信息

* Ubuntu版本: Ubuntu18.04LTS
* Windows10: 1809

## 参考地址

<https://blog.csdn.net/u011138447/article/details/78262369>

<https://www.zdnet.com/article/how-to-run-run-the-native-ubuntu-desktop-on-windows-10/>

<https://github.com/Microsoft/WSL/issues/637>

## 安装过程

* 在Window10下安装X-Windows, 可选Xming，VcXsrv Windows X Server. 推荐使用VvXsrv,因为我是在VcXsrv下配置成功的。

[VcXsrv下载](https://ncu.dl.sourceforge.net/project/vcxsrv/vcxsrv/1.19.3.3/vcxsrv-64.1.19.3.3.installer.exe)

[百度云地址](https://pan.baidu.com/s/1nAcVhL-CHeJ8AsRNWs7IVA)

* 安装完成，启动XLaunch. 设置Display number 为0，其他默认。

* Ubuntu安装桌面

    sudo apt-get install ubuntu-desktop unity compizconfig-settings-manager

* 配置compiz 窗口管理器

    export DISPLAY=localhost:0

可以将以上代码追加到.bashrc中。

    ccsm

在弹出的窗口配置

![wsl-unity-1](/img/wsl-unity-1.png)
![wsl-unity-2](/img/wsl-unity-2.png)
![wsl-unity-3](/img/wsl-unity-3.png)

* 启动桌面

    compiz

## 结果

配置完成后，启动XLaunch后，我选择Multiple windows, Display Number 为0. 结果是我并不能访问ubuntu桌面。就像下图配置：

![muti_window](/img/muti_window.png)

但后面我选择为One large window时，ubuntu18.04LTS和ubuntu16.04LTS都成功了。如下图配置

![single_window](/img/single_window.png)

最终都成功了，耗费了我不少时间。

* gnome-terminal

* firefox