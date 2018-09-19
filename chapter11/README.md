# VUE项目

## 1.项目配置
各种环境的配置，项目构建配置，webpack打包配置，依赖项配置，路由配置
参考链接：
（https://www.jianshu.com/p/0697dd9199cf）
（https://www.jianshu.com/p/f05269760d84)
## 2.单文件组件

每个.vue文件包含三种类型的顶级语言块 <template>, <script> 和 <style>。这三个部分别代表了 html,js,css。
template部分放置div标签包裹所有代码，div里面可以嵌套自定义组件，也可以是常规的html语法。
script部分放置js代码，一般结构是引入此组件需要的工具，额外组件，额外方法。然后exprot default里面就会暴露出本组件相应的名称(name)，需要的引用的组件(components)，数据(data)，生命周期钩子，方法(method),侦听器(watch)等
style部分放置css,less,sass,styl等样式代码，根据你预编译样式的工具来写相应的样式语法。

生命周期钩子：
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
参考链接：
（https://cn.vuejs.org/v2/guide/single-file-components.html#ad）
（https://www.cnblogs.com/xinhudong/p/7878899.html）

## 3.http服务

根据页面需要的数据来加载http服务，在vue项目里面一般采用封装好的Axios来请求数据，如果一个服务会被多个页面调用就封装到一个serve文件下，然后再在相应的组件里面调用相应的方法。

参考链接：
（https://www.kancloud.cn/yunye/axios/234845）
（https://www.jianshu.com/p/0ea02376ca90）

## 4.数据渲染
vue大多数据源是双向数据绑定，用v-for来渲染列表
## 5.组件传值
组件之间的传值可能通过props或者路由来传参
## 6.vuex
参考链接：https://vuex.vuejs.org/zh/
## 7.vux
参考链接：https://vux.li/

