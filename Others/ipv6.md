


# IPV6

## [IPv6 特点](https://www.tutorialspoint.com/ipv6/ipv6_features.htm)

### 大的地址空间

使用128比特表示,近似3.4* 10^38 个地址.

### 简化的头部

### 端到端的链接

每个系统现在都有独特的IP地址,可以通过直接互联网传输而不用NAT和其他转换组件. IPv6完全实现后,每个主机可以直接到达网络上的其他主机,没有防火墙,组织政策的限制.

### 自动配置

IPv6同时支持有状态的和无状态的主机设备自动配置. 这种方式,DHCP服务器的缺失不会中断内部端沟通.

### 更快的前向和路由

简化了头部将不必要的信息, 头部第一部分的信息足够路由器做决定

### IPSec

IP安全

### 没有广播

### [任播支持](Anycast Support)

### 移动性

不管你在地球上的任何地方,都保持相同的IPv6地址,这个特点充分利用了IP配置和扩展头.

### 优化特权支持

### 优化传输

每个设备都有一个独特的IP地址.这个方法保存IP地址,NAT不在需要.所以设备之间可以直接通信,列如,VoIP和任何流媒体可以更有效率. 

另外,头负载更少,路由器能够更快的做绝定

### 扩展性

## IPv6地址模式

### 单一传播(Unicast)

### 多路传送(Multicast)

### 任播(Anycast)

在这种模式下,多台接口(主机)被赋予了相同的任播地址.当一个主机想要与一个任播地址通信时,它发送一个单播消息. 在复杂的路由方法的帮助下,这个单播消息被传递到离发送者路由花费最近的主机.

## [IPv6-地址类型&格式](https://www.tutorialspoint.com/ipv6/ipv6_address_types.htm)

### 地址结构

128位地址被分为8个16bits的块.每个块被转换为4位16进制的数字,以冒号:作为区分.
    0010000000000001 0000000000000000 0011001000111000 1101111111100001 0000000001100011 0000000000000000 0000000000000000 1111111011111011

    2001:0000:3238:DFE1:0063:0000:0000:FEFB

即使转换为16进制格式,IPv6地址依然很长.IPv6提供一些规则来缩短地址,规则如下:

1. 去除前面的零:

在第5块,0063,前面的两个0可以省略如下:

    2001:0000:3238:DFE1:63:0000:0000:FEFB

2. 如果两个块或以上包含连续的0,省略他们,替代为双冒号::, 例如第6块和第7块:

    2001:0000:3238:DFE1:63::FEFB

如果仍然有块都为0,则可以使用单个0缩短:

    2001:0:3238:DFE1:63::FEFB

### 接口ID

IPv6有三种不同类型的单播地址模式.地址的后半部分(后64位)总是表示接口ID. 系统MAC地址由48bit组成表示为16进制形式. MAC地址被认为是世界范围独一无二的. 接口IP充分利用了MAC地址的独特性.一个主机可以自动配置接口IP通过使用IEEE的扩展独特标识符形式(Extended Unique Identifier(EUI-64)).首先,一个主机将自己的MAC地址平均分为两等份. 然后16进制值 0xFFFE 插入其中,组成EUI-64接口ID

    001122 ABCDEF
    001122 FFFE ABCDEF

为了转换EUI-64到IPv6的接口标识符:

## [IPv6-Special Addresses](https://www.tutorialspoint.com/ipv6/ipv6_special_addresses.htm)

下面是一些保留地址

| IPv6 Address | Meaning |
| :------------| :-------|
| ::/128       | 未明确的地址 |
| ::/0         | 默认路由 |
| ::1/128      | 回环地址 |

* 0:0:0:0:0:0:0:0/128 没有特别说明,据说是未明确的地址.为了简化, 表示为 ::/128

* 在IPv4中,地址0.0.0.0与网络掩码0.0.0.0 表示默认路由. 相同的概念被应用到IPv6中, 地址 0.0.0.0.0.0.0.0 与掩码都为0 表示默认路由. 应用IPv6规则,这个地址被亚索为 ::/0.

* 在IPv4中,回环地址表示127.0.0.1-127.255.255.255. 但是IPv6中,只有0:0:0:0:0:0:0:1/128表示回环地址,压缩为::1/128.

### 为路由协议保留多播地址

### 为路由器/节点保留多播地址

## [IPv6头部](https://www.tutorialspoint.com/ipv6/ipv6_headers.htm)

IPv6固定头部40字节长

### 扩展头

## [IPv6沟通](https://www.tutorialspoint.com/ipv6/ipv6_communication.htm)

在IPv4中,一个主机想要与网络上的另一个主机沟通,需要一个ip地址(通过DHCP方式或者人工设置). 只要一个主机有一个有效的IP地址,它就能与子网下的任何主机交流.为了在第三层交流,一个主机必须知道其他主机的IP地址.在一个连接上交流,连接通过各种嵌入的硬件MAC地址.为了知道一个已知IP主机的MAC地址,一个主机发送ARP广播请求,目的主机发送回它的MAC地址.

在IPv6中没有广播方法.对于IPv6来说, 从DHCP或者人工配置获得IP是不必要的,它会自己配置自己的IP.

ARP被ICMPv6近邻发现协议替代.

### 近邻发现协议(Neighbor discovery Protocol)

在IPv6网络中,一个主机有能力使用一个独特的连接本地地址自动配置IP.一旦一个主机获得一个IPv6地址,它就加入一个多路传播组(multicast groups). 在那个端的所有通信只在那些多播地址中产生.在IPv6中一个主机经历一系列状态:

* 近邻请求(Neighbor Solicitatiion): 在使用人工,DHCP服务器或者自动配置的方法配置了IPv6地址后,主机为它的所有IPv6地址发送一个近邻请求消息(Neighbor Solicitation message) 给 FF02::1/16多播地址,为了知道没有人占据相同的地址.

* 重复地址发现(DAD(Duplicate Address Detection)): 当主机没有在段上听到任何关于近邻发现消息的消息时,它假定在段上不存在重复的地址.

* 近邻推荐(Neighbor Advertisement): 在把地址赋给接口,组好它们运行后,主机再次在段上发送给所有其他主机近邻推荐消息,告诉它们这个IPv6地址已经赋值给它的接口.

一旦一个主机配置完IPv6地址后,它做下列事:

* 路由请求(Router Solicitation): 一个主机在它所在的段上发出一个路由请求多播包(FF02::2/16), 来获得在段上的其他路由器的存在, 它帮助主机配置路由器作为默认网关. 如果它的默认网关下线,主机转移到下一个路由器,使它成为默认网关.

* 路由推荐(Router Advertisement): 当一个路由器收到一个路由请求消息, 它回复主机,在那个连接上告诉它自身的存在.

* 重定向(Redirect): 当路由器接收到路由请求后它知道这对于主机来说不是最好的网关,路由器发送会一个重定向消息告诉主机有一个更好的下一跳(next-hop)路由器可以获得.下一跳(next-hop)是主机将要发送数据到目的地的主机,但是不属于相同的段(segment).

## [IPv6子网IPv6 Subnetting](https://www.tutorialspoint.com/ipv6/ipv6_subnetting.htm)

IPv6的后64位总是表示主机的.

|    Routing Prefix  | Subnet ID | Interface ID|
| :-----------------| :-----------| :---------|
| 48bits            | 16bits      | 64 bits    |

## [从IPv4过度到IPv6](https://www.tutorialspoint.com/ipv6/ipv6_ipv4_to_ipv6.htm)

IPv6不是向后兼容的.为了克服这些缺点,使用一下技术过度到IPv6.

### 双栈路由器(Dual Stack Routers)

一个路由器可以同时安装IPv4和IPv6地址配置接口指向网络相关IP域.

### 管道(Tunneling)

![tunneling img](/img/tunneling.jpg)

### NAT协议转换(NAT Protocol Translation)

![nat img](/img/nat.jpg)

## [IPv6 移动性(Mobility)](https://www.tutorialspoint.com/ipv6/ipv6_mobility.htm)

当一个主机连接到网络,它需要一个IP地址.所有通信都使用那个连接上的IP地址. 只要主机改变物理位置, 也就是说,移动到另一区域/子网/网络/连接,它的ip地址就改变的,所有与老IP地址的通信都不可行了.

IPv6移动性提供了一个方法,主机漫游到不同地方二不用丢失通信和IP地址.

多个实体包含在这个科技中:

* Mobile Node: 需要Ipv6移动性的设备.
* Home Link: 这个连接配置家庭子网前缀,这是移动IPv6设备获得它的家庭地址
* Home Address: 这是移动节点从Home Link 获得的地址.如果移动节点保留在相同的Home Link,各种实体的沟通像平常一样.

* Home Agent: 这是一个路由器扮演这移动节点注册员的角色.Home Agent 连接到Home Link 维持所有移动节点的信息, 他们的家庭地址,他们目前的IP地址.

* Foreign Link: 任何其他连接都不是移动节点的家庭连接.
* Care-of Address: 当一个移动节点联系到一个外部节点,它需要从外部连接子网获取一个新的IP地址.Home Agent 同时维持Home Address 和 Care-of Address的信息. 多个Care-of 地址可以赋值给移动节点,但是任何情况下,只有一个Care-of 地址绑定到Home Address(家庭地址).

* Correspondent Node: 任何Ipv6运许的设备都试图与移动节点进行沟通.

### 移动性操作

当移动节点待在Home Link 中,所有的通信发生在家庭地址内.如下表示

![nat img](/img/MN_in_HL.jpg)

当一个移动节点离开Home Link 连接到 Foreign Link,IPv6的特点开始显现.在连接到Foreign Link后,移动节点从Foreign Link 获得一个IPv6地址.这个地址叫做 Care-of 地址.移动节点发送一个与Care-of地址绑定请求到Home Agent .Home Agent 绑定移动节点的Home Address 和 Care-of Address, 在两者之间建立一个通道(Tunnel).

无论何时 通信记者(Correspondent Node)试图与移动节点(在 Home Address 中的二)建立连接, Home Agent 拦截包并通过已建立的管道转发到移动节点 Care-of 地址.

![nat img](/img/MN_in_FL.jpg)

当Correspondent Node 初始化通信通过发送包给在Home Address上的移动节点,这些包有Home Agent通过管道传输给移动节点.为了路由优化,当移动节点从Correspondent Node接受包时,它不转寄回复给Home Agent. 作为替代,它直接发送包给Corresopndent Node使用Home Address作为源地址. 这模式是可选的,并不默认.

## IPv6传输方法

网络工程社区已经开发了几种方法使网络操作逐渐从IPv4移植到IPv6.有一下三种方法:

* 双栈(Dual Stack),允许在他们的网络上IPv4和IPv6同时工作.

* [Carrier-grade NAT(CGN)](https://en.wikipedia.org/wiki/Carrier-grade_NAT) ,又叫大规模NAT(large-scale NAT(LSN)), 意思是多个居民家庭的网络共享一个公共的IP地址, 居民网络组成一个较大的局域网,通过网络地址转换(NAT)方式介入网络.这种方法是为了应对IPv4地址枯竭的问题.

* 载体传输, 将ipv6的数据报封装,使用ipv4通道传输. 方式有Teredo, ISATAP

