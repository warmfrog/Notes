


## Bash

Bash(Bourne Again Shell), 在linux发行版中最常用，一般是默认的Shell。扩展名为.sh。

编写脚本时，首先在文件头添加一下文本，告诉操作系统要用的解释器。

```bash
    #!/bin/bash
```

### 变量

* 定义变量

```bash
    url="booksp.cn"
```

变量名和等号之间不能有空格

* 用语句给变量赋值

```bash
    for file in `ls /etc`
    or
    for file in $(ls /etc)
```

* 使用变量，在变量名前面加美元符号即可。

```bash
    echo $url
    or
    echo ${url}
```

变量名外的花括号是可选的，加括号是为了帮助解释器识别变量的边界。例如：

```bash
    for skill in Ada Coffe Action Java; do
        echo "I am good at ${skill} Script"
    done
```

已定义的变量可以重新定义

* 只读变量

```bash
    #!/bin/bash
    url="booksp.cn"
    readonly url
```

* 删除变量

```bash
    unset variable_name
```

例如：

```bash
    url="booksp.cn"
    unset url
```

### 变量类型

* 局部变量: 在脚本或命令中定义，仅仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量

* 环境变量： 所有的程序，包括shell启动的程序，都能访问环境变量

* shell变量： shell程序设置的特殊变量，一部分为环境变量，一部分为局部变量。

### Shell字符串

字符串可以用单引号，也可以用双引号，亦可以不用。

* 单引号

```bash
    str='this is a string'
```

单引号的限制：

* 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的
* 单引号字符串不能出现不成对的单引号

* 双引号

```bash
    name='booksp'
    str="Hello, \"$name\"! \n"
    echo -e $str
```

双引号的优点:

* 双引号里可以有变量
* 双引号里可以有转义字符

* 拼接字符串

```bash
    #!/bin/bash

    url='booksp'
    greeting="hello, "$url"!"
    greeting1="hello, "${url}"!"
    echo $greeting $greeting1

    greeting2='hello,'$url'!'
    greeting3='hello,$url!'
    echo $greeing2 $greeting3
```

![result](../img/shellstr.png)

* 获取字符串长度

```bash
    string="abcd"
    echo ${#string}
```

* 提取子字符串

```bash
    string="www.booksp.cn"
    echo ${string:1:4}
```

* 查找字符串

查找i或o的位置

```bash
    string="booksp.cn is a good site"
    echo `expr index "$string" io`
```

### Shell 数组

bash 支持一维数组，不支持多维数组，下标从0开始

例如:

```bash
    array_name=(value0 value1 value2 value3)
```

或者

```bash
    array[0]=value0
    array[1]=value1
    array[2]=value2
```

* 读取数组

读取单个元素

    value=${array_name[n]}

读取所有元素使用@

    echo ${array_name[@]}

* 获取数组长度

    length=${#array_name[@]}

获取单个元素长度

    length=${#array_name[n]}

### Shell 注释

以# 开头的就是注释

## Shell 传递参数

脚本内获取参数的格式为: $n, n 代表数字，$1 表示第一个参数， $2 表示第二个参数，其中 $0 表示执行的文件名。

### 参数说明

| 符号 | 说明 |
| :-- | :------------------------------------------------ |
| $# | 传递给脚本的参数个数 |
| $* | 以单字符串显示传递给脚本的所有参数 |
| $$ | 脚本当前进程ID |
| $! | 后台运行的最后一个进程的ID |
| $@ | 与$* 相同，但使用时加引号 |
| $- | 显示Shell使用的当前选项，与set命令功能相同 |
| $? | 显示命令的退出状态。0表示没有错误，其他值表示有错误 |

#### $* 与 $@ 的区别

$* 表示所有参数为一个组合的参数

$@ 表示所有参数的集合

## Shell 基本运算符

原生bash 不支持简单的数学运算，但是可以通过其他命令实现，例如awk 和 expr, expr 是表达式计算工具。

    val=`expr 2 + 2`
    echo "sum: $val"

* 算术运算符

     +, -, *, /, %, =, ==, !=

* 关系运算符

    -eq, -ne, -gt, -lt, -ge, -le

* 布尔运算符

    ! 非运算, -o 或运算, -a 与运算

* 逻辑运算符

    &&, ||

* 字符串运算符

| 符号 | 说明 |
| :--- | :--------------------|
| = | 两个字符串相等返回true |
| != | 两个字符串不等返回true |
| -z | 字符串长度为0返回true |
| -n | 字符串长度不为0返回true |
| str | 字符串不为空返回true |

* 文件测试运算符

    | 操作符 | 说明 | 举例 |
    | :-------| :-------------------------------------| :---------------------|
    | -b file | 检测文件是否是块设备文件，是则返回true | [-b $file] 返回 false |
    | -c file | 检测文件是否是字符设备文件，是则返回true | [-c $file] 返回 false |
    | -d file | 检测文件是否是目录，是则返回true | [-d $file] 返回 false |
    | -f file | 检测文件是否是普通文件(既不是目录，也不是设备文件),是则返回true | [-f $file] 返回 false |
    | -g file | 检测文件是否设置了SGID位,是则返回true | [-g $file] 返回 false |
    | -k file | 检测文件是否设置了粘着位(Stick Bit),是则返回true | [-k $file] 返回 false |
    | -p file | 检测文件是否是有名管道,是则返回true | [-p $file] 返回 false |
    | -u file | 检测文件是否设置了SUID位,是则返回true | [-u $file] 返回 false |
    | -r file | 检测文件是否可读,是则返回true | [-r $file] 返回 false |
    | -w file | 检测文件是否可写 ,是则返回true | [-w $file] 返回 false |
    | -x file | 检测文件是否可执行 ,是则返回true | [-x $file] 返回 false |
    | -s file | 检测文件是否为空(文件大小是否大于0) ,是则返回true | [-s $file] 返回 false |
    | -e file | 检测文件是否存在(包括目录) ,是则返回true | [- $file] 返回 false |

### 示例

```bash
    #!/bin/bash
    # author:warmfrog
    # url:www.booksp.cn

    file="/home/warmfrog/test.sh"
    if [-r $file]
    then
        echo "文件可读"
    else
        echo "文件不可读"
    fi
    if [-w $file]
    then
        echo "文件可写"
    else
        echo "文件不可写"
    fi
    if [-x $file]
    then
        echo "文件可执行"
    else
        echo "文件不可执行"
    fi
    if [-f $file]
    then
        echo "文件为普通文件"
    else
        echo "文件为特殊文件"
    fi
    if [-d $file]
    then
        echo "文件是个目录"
    else
        echo "文件不是个目录"
    fi
    if [-s $file]
    then
        echo "文件不为空"
    else
        echo "文件为空"
    fi
    if [-e $file]
    then
        echo "文件存在"
    else
        echo "文件不存在"
    fi
```

## echo 命令

* 显示换行

    echo -e "OK! \n" # -e 开启转义
    echo "It is a test"

* 显示不换行

    echo -e "OK! \c" # -e 开启转义 \c 不换行

* 结果定向到文件

    echo "It is a test" > myfile

* 原样输出字符串，不转义或去变量(用单引号)

    echo '$name\"'

* 显示命令执行结果

    echo `date`

## Shell printf 命令

printf 命令默认不换行，echo默认换行。

格式

    pintf format-string [arguments...]

实例

    printf "Hello, Shell\n"

实例2

    #!/bin/bash
    # author: booksp
    # url: www.booksp.cn

    printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg
    printf "%-10s %-8s %-4s.2f\n" 郭靖 男 66.1234
    printf "%-10s %-8s %-4s.2f\n" 杨过 男 48.6543
    printf "%-10s %-8s %-4s.2f\n" 郭芙 女 47.9876

实例3

    printf "%d %s\n" 1 "abc"
    printf '%d %s\n' 1 "abc"
    pirntf %s abcdef
    printf %s abc def
    printf "%s\n" abc def
    printf "%s %s %s\n" a b c d e f g h i j
    printf "%s and %d \n"

| 转义序列 | 说明 |
| :-------| :----|
| \a | 警告|     |
| \b | 后退|     |
| \c |    |      |
| \f |    |      |
| \n |    |      |
| \r |    |      |
| \t |    |      |
| \v |    |      |
| \\ |    |      |
| \ddd    |      |
| \0ddd   |      |

## Shell test 命令

* -eq
* -ne
* -gt
* -ge
* -lt
* -le

实例

    num1=100
    num2=100
    if test $[num1] -eq $[num2]
    then
        echo '相等'
    else
        echo '不等'
    fi

* []执行基本的算术运算

    a=5
    b=6
    result=$[a+b]
    echo "result: $result"

### 字符串测试

* = 
* !=
* -z
* -n

实例

    str1='booksp'
    str2='booksp2'
    if test $str1 = $str2
    then
        echo '相等'
    else
        echo '不等'
    fi

## 流程控制

### if else

#### if

    if condition
    then
        command1
        command2
        ...
    fi

写成一行

    if [$(ps -ef | grep -c "ssh") -gt 1]; then echo "true"; fi

#### if else

    if condition
    then
        command1
        command2
        ...
    else
        command
    fi

#### if else-if else

    if condition1
    then
        command1
    elif condition2
    then
        command2
    else
        command3
    fi

实例

    a=10
    b=20
    if [$a ==  $b]
    then
        ehco "a=b"
    elif [$a -gt $b ]
    then
        ehco "a>b"
    elif [$a -lt $b]
    then
        echo "a<b"
    else
        echo "null"
    fi

if else 语句经常与test命令一起使用

```bash
    num1=$[2*3]
    num2=$[1+5]
    if test $[num1] -eq $[num2]
    then
        echo 'eq'
    else
        echo 'nq'
    fi
```

### for 循环

```bash
    for((assignmeng;condition;next));do
        command1;
        command2;
        command3;
        ...
    done;
```

通常情况下shell变量要加$,但for的(())不需要

```bash
    for((i=1;i<=5;i++>));do
        echo "第 $i 次调用";
    done;
```

### foreach 循环

```bash
    for var in item1 item2 ... itemN
    do
        command1
        command2
        ...
        commandN
    done
```

写成一行

```bash
    for var in item1 item2 ... itemN; do command1; command2... done;

    for loop in 1 2 3 4 5
    do 
        echo "the value is: $loop"
    done

    for str in 'This is a string'
    do
        echo $str
    done
```

### while 循环

```bash
    while condition
    do
        command
    done
```

实例

```bash
    #!/bin/bash
    int=1
    while(( $int<=5))
    do
        echo $int
        let "int++"
    done
```

使用时使用了 Bash let 命令，它用于执行一个或多个表达式，变量中不需要加上 $
来表示变量。

```bash
    echo 'ctrl-d to exit'
    echo -n 'your favorite film name: '
    whire read film
    do
        echo '$film is a good film'
    done
```

* 无限循环

```bash
    while :
    do
        command
    done
```

or

```bash
    while true
    do
        command
    done
```

or

    for(( ; ;))

### until 循环

until 循环一直执行指导条件为true

```bash
    until condition
    do
        command
    done
```

实例

```bash
    a=0

    until [! $a -lt 10]
    do
        echo $a
        a=`expr $a + 1`
    done
```

### case

```bash
    case var in 
    模式1)
        command1
        command2
        ...
        commandN
        ;;
    模式2)
        command1
        command2
        ...
        commandN
    esac
```

case 使用方式如上，取值后面必须为单词in，每一模式必须以右括号结束。取值可以为变量或常数。如无匹配模式，则使用* 号捕获该值，再执行命令

```bash
    echo 'input 1~4:'
    read aNum
    case $aNum in
    1) echo '你选择了1'
    ;;
    2) echo '你选择了2'
    ;;
    3) echo '你选择了3'
    ;;
    4) echo '你选择了4'
    ;;
    *) echo '你选择了1~4之间的数字'
    ;;
```

### 跳出循环

#### break命令

允许跳出所有循环

实例

```bash
    while :
    do
        echo -n "input 1~5:"
        read aNum
        case $aNum in
            1|2|3|4|5) echo "你输入的数字为 $aNum!"
            ;;
            *) echo "illegal input! game over"
                break
            ;;
        esac
    done
```

#### continue 命令

跳出当前循环

```bash
    while :
    do echo -n 'input 1~5:'
        read aNum
        case aNum in
            1|2|3|4|5) echo "your input is $aNum!"
            ;;
            *) echo "illegal input!"
                continue
                echo 'game over'
            ;;
```

#### esac 表示case的结束标记

## Shell 函数

```bash
    [ function ] funcname [()]
    {
        action;
        [return int;]

    }
```

* 可以使用 function fun()定义， 也可以直接func()定义，不带任何参数

* 加 return 返回参数，如果不加，则以最后一条命令运行结果返回， return 后跟数值 0-255

```bash
    demoFunc(){
        echo "func"
    }
    echo "start"
    demoFunc
    echo "end"

    funWithReturn(){
        ehco "input a number:"
        read aNum
        echo "input another number:"
        read anotherNum
        return $(($aNum+$anotherNum))
    }
    funWithReturn
    echo "result $? !"
```

函数返回值在调用该函数后通过$?来获得

### 函数参数

```bash
    funWithParam(){
        echo "param1: $1"
        echo "param2: $2"
        echo "param3: $3"
        echo "param10: ${10}"
        echo "param11: ${11}"
        echo "param number: $#"
        echo "all param: $*"
    }
```

注意，$n 方式不能获取第10个参数，当n>=10时，需要使用${n}获取参数。

## Shell 输入输出重定向

* command > file
* command < file
* command >> file
* n > file  将文件描述符为n的文件重定向到file
* n >> file 
* n >& m 将输出文件m和n合并
* n <& m 将输入文件m和n合并
* << tag 将开始标记tag和结束标记tag之间的内容作为输入

### 输出重定向

    command1 > file1

* stdin, 文件描述符0
* stdout, 文件描述符1
* stderr, 文件描述符2

    command 2 > file
    command 2 >> file
    command > file 2>&1
    command >> file 2>&1
    command < file1 >file2

* 将delimiter之间的内容作为输入传递给command

    command << delimiter
        docment
    delimiter

    wc -l << EOF
        welcome
        to 
        booksp.cn
    EOF
    3       #结果为3

    cat << EOF
    welcome 
    to 
    booksp.cn
    EOF

### /del/null

/del/null 是一个特殊的文件，写入到它的内容都会被丢弃,可以使用它来屏蔽输出

    command > /dev/null
    command > /dev/null 2>&1

## Shell 文件包含

语法

    . filename # (.)号与文件名之间有空格

or

    source filename

test1.sh

    #!/bin/bash
    # test1.sh

    url="www.booksp.cn"

test2.sh

```bash
    #!/bin/bash
    # test2.sh

    . ./test1.sh

    # or
    # source ./test1.sh

    echo "url: $url"
```

添加权限并执行

    chmod +x test2.sh
    ./test2.sh
