


直接将模块打包为jar的这里就不赘述了，这里是从模块中选择部分代码和库文件打包成一个jar文件。

1. 在IDEA 中 打开 Project Structure -> Artifacts -> 点击 + 号 -> jar -> emmpy, 对jar 文件重命名，然后在 OUtput Layout 中添加目录，目录结构为你的报结构，将你要添加的类.class 按报结构放到目录中，然后点击 下方 Create Manifest，自己选择一个目录， 选择主类，类路径就不用选了。

2. 如果没有引用库文件，就可以点击 OK了。Build -> Build Artifact, 选择对应的就好了。如果引用了库文件，则在右面板 Available Elements 中找到对应库， 如 mysql-cononctor.jar, 右击-> Extract into OutPut Root, 点击 OK or Apply 就可以了，然后生成 Artifact.
