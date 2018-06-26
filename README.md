# GeneralExample
iOS 日常开发的使用示例包含OC分支和swift分支</br>
在不同分支里包含了日常开发常用的技巧和第三方库
## GeneralExample_oc
UI布局</br>
数据库:WHC_ModelSqliteKit</br>

## GeneralExample_swift
UI布局</br>
数据库：WCDB.swift</br>
数据对象解析：objectMapper</br>


### 数据库示例逻辑
根据版本自动更新</br>
创建一个person对象，有增删改查的逻辑，person示例如下</br>
class Person{
> var  id : int //primaryKey
> var name : string
> var age : int
> var gender : string
> var address : string
> var car : Car
}

class Car{
> var brand : string
> var name : string
> var number : string
}
