


## 通信domain

* UNIX(AF_UNIX) 同一主机应用程序之间通信
* IPv4(AF_INET) ipv4网络连接的主机间的通信
* IPv6(AF_INET6) IPV6网络连接的主机间的通信

AF表示地址族(address family), PF表示协议族(protocol family).

每个socket实现都提供了至少两种socket，流(STREAM)和数据报(SOCK_DGRAM).

| 属性 |流 (socket) | 数据报(SOCK_DGRAM) |
| :---  | :---| :---- |
| 可靠传递 | 是 | 否 |
| 消息边界保留 | 否 | 是 |
| 面向连接 | 是 | 否 |

流socket(SOCK_STREAM)提供了一个可靠的双向的字节流通信信道。

* 可靠地：保证发送者发送的数据会完整无缺地到达接收应用程序
* 双向的：表示数据可以在两个socket之间的任意方向传输。
* 字节流： 表示与管道一样不存在消息边界的概念

### socket 系统调用

* socket() 系统调用创建一个新socket.
* bind() 系统调用将一个socket绑定到地址上.
* listen() 系统调用允许一个流socket接受来自其他socket的接入连接.
* accept() 系统调用在一个监听socket接受来自另一个对等应用程序的连接,并可选的返回对等socket的地址
* connect() 系统调用建立与另一个socket的连接.


