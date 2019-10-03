# [Bean Validation][0]

Validating data 是一个应用中常见的任务，从展示层到持久层。通常相同的验证在每一层被实现，被证明是消耗时间的，容易出错的。为了避免每一层的验证，开发者通常直接绑定验证到 domain model，cluttering domain classes，使用 validation code，实际上，是类的 metadata。

JSR 定义了 JavaBean validation 的 metadata 和 API。默认的 metadata 源是 annotaions，通过 XML validation 描述符的使用来重写和扩展 metadata 的能力。



[0]: https://beanvalidation.org/2.0/spec/

