## 面试笔记

### 1.选择器的权重和优先级
CSS 选择器有很多，不同的选择器的权重和优先级不一样，对于一个元素，如果存在多个选择器，那么就需要根据权重来计算其优先级。

权重分为四级，分别是：

代表内联样式，如style="xxx"，权值为 1000；
代表 ID 选择器，如#content，权值为 100；
代表类、伪类和属性选择器，如.content、:hover、[attribute]，权值为 10；
代表元素选择器和伪元素选择器，如div、p，权值为 1。
需要注意的是：通用选择器（*）、子选择器（>）和相邻同胞选择器（+）并不在这四个等级中，所以他们的权值都为 0。 权重值大的选择器其优先级也高，相同权重的优先级又遵循后定义覆盖前面定义的情况。...

### 2.JavaScript变量类型

ECMAScript 中定义了 6 种原始类型：
Boolean
String
Number
Null
Undefined
Symbol（ES6 新定义）


根据 JavaScript 中的变量类型传递方式，又分为值类型和引用类型，值类型
变量包括 Boolean、String、Number、Undefined、Null，引用类型包括了 Object 类的所有，如 Date、Array、Function 等。

### 3.列举一下数组常用的方法
合并数组concat()，拼接数组元素join()，截取元素slice()，indexOf()，lastIndexOf()，toString()
Array.prototype.concat()
Array.prototype.copyWithin()
Array.prototype.entries()
Array.prototype.every()
Array.prototype.fill()
Array.prototype.filter()
Array.prototype.find()
Array.prototype.findIndex()
Array.prototype.flat()
Array.prototype.flatMap()
Array.prototype.forEach()
Array.prototype.includes()
Array.prototype.indexOf()
Array.prototype.join()
Array.prototype.keys()
Array.prototype.lastIndexOf()
Array.prototype.map()
Array.prototype.pop()
Array.prototype.push()
Array.prototype.reduce()
Array.prototype.reduceRight()
Array.prototype.reverse()
Array.prototype.shift()
Array.prototype.slice()
Array.prototype.some()
Array.prototype.sort()
Array.prototype.splice()
Array.prototype.toLocaleString()
Array.prototype.toSource()
Array.prototype.toString()
Array.prototype.unshift()
Array.prototype.values()

### 4.前端常用的存储方式

Cookie：用于客户端与服务端通信，也具有本地存储的功能

localStorage，sessionStorage：专门用于存储

区别：

大小：Cookie容量为4K，因为用于客户端与服务端通信，所有http都携带，如果太大会降低效率； localStorage，sessionStorage大小为5M。

失效时间：Cookie会在浏览器关闭时删除，除非主动设置删除时间；localStorage一直都在直到用户主动删除或清除浏览器缓存；sessionStorage在浏览器关闭时删除。



### 5.说说你知道的ES6新特性
- 箭头函数
- Module
- Class
- Set和Map

Set数组去重
```
const unique = (arr) => {
  return [...new Set(arr)]
}

const set = new Set();
[2, 3, 5, 4, 5, 8, 8].forEach(item => set.add(item));

```
- Promise

简单归纳下 Promise：三个状态、两个过程、一个方法

三个状态：pending、fulfilled、rejected
两个过程：
pending→fulfilled（resolve）
pending→rejected（reject）
一个方法：then
当然还有其他概念，如catch、 Promise.all/race

### 6.ES6模块与CommonJS模块的差异

CommonJs 模块输出的是一个值的拷贝，ES6模块输出的是一个值的引用
CommonJS 模块是运行时加载，ES6模块是编译时输出接口
ES6输入的模块变量，只是一个符号链接，所以这个变量是只读的，对它进行重新赋值就会报错

### 7.前端为何要使用构建工具？它解决了什么问题？

何为构建工具
“构建”也可理解为“编译”，就是将开发环境的代码转换成运行环境代码的过程。开发环境的代码是为了更好地阅读，而运行环境的代码是为了更快地执行，两者目的不一样，因此代码形式也不一样。例如，开发环境写的 JS 代码，要通过混淆压缩之后才能放在线上运行，因为这样代码体积更小，而且对代码执行不会有任何影响。总结一下需要构建工具处理的几种情况：

处理模块化：CSS 和 JS 的模块化语法，目前都无法被浏览器兼容。因此，开发环境可以使用既定的模块化语法，但是需要构建工具将模块化语法编译为浏览器可识别形式。例如，使用 webpack、Rollup 等处理 JS 模块化。

编译语法：编写 CSS 时使用 Less、Sass，编写 JS 时使用 ES6、TypeScript 等。这些标准目前也都无法被浏览器兼容，因此需要构建工具编译，例如使用 Babel 编译 ES6 语法。

代码压缩：将 CSS、JS 代码混淆压缩，为了让代码体积更小，加载更快。

### 8.跨域问题，谁限制的跨域，怎么解决

浏览器的同源策略导致了跨域
url 哪些地方不同算作跨域？

协议
域名
端口

用于隔离潜在恶意文件的重要安全机制
[jsonp ，允许 script 加载第三方资源]https://segmentfault.com/a/11...
nginx 反向代理（nginx 服务内部配置 Access-Control-Allow-Origin *）
cors 前后端协作设置请求头部，Access-Control-Allow-Origin 等头部信息
iframe 嵌套通讯，postmessage



### 9.浏览器渲染页面的过程

用户输入 URL 地址
浏览器解析 URL 解析出主机名
浏览器将主机名转换成服务器 ip 地址（浏览器先查找本地 DNS 缓存列表 没有的话 再向浏览器默认的 DNS 服务器发送查询请求 同时缓存）
浏览器将端口号从 URL 中解析出来
浏览器建立一条与目标 Web 服务器的 TCP 连接（三次握手）
浏览器向服务器发送一条 HTTP 请求报文
服务器向浏览器返回一条 HTTP 响应报文
关闭连接 浏览器解析文档
根据 HTML 结构生成 DOM 树
根据 CSS 生成 CSSOM
将 DOM 和 CSSOM 整合形成 RenderTree
根据 RenderTree 开始渲染和展示
遇到<script>时，会执行并阻塞渲染

### 10.说说前端常见性能优化的解决方案


### 11.说一下 vue 的生命周期

`beforeCreate`：在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用
`created`：在实例创建完成后被立即调用
`beforeMount`:在挂载开始之前被调用
`mounted`:el 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子
`beforeUpdate`:数据更新时调用，发生在虚拟 DOM 打补丁之前
`updated`:由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。
`activated`:keep-alive 组件激活时调用。
`deactivated`:keep-alive 组件停用时调用。
`beforeDestroy`:实例销毁之前调用
`destroyed`:Vue 实例销毁后调用

### 12.angular 双向数据绑定与vue数据的双向数据绑定

二者都是 MVVM 模式开发的典型代表
angular 是通过脏检测实现，angular 会将 UI 事件，请求事件，settimeout 这类延迟，的对象放入到事件监测的脏队列，当数据变化的时候，触发 $diget 方法进行数据的更新，视图的渲染

vue 通过数据属性的数据劫持和发布订阅的模式实现，大致可以理解成由3个模块组成，observer 完成对数据的劫持，compile 完成对模板片段的渲染，watcher 作为桥梁连接二者，订阅数据变化及更新视图


