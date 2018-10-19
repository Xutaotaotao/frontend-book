# React

## React-native

### 初始化工程
下载依赖项
npm install -g yarn react-native-cli
初始化工程
react-native init AwesomeProject
运行项目
react-native run-android

### 环境问题

问题一:
初始化时遇到如下报错
```
Error: Command failed: yarn add react-native --exact     at checkExecSyncError (child_process.js:473:13)
```
解决方案一：
```
yarn config set registry https://registry.npm.taobao.org --global
yarn config set disturl https://npm.taobao.org/dist --global
```

如果方案一无法解决
尝试下面的方法：
降级react-native的版本
```
react-native init NewApp --version 0.55.0
```



### Props属性
大多数组件在创建时就可以使用各种参数来进行定制。用于定制的这些参数就称为props（属性）。props是在父组件中指定，而且一经指定，在被指定的组件的生命周期中则不再改变。

### State
实际开发中，我们一般不会在定时器函数（setInterval、setTimeout 等）中来操作 state。典型的场景是在接收到服务器返回的新数据，或者在用户输入数据之后。

一切界面变化都是状态state变化
state的修改必须通过setState()方法
this.state.likes = 100; // 这样的直接赋值修改无效！
setState 是一个 merge 合并操作，只修改指定属性，不影响其他属性
setState 是异步操作，修改不会马上生效