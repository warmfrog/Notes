


## 查看配置信息

    git config --list

## 本地配置

    git config --global user.name "warmfrog"
    git config --global user.email "1594914459@qq.com"

## 创建新仓库

    echo "# ShareBook" >> README.md
    git init
    git add README.md
    git commit -m "first commit"
    git remote add origin https://github.com/warmfrog/Sharebook.git
    or
    git remote add origin git@github.com:warmfrog/Sharebook.git
    git push -u origin master

## push 已存在的仓库

    git config --global user.name "warmfrog"
    git config --global user.email "1594914459@qq.com"

    git remote add origin https://github.com/warmfrog/ShareBook.git
    git push -u origin master

## git push 每次都需要输入用户名和密码

为了不每次都输入用户名和密码，删除以https提交的方式，然后修改提交方式

    git remote rm origin
    git remote add orign git@github.com:warmfrog/Sharebook.git

再次push时

    git push -u origin master

后面就可以使用

    git push

来直接push了

## 修改项目后的push



### 修改文件后push

将clone下来的项目修改后，如果需要push，则先将修改后的文件add，commit后，再push

    git add 修改的文件
    git commit -m "修改的内容提示"
    git push

### 删除后文件后push

    git rm 删除的文件
    git commit -m "删除的信息"
    git push

#### 批量删除或者修改后

    git commit -a
    git push

## 隐藏本地改变，并 pull 远程仓库

    git stash

当我们改变本地文件后，使用git pull命令时会有冲突，这时可以用stash隐藏改变，然后pull。pull之后可以

    git stash apply 恢复改变
    git stash list  列出改变
    git stash drop  删除改变
    git help stash  查看更多stash命令

## 分支

创建分支

    git branch hello

转到分支

    git checkout hello

查看分支

    git branch

查看所有分支，包括远程

    git branch -a

删除远程分支

    git push origin :remote_branch_name
    git push orinin :issu8