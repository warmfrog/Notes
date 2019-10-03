# [AsciiDoc](http://asciidoc.org/) 学习笔记

## 安装AsciiDoc

### Debian平台安装

```bash
sudo apt install asciidoc-base
```

## User Guide

### 介绍(Introduction)

AsciiDoc是一种文本文件格式,用来写笔记,文档,文章,图书,电子书,PPT,网页,man 页面和博客. AsciiDoc 文件可以被翻译成很多格式: HTML, PDF, EPUB, man page.

AsciiDoc 是高度可配置的: AsciiDoc 源文件语法和后端输出标记都可以被用户自定义和扩展. AsciiDoc 是免费软件, 在GNU 证书下.

### 纵览和示例

你可以写AsciiDoc文件和你写正常文本格式一样, 没有标记标签和奇怪的格式标记. AsciiDoc 文件被设计为直接可读的, 编辑的,打印的, 或者翻译成其他显示格式使用 `asciidoc`命令.

`asciidoc`命令可以翻译AsciiDoc文件到HTML,XHTML 和DocBook 标记. DocBook 可以被预处理成展示格式: HTML, PDF, EPUB, DVI, LaTeX, roff 和 Postript.

## AsciiDoc User Guide <http://asciidoc.org/asciidoc.css-embedded.html>

### AsciiDoc 文件类型

有三种类型的AcciiDoc文件: article, book 和 manpage. 所有的文件类型共享相同的 AsciiDoc 格式,仅有微小的变化.

#### article

用于短的文件,文章和通用的文件. AsciiDoc定义了标准的DocBook文章的前页和后页[节标记模板(section markup templates)](http://asciidoc.org/asciidoc.css-embedded.html#X93)(附录(appendix),概览(abstract),数目(bibliography),词汇表(glossary), index).

#### book

Books 与 article共享相同的格式,但有以下不同:

* 标题在多部份的书中是顶级标题([top level titles](http://asciidoc.org/asciidoc.css-embedded.html#X17))

* 一些节是book特有的: 前言(preface), 版权页标记(colophon)

#### manpage

用来生成roff格式的unix 帮助页.
