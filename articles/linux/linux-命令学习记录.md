# linux-命令学习记录

### rsync

rsync 命令用于在两台主机或单太主机的两个目录同步文件。同样是一个强大而又危险的命令，强大的是同步文件的能力，危险的是一不小心，你的目的地目录的文件会
被全部删除，除非你有绝对的把握，否则不要轻易加 --del 参数。

```bash
rsycn -u -v -r --del ./Books root@server:/root/Books
```

### wc

wc 字数统计工具

    echo "this is a test" >> test.txt
    wc test.txt

![result](/img/wc-echo-1.png)

    echo "this is a test" >> test.txt
    wc test.txt

![result](/img/wc-echo-2.png)
