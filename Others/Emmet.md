


## [Emmet](https://docs.emmet.io/)缩写插件

Emmet工具集的核心是缩写，可以通过缩写快速生成结构代码块，是前端写HTML和CSS的神器。很多编辑器都支持安装Emmet插件。

如下列一行可以生成一个代码块

`#page>div.logo+ul#navigation>li*5>a{Item $}`

生成如下:

```html
    <div id="page">
    <div class="logo"></div>
    <ul id="navigation">
        <li><a href="">Item 1</a></li>
        <li><a href="">Item 2</a></li>
        <li><a href="">Item 3</a></li>
        <li><a href="">Item 4</a></li>
        <li><a href="">Item 5</a></li>
    </ul>
    </div>
```

## [语法](https://docs.emmet.io/abbreviations/syntax/)

Emmet使用与CSS选择器相似的语法。

### 子项(Child): >

    div>ul>li

生成如下:

```html
    <div>
    <ul>
        <li></li>
    </ul>
    </div>
```

### 兄弟(Sibling): +

    div+p+bq

生成如下:

    <div></div>
    <p></p>
    <blockquote></blockquote>

### 爬出(Climb-up): ^

    div+div>p>span+em^bq

生成如下:

```html
    <div></div>
    <div>
        <p><span></span><em></em></p>
        <blockquote></blockquote>
    </div>
```

    `div+div>p>span+em^^^bq`

生成如下:

```html
    <div></div>
    <div>
        <p><span></span><em></em></p>
    </div>
    <blockquote></blockquote>
```

### 复制(Multiplication): *

    ul>li*5

生成如下:

```html
    <ul>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    </ul>
```

### 成组(Grouping): ()

    div>(header>ul>li*2>a)+footer>p

生成如下:

```html
    <div>
    <header>
        <ul>
            <li><a href=""></a></li>
            <li><a href=""></a></li>
        </ul>
    </header>
    <footer>
        <p></p>
    </footer>
    </div>
```

### 属性操作符

属性操作符可以修改输出元素的属性。例如，在HTML和XML中，可以快速添加生成元素的class属性。

#### ID and CLASS

在Emmet中，可以使用和CSS中一样的语法为指定元素添加属性

    div#header+div.page+div#footer.class1.class2.class3

生成如下:

```html
    <div id="header"></div>
    <div class="page"></div>
    <div id="footer" class="class1 class2 class3"></div>
```

### 自定义属性

就像在CSS中一下，可以使用[attr]标记给元素添加自定义属性。

    td[title="Hello world!" colspan=3]

输出:

    <td title="Hello world!" colspan="3"></td>

* 可以写任意多的属性
* 可以不写属性值: `td[colspan title]`会生成`<td colspan"" title="">`.

### 项号(Item numbering): $

    ul>li.item$*5

输出

```html
    <ul>
    <li class="item1"></li>
    <li class="item2"></li>
    <li class="item3"></li>
    <li class="item4"></li>
    <li class="item5"></li>
    </ul>
```

可以使用多个$  

`ul>li.item$$$*5`  

输出

```html
<ul>
    <li class="item001"></li>
    <li class="item002"></li>
    <li class="item003"></li>
    <li class="item004"></li>
    <li class="item005"></li>
</ul>
```

#### 改变行号和方向

使用@修改符，可以改变行号方向和起点。

例如，要改变方向，在$ 后添加@_

`ul>li.item$@_*5`

输出:

```html
<ul>
    <li class="item5"></li>
    <li class="item4"></li>
    <li class="item3"></li>
    <li class="item2"></li>
    <li class="item1"></li>
</ul>
```

改变起点，添加@N 

`ul>li.item$@3*5`

输出

```html
<ul>
    <li class="item3"></li>
    <li class="item4"></li>
    <li class="item5"></li>
    <li class="item6"></li>
    <li class="item7"></li>
</ul>
```

可以同时使用这些修改符

`ul>li.item$@_3*5`

输出

```html
<ul>
    <li class="item7"></li>
    <li class="item6"></li>
    <li class="item5"></li>
    <li class="item4"></li>
    <li class="item3"></li>
</ul>
```

### 文本(Text): {}

`a{click me}`

输出

`<a href="">Click me</a>`

## [元素类型(Element types)](https://docs.emmet.io/abbreviations/types/)

在HTML/XML标签中，一些特定元素的缩写会被转换为元素预定义的形式: `<a href=""></a>` 和 `<img src="" alt=""/>`. Emmet 是如何知道的呢？

所有的Emmet元素定义存储在[snippets.json](https://github.com/emmetio/emmet/blob/master/lib/snippets.json)文件中以如下格式。

```json
{
    "html": {
        "abbreviations": {
            "a": "<a href=\"\">",
            "link": "<link rel=\"stylesheet\" href=\"\" />"
            ...
        },
        "snippets": {
            "cc:ie6": "<!--[if lte IE 6]>\n\t${child}|\n<![endif]-->"
            ...
        }
    },

    "css": {
        ...
    }
}
```

## 隐式标签名(Implicit tag names)

例如.content 扩展为 `<div class="content"></div>`.

### How it works

当你扩展缩写时，Emmet试图获取上下文。例如，HTML 元素。如果成功获得上下文，Emmet会使用它的名字解决隐式名字。

## 随机文本生成器("Lorem Ipsum" generator)

"[Lorem ipsum](http://www.lipsum.com/)" 脏文本被很多web开发者用来测试他们的HTML 模板像真实数据。

lorem 不仅是一个片段--它实际是一个生成器，每次扩展它，它都会生成30字的脏文本，分成几个句子。

可以明确生成多少词。lorem100 生成100个词的脏文本。

## [CSS 缩写](https://docs.emmet.io/css-abbreviations/)

Emmet为CSS属性提供了缩写，也为属性定义了很多预定义的代码段。

如m10 转换为 `margin: 10px`. m-10-20 转换为 `margin: -10px -20px`.

    m1.5ex -> margin: 1.5ex
    m10foo -> margin: 10foo

### 值别名

* p -> %
* e -> em
* x -> ex

如下实例

* w100p -> width: 100%
* m10p30e5x -> margin: 10% 30em 5ex

### 颜色值

* #1 -> #111111
* #e0 -> #e0e0e0
* #fc0 -> #ffcc00

### !important modifier

p!+m10e!

输出：

```CSS
padding:  !important;
margin: 10em !important;
```

## 动作技巧([Actions](https://docs.emmet.io/actions/))

### [扩展缩写](https://docs.emmet.io/actions/expand-abbreviation/)

### 匹配选择([Balance](https://docs.emmet.io/actions/match-pair/))

按标签对块进行配置  
向外匹配
    Ctrl+ D  
向内匹配  
    Shift + Ctrl + D

### [Go to Matching Pair](https://docs.emmet.io/actions/go-to-pair/)

Ctrl + T


