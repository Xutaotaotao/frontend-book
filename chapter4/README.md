# JavaScript基础

### JavaScript练习题
#### 1.判断两个 Set 是否相同
完成 isSameSet 函数，它接受了两个 Set 对象作为参数，请你返回 true/false 来表明这两个 set 的内容是否完全一致，例如：

**example**
```
const a = {}
const b = 1
const c = 'ScriptOJ'
const set1 = new Set([a, b, c])
const set2 = new Set([a, c, b])
isSameSet(set1, set2) // => true
```

**answer**
```
const isSameSet = (s1, s2) => {
  let arr1 = [...s1];
  let arr2 = [...s2];
  let a = arr1.every(item => arr2.includes(item));
  let b = arr2.every(item => arr1.includes(item));
  return a && b && arr1.length === arr2.length;
}
```

### 2数组去重
编写一个函数 unique(arr)，返回一个去除数组内重复的元素的数组。例如：
**example**
```
unique([0, 1, 2, 2, 3, 3, 4]) // => [0, 1, 2, 3, 4]
unique([0, 1, '1', '1', 2]) // => [0, 1, '1', 2]
```

**answer**
```
const unique = (arr) => {
  return [...new Set(arr)]
}
```

### 3filter map
请你给原生的 Map 添加方法 filterKeys 和 filterValues，可以类似于于数组方法的 filter。它们分别可以对 Map 的键和值进行筛选，它们会返回一个新的 Map， 是对原有的 Map 的筛选结果，例如：
**example**
```
const m = new Map([['Jerry', 12], ['Jimmy', 13], ['Tomy', 14]])

m.filterKeys((key) => key.startsWith('J')) // => Map { Jerry => 12, Jimmy => 13 }
m.filterValues((val) => val >= 13) // => Map { Jimmy => 13, Tomy => 14  }

// 原有的 map 保持不变
console.log(m) // => Map { Jerry => 12 , Jimmy => 13, Tomy => 14 }
```
**answer**
```
Map.prototype.filterKeys = function(fn){
  return new Map([...this].filter(([k,v]) => fn(k)));
}

Map.prototype.filterValues = function(fn){
  return new Map([...this].filter(([k,v]) => fn(v)))
}
```





### 4重写一个Map
```
 function Map() {
        this.elements = new Array();
        // 获取Map元素个数
        this.size = function() {
            return this.elements.length;
        },
            // 判断Map是否为空
            this.isEmpty = function() {
                return (this.elements.length < 1);
            },
            // 删除Map所有元素
            this.clear = function() {
                this.elements = new Array();
            },
            // 向Map中增加元素（key, value)
            this.put = function(_key, _value) {
                if (this.containsKey(_key) == true) {
                    if (this.containsValue(_value)) {
                        if (this.remove(_key) == true) {
                            this.elements.push({
                                key : _key,
                                value : _value
                            });
                        }
                    } else {
                        this.elements.push({
                            key : _key,
                            value : _value
                        });
                    }
                } else {
                    this.elements.push({
                        key : _key,
                        value : _value
                    });
                }
            },
            // 向Map中增加元素（key, value)
            this.set = function(_key, _value) {
                if (this.containsKey(_key) == true) {
                    if (this.containsValue(_value)) {
                        if (this.remove(_key) == true) {
                            this.elements.push({
                                key : _key,
                                value : _value
                            });
                        }
                    } else {
                        this.elements.push({
                            key : _key,
                            value : _value
                        });
                    }
                } else {
                    this.elements.push({
                        key : _key,
                        value : _value
                    });
                }
            },
            // 删除指定key的元素，成功返回true，失败返回false
            this.remove = function(_key) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            this.elements.splice(i, 1);
                            return true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 删除指定key的元素，成功返回true，失败返回false
            this.delete = function(_key) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            this.elements.splice(i, 1);
                            return true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 获取指定key的元素值value，失败返回null
            this.get = function(_key) {
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            return this.elements[i].value;
                        }
                    }
                } catch (e) {
                    return null;
                }
            },

            // set指定key的元素值value
            this.setValue = function(_key, _value) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            this.elements[i].value = _value;
                            return true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 获取指定索引的元素（使用element.key，element.value获取key和value），失败返回null
            this.element = function(_index) {
                if (_index < 0 || _index >= this.elements.length) {
                    return null;
                }
                return this.elements[_index];
            },

            // 判断Map中是否含有指定key的元素
            this.containsKey = function(_key) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            bln = true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 判断Map中是否含有指定key的元素
            this.has = function(_key) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].key == _key) {
                            bln = true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 判断Map中是否含有指定value的元素
            this.containsValue = function(_value) {
                var bln = false;
                try {
                    for (i = 0; i < this.elements.length; i++) {
                        if (this.elements[i].value == _value) {
                            bln = true;
                        }
                    }
                } catch (e) {
                    bln = false;
                }
                return bln;
            },

            // 获取Map中所有key的数组（array）
            this.keys = function() {
                var arr = new Array();
                for (i = 0; i < this.elements.length; i++) {
                    arr.push(this.elements[i].key);
                }
                return arr;
            },

            // 获取Map中所有value的数组（array）
            this.values = function() {
                var arr = new Array();
                for (i = 0; i < this.elements.length; i++) {
                    arr.push(this.elements[i].value);
                }
                return arr;
            };

        /**
         * map遍历数组
         * @param callback [function] 回调函数；
         * @param context [object] 上下文；
         */
        this.forEach = function forEach(callback,context){
            context = context || window;
            //IE6-8下自己编写回调函数执行的逻辑
            var newAry = new Array();
            for(var i = 0; i < this.elements.length;i++) {
                if(typeof  callback === 'function') {
                    var val = callback.call(context,this.elements[i].value,this.elements[i].key,this.elements);
                    newAry.push(this.elements[i].value);
                }
            }
            return newAry;
        }

    }
```    
