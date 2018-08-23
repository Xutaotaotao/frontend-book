# JavaScript基础(ES5)

## 变量

### 变量定义
变量的另一个特性就是它们能够存储任何的东西 -- 不只是字符串和数字。变量可以存储更复杂的数据，甚至是函数。

### 声明和初始化变量
`var`声明变量，`=`初始化变量。

```
var myName;
myName = 'TaotaoXu';

// good use
var myName = 'TaotaoXu';

```

### 变量命名规则
- 不使用规则之外的其他字符。
- 变量名不要以下划线开头,变量名不要以数字开头。
- 推荐"小写驼峰命名法"，用来将多个单词组在一起，小写整个命名的第一个字母然后大写剩下单词的首字符。
- 让变量名直观，它们描述了所包含的数据。
- 变量名大小写敏感——因此myage与myAge是2个不同的变量。
- 避免使用JavaScript的保留字给变量命名。

### 变量类型
- Number,数值，变量存储数字，只要是数值都可以，不管是整数还是浮点数。`var myNumber = 17`
- String,字符串，用双引号或单引号包裹。`var sayHello = 'hello world'`
- Boolean,true或false。`var iAmBoy = true`
- Array,数组，单个对象，可以包含很多值。`var myNumber = [10,15,30]`
- Object,对象，现实生活中抽象出来的一种模型，比如person，`var person = {name:'TaotaoXu',hair:'black'}`




