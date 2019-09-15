


## 注册表

[维基百科解释](https://en.wikipedia.org/wiki/Windows_Registry)

Window Registry是一个层级数据库用来存储Microfot windows操作系统和应用选择使用的(registry)注册表。内核，设备驱动，服务，安全账户管理，和用户接口都使用注册表。

简单的说，注册表或者Windows注册表包含信息，设置，选项，和其他值，被程序和安装在windows操作系统上的系统使用。例如，当一个程序安装后，一个子健(subkey)被添加到Windows注册表，包括程序位置，版本，如何启动程序等。

对于Windows应用程序来说，使用注册表不是必须的。例如，.NET Framework 应用使用XML文件配置，便携式应用通常保存他们的配置在执行文件中。

在注册表之前，.INI  文件保存每个程序的设置为文本文件，通常位于共享位置，并不提供多用户场景的用户自定义设置。作为对比，Windows注册表存储所有的设置在一个逻辑仓库.因为基于用户的注册表设置从用户特定路径载入而不是从一个只读的系统位置，注册表允许多用户共享相同的机器，同样允许程序为特权少的用户服务。备份和恢复也被简化，因为这侧标可以通过网络连接提供远程管理、支持，包括脚本，使用标准API,只要远程注册表服务运行，防火墙规则允许。

## 键和值

注册表包含两种基础的元素：键(keys)和值(values).注册表包含于文件夹相似的对象。注册表的值相似与文件，是非容器对象。键可以包含值和子键。键可以通过与windows路径名相似的语法被引用，使用反斜线表示层级。键必须是大小写敏感的名字，不能包含反斜线。

注册表键的层级只能通过一个已知的由内核从存储中预加载的映射到注册表键内容的root key handle，或者在另一个root key的子键内容中，或者映射到一个注册服务或提供入口到它包含的子键和值入口的DLL。

例如。HKEY_LOCAL_MACHINE\Software\Microsoft\Windows 引用了root key HKEY_LOCAL_MACHINE 的子键 Software 的子键的Microsoft的子键Winddows。

一共有7个预定义的 根键(root key)， 根据它们定义在W32 API中的常量传统地命了名，或者同义的缩写(取决于应用).

* HKEY_LOCAL_MACHINE or HKLM
* HKEY_CURRENT_CONFIG or HKCC
* HKEY_CLASSES_ROOT or HKCR
* HKEY_CURRENT_USER or HKCU
* HKEY_USERS or HKU
* HKEY_PERFORMANCE_DATA(只在Windows NT，但是在Windwow注册表编辑器中不可见)
* HKEY_DYNDATA(只在Windows 9x， 在注册表中课件)

就像Windows中的其他文件和服务一样，所有的注册表键可能被权限控制表(access control lists)(ACLS) 限制，取决于用户权限。

每个值可以存储任意长度和编码的任意的数据，但是会与符号类型(定义为数字常量)联系起来定义如何解析这些数据。这些类型如下：

<table class="wikitable">
<caption>List of standard registry value types
</caption>
<tbody><tr>
<th>Type ID</th>
<th>Symbolic type name</th>
<th>Meaning and encoding of the data stored in the registry value
</th></tr>
<tr>
<td>0</td>
<td>REG_NONE</td>
<td>No type (the stored value, if any)
</td></tr>
<tr>
<td>1</td>
<td>REG_SZ</td>
<td>A <a href="/wiki/String_(computer_science)" title="String (computer science)">string</a> value, normally stored and exposed in <a href="/wiki/UTF-16" title="UTF-16">UTF-16</a>LE (when using the Unicode version of Win32 API functions), usually terminated by a NUL character
</td></tr>
<tr>
<td>2</td>
<td>REG_EXPAND_SZ</td>
<td>An "expandable" string value that can contain environment variables, normally stored and exposed in <a href="/wiki/UTF-16" title="UTF-16">UTF-16</a>LE, usually terminated by a NUL character
</td></tr>
<tr>
<td>3</td>
<td>REG_BINARY</td>
<td>Binary data (any arbitrary data)
</td></tr>
<tr>
<td>4</td>
<td>REG_DWORD / REG_DWORD_LITTLE_ENDIAN</td>
<td>A <a href="/wiki/Dword_(Computer)" class="mw-redirect" title="Dword (Computer)">DWORD</a> value, a 32-bit <a href="/wiki/Signedness" title="Signedness">unsigned</a> <a href="/wiki/Integer" title="Integer">integer</a> (numbers between 0 and 4,294,967,295 [2<sup>32</sup> – 1]) (little-<a href="/wiki/Endianness" title="Endianness">endian</a>)
</td></tr>
<tr>
<td>5</td>
<td>REG_DWORD_BIG_ENDIAN</td>
<td>A <a href="/wiki/Dword_(Computer)" class="mw-redirect" title="Dword (Computer)">DWORD</a> value, a 32-bit <a href="/wiki/Signedness" title="Signedness">unsigned</a> <a href="/wiki/Integer" title="Integer">integer</a> (numbers between 0 and 4,294,967,295 [2<sup>32</sup> – 1]) (big-<a href="/wiki/Endianness" title="Endianness">endian</a>)
</td></tr>
<tr>
<td>6</td>
<td>REG_LINK</td>
<td>A symbolic link (UNICODE) to another registry key, specifying a root key and the path to the target key
</td></tr>
<tr>
<td>7</td>
<td>REG_MULTI_SZ</td>
<td>A multi-string value, which is an ordered list of non-empty <a href="/wiki/String_(computer_science)" title="String (computer science)">strings</a>, normally stored and exposed in <a href="/wiki/UTF-16" title="UTF-16">UTF-16</a>LE, each one terminated by a NUL character, the list being normally terminated by a second NUL character.
</td></tr>
<tr>
<td>8</td>
<td>REG_RESOURCE_LIST</td>
<td>A resource list (used by the <i>Plug-n-Play</i> hardware enumeration and configuration)
</td></tr>
<tr>
<td>9</td>
<td>REG_FULL_RESOURCE_DESCRIPTOR</td>
<td>A resource descriptor (used by the <i>Plug-n-Play</i> hardware enumeration and configuration)
</td></tr>
<tr>
<td>10</td>
<td>REG_RESOURCE_REQUIREMENTS_LIST</td>
<td>A resource requirements list (used by the <i>Plug-n-Play</i> hardware enumeration and configuration)
</td></tr>
<tr>
<td>11</td>
<td>REG_QWORD / REG_QWORD_LITTLE_ENDIAN</td>
<td>A <a href="/wiki/Qword" class="mw-redirect" title="Qword">QWORD</a> value, a 64-bit integer (either big- or little-endian, or unspecified) (introduced in <a href="/wiki/Windows_XP" title="Windows XP">Windows XP</a>)
</td></tr></tbody></table>

## Root keys

层级数据库root层的键通常根据它们的API定义命名，所有的以HKEY开头。常用的缩写为3到4个字母以HK开头(例如HKCU 和 HKLM)。理论上，它们是预定义的把手(handles)(用已知的常量赋值)来明确键，不是保存在内存中，就是在本地文件系统的文件中存储由系统内核在启动的时候加载，然后在本地系统运行时所有进程共享，或者当用户登录系统开始一个用户会话时载入并映射到所有进程。

HKEY_LCOAL_MACHINE(本机特定配置数据)和HKEY_CURRENT_USER(用户特定配置数据)节点之间有相似的结构；用户应用典型的查找它们的配置通过首先从"HKEY_CURRENT_USER\Software\Vendor's name\Application's name\Version\Setting name"中查找，如果没有找到，继续查找在HKEY_LOCAL_MACHINE key相同的位置。然而，不同的策略可以应用在管理员实施的策略设置中，HKLM优先于HKCU. Windows Logo Program 对于可能的不同的用户数据存储有不同的策略，最少优先权会被采用，这样，使用一个应用，管理员权限不是必须的。

### HKEY_LOCAL_MACHINE(HKLM)

## 注册表编辑器

对于已安装的应用与每个用户和应用单独配置，注册表保存了操作系统重要的配置信息。一个在注册表上对操作系统无心的修改可能造成不可以损伤的破坏，所以通常只有安装程序在安装、配置或者移除的时候才会改变注册表数据库。如果用户想要人工修改注册表，Microsoft推荐改变之前先备份注册表。当一个程序从控制面板移除后，它可能没有被完全移除，用户必须人工检查程序文件目录。在此之后，用户需要人工移除注册表上对此程序文件的引用。