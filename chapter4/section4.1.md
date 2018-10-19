# JavaScript基础

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

## 操作符

### 算数运算符
- 加法：`+`
- 减法：`-`
- 乘法：`*`
- 除法：`/`
- 求余：`%`

### 递增，递减运算符
- 递增：`++`
- 递减：`--`

### 操作运算符
- 递增赋值：`+=`
- 递减赋值：`-=`
- 乘法赋值：`*=`
- 除法赋值：`/=`

### 比较运算符
- 严格等于：`===`
- 严格不等于：`!==`
- 小于：`<`
- 大于：`>`
- 小于或等于：`<=`
- 大于或等于：`>=`

## 字符串常用操作方法（https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String）

### 获取字符串长度
```
var testString = 'testString';
var tsetLen = testString.length;// 获取字符串长度
```

### 检索特定字符串字符
```
var testString = 'testString';
var firstStr = testString[0];//获取第一个字符，[]中为索引，以0开始
```

### 查找，提取字符串
**indexOf()**:查找字符，返回字符对应的索引，没有则返回-1
```
var testString = 'testString test';
testString.indexOf('testString');//0
testString.indexOf('test');//1
testString.indexOf('hello');//-1
```
**slice()**:提取字符串,返回一个新的字符串(https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/String/slice)

```
str.slice(beginSlice[, endSlice])
```
**beginSlice**
从该索引（以 0 为基数）处开始提取原字符串中的字符。如果值为负数，会被当做 sourceLength + beginSlice 看待，这里的sourceLength 是字符串的长度。

**endSlice**
可选。在该索引（以 0 为基数）处结束提取字符串。如果省略该参数，slice会一直提取到字符串末尾。如果该参数为负数，则被看作是 sourceLength + endSlice，这里的 sourceLength 就是字符串的长度。

### 转换大小写
toLowerCase()和toUpperCase()

### 替换字符串的某部分
replase()

## 数组

### 创建数组
```
var testArray = ['test1','test2'];
```
### 通过索引访问数组元素

```
var test1 = testArray[0] // test1
```

### 数组长度
```
var len = testArray.length // 2
```

### 遍历数组
```
testArray.forEach(function(item,index){
  console.log(item,index);
})
```

### 找到某个元素在数组中的索引
```
var testIndex = testArray.indexOf('test4');// 0
```

**下面的方法会改变数组本身**
### 添加元素到数组末尾
```
var newLen = testArray.push('test3');// push方法改变原数组，返回新数组长度
//testArray:['test1','test2','test3'];
```

### 删除数组末尾的元素
```
var lastItem = testArray.pop();//pop方法改变原数组，返回最后的元素
//lastItem:'test3',testArray:['test1','test2'];
```

### 删除数组头部的元素
```
var firstItem = testArray.shift();//shift改变原数组，返回最前的元素
//firstItem:'test1',testArray:['test2'];
```

### 添加元素到数组的头部
```
var newLen = testArray.unshift('test4');//unshift改变原数组，返回新数组长度
// testArray:['test4','test2']
```

### 通过索引删除某个元素
```
var removedItem = testArray.splice(pos,1);
```

### 通过索引删除多个元素
```
var removedItems = testArray.splice(pos,num);
```

### 颠倒数组中的元素

```
var myArray = ['one','two','three'];
myArray.reverse();//改变原数组
// myArray:['one','two','one'];
```

### 对数组进行排序
```
var numbers = [4,2,5,1,3];
numbers.sort(function(a,b)){
  return a - b;
}
```

**下面的方法不会改变原数组**

### 复制一个数组
```
var testArrCopy = testArray.slice();
```

### 合并多个数组
```
var array1 = ['a','b','c'];
var array2 = ['d','e','f'];
var concatArray = array1.concat(array2); 
```

### 将数组的所有元素连接成一个字符串并返回这个字符
```
var testArr = ['Fire','Wind','Rain'];
var joinArr1 = testArr.join();//'Fire,Wind,Rain'
var joinArr2 = testArr.join('');//'FireWindRain'
var joinArr3 = testArr.join('-');//'Fire-Wind-Rain'
```

### 数组变成字符串
```
var array1 = [1,2,'a','b1'];
var stringArr = array1.toString();//'1,2,a,b1'
```