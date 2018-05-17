//
//  FMDBManager.h
//  GeneralExample
//
//  Created by pxh on 2018/5/17.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject

/**
 创建表表格

 @param tableName 表名称
 @param arFields 表字段
 @param arFieldsType 表名称
 */
+(void)creatTableWithTableName:(NSString* )tableName arFields:(NSArray<NSString* >* )arFields arFieldsType:(NSArray<NSString* >* )arFieldsType;

@end

//SQLite数据库的基本数据类型：
//
//整数数据类型：
//
//（1）integer ：整形数据，大小为4个字节
//
//（2）bigint : 整形数据，大小为8个字节
//
//（3）smallint：整形数据，大小为2个字节
//
//（4）tinyint：从0到255的整形数据，存储大小为1字节
//
//浮点数数据类型：
//
//（1）float：4字节浮点数
//
//（2）double： 8字节浮点数
//
//（3）real： 8字节浮点数
//
//字符型数据类型：
//
//（1）char(n)n长度的字串，n不能超过254
//
//（2）varchar(n)长度不固定且其长度为n的字串，n不能超过4000
//
//（3）text text存储可变长度的非unicode数据，存放比varchar更大的字符串
//
//注意事项：
//
//（1）尽量用varchar
//
//（1） 超过255字节的只能用varchar或text
//
//（1）能用varchar的地方不用text
//
//sqlite字符串区别：
//
//1.char存储定长数据很方便，char字段上的索引效率极高，比如定义char(10),那么不论你存储的数据是否达到了10个字节，都要占去10个字节的空间，不足的自动用空格填充。2.varchar存储变长数据，但存储效率没有char高，如果一个字段可能的值是不固定长度的，我们只知道它不可能超过10个 >字符，把它定义为varchar（10）是最合算的，varchar类型的实际长度是它的值的实际长度+1.为什么+1呢？这个字节用于保存实际使用了多大的长度。因此，从空间上考虑，用varchar合适，从效率上考虑，用char合适，关键是根据情况找到权衡点
//
//3.TEXT存储可变长度的非Unicode数据，最大长度为2^31-1（2147483647）个字符。
//
//日期类型：
//
//date:包含了 年份，月份，日期
//
//time：包含了小时，分钟，秒
//
//datetime：包含了年，月，日，时，分，秒
//
//timestamp：包含了年，月，日，时，分，秒，千分之一秒
//
//注意：datetime 包含日期时间格式，必须写成‘2010-08-05’不能写为‘2010-8-5’，否则在读取时会产生错误。
//
//其他类型：
//
//null：空值。
//
//blob ：二进制对象，主要用来存放图片和声音文件等
//
//default：缺省值
//
//primary key：主键值
//
//autoincrement：主键自动增长
//
//什么是主键
//
//（1）primary key， 主键就是一个表中，有一个字段，里面的内容不可以重复
//
//（2）一般一个表都需要设置一个主键
//
//（3）autoincrement这样让主键自动增长
//
//注意事项：
//
//所有字符串必须要加‘ ’单引号
//
//整数和浮点数不用加‘ ’
//
//日期需要加单引号‘ ’
//
//字段顺序没有关系，关键是key与value要对应
//
//对于自动增长的主键不需要插入字段
//
//SQLite命令行
//
//.help(帮助)
//
//.quit（退出）
//
//.database（列出数据库信息）
//
//.dump（查看所有的sql语句）
//
//.schema（查看表结构）
//
//.tables（显示所有的表）
//
//SQLite数据库的增删查改操作
//
//1.创建表
//
//create table if not exists QFClass(Name varchar(256), StuCount smallint,StartDate date);
//
//create table if not exists QFCourses(ID integer,Name varchar(256));
//
//2.插入数据
//
//insert into QFStu(Name) values('千锋');
//
//insert into QFStu(Name,Age) values('艾丰',21);
//
//insert into QFStu(Name,Age,Class,RegisterTime,Money,Birthday) values('Joker',23,12,'2013-02-12 11:11:11',3223,'1990-01-13');
//
//3.查询语句
//
//select *from QFStu;
//
//select Name,Age from QFStu;
//
//select Name,Age,RegisterTime,Money,Birthday from QFStu;
//
//在查询中加上条件
//
//select Name,Age,RegisterTime,Money,Birthday from QFStu where Age>10;
//
//select Name,Age,RegisterTime,Money,Birthday from QFStu where Age>10 and ID>2;
//
//select Name,Age,RegisterTime,Money,Birthday from QFStu where Name like'%千锋%';
//
//select Name,Age,RegisterTime,Money,Birthday from QFStu where RegisterTime>'2013-01-13 11:11:11';
//select统计语句
//
//select count(*) from QFStu;
//
//select avg(Age) from QFStu;
//
//select sum(Age) from QFStu;
//
//4.删除记录
//
//（1）删除表中ID值为2的记录
//
//delete from QFStu where ID=2；
//
//（2）删除表中所有记录（慎重使用）
//
//delete from QFStu;
//
//5.更新/修改Update
//
//更改ID为1的更新Name字段
//
//update QFStu set Name ='千锋iOS' where ID =1；
//
//更新ID为1的Name和Age字段
//
//update QFStu set Name ='千锋iOS' ，Age=100 where ID=1;
//
//更新所有记录的字段
//
//update QFStu set Name=‘千锋iOS’;
//
//将ID=1的记录的Age值增加10
//
//update QFStu set Age=Age+10 where ID=1;
//
//二.FMDataBase使用方法
//
//FMDataBase是一个开源的第三方操作数据库的框架。因为iOS官方提供操作数据库的方法使用起来十分麻烦，FMDataBase是把官方提供的方法封装了一层，只是为了更方便开发使用。支持ARC和Non-ARC/MRC操作。
//
//FMDataBase主要有以下3个类：
//
//FMDataBase - 表示一个单独的SQLite数据库用来执行SQLite的命令
//
//FMResultSet - 表示FMDataBase执行查询后结果集
//
//FMDatabaseQueue - 如果想在多线程中执行多个查询和更新，应该使用该类，这是线程安全的。
//
//
//
//1.FMDataBase数据库创建：
//
//NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/tshinghua.db"];
//
//NSLog(@"path is %@",path);
//
//FMDatabase *fmdb=[FMDatabase databaseWithPath:path];
//
//
//BOOL ret=[fmdb open];
//
//如果创建数据库成功，ret为YES，否则ret为NO
//
//
//
//2.FMDataBase表的创建
//
//NSString *sql=@"create table if not exists QFStu(ID integer primary key autoincrement,Name varchar (128),Age integer,Class integer default 0, RegisterTime dateTime,Money float default 0,Birthday date);";
//
//
//ret=[fmdb executeUpdate:sql];
//
//
//
//
//
//3.FMDataBase 插入
//
//(1)
//
//NSString*sql1=@"insert into QFStu(Name,Age,Class,RegisterTime,Money,Birthday)values('Joker',23,12,'2013-02-12 11:11:11',3223,'1990-01-13);";
//
//ret=[fmdbexecuteUpdate:sql1,@"Joker",@"23",@"4",@"2009-10-10 11:11:11",@"0",@"1991-01-13"];
//
//(2)使用通配符进行查询
//
//NSString *sql1=@"insert into QFStu(Name,Age,Class,RegisterTime,Money,Birthday)values(?,?,?,?,?,?);";
//
//ret=[fmdb executeUpdate:sql1,@"Joker",@"23",@"4",@"2009-10-10 11:11:11",@"0",@"1991-01-13"];
//
//4.FMDataBase 查询
//
//(1)普通查询
//
//
//NSString *sql2=@"select *from QFStu";
//
//
//FMResultSet *set=[fmdb executeQuery:sql2];
//
//while ([set next]) {
//    
//    NSUInteger pid=[set intForColumn:@"ID"];
//    
//    NSString *name=[set stringForColumn:@"Name"];
//    
//    NSString *datetime=[set stringForColumn:@"RegisterTime"];
//    
//    NSDate*d=[self dateFromString:datetime];
//    
//    NSString *dateTime2=[self stringFromDate:d];
//    
//}
//
//(2)对于查询结果是标量
//
//NSString *sql=@"select from count(*) from QFStu";
//
//FMResultSet*set=[fmdbexecuteQuery:sql];
//
//NSUInteger count=0;
//
//while([set next])
//
//{
//    
//    count=[set intForColumnIndex:0];
//    
//}
//
//
//
//NSLog(@" count is %d",count);
//
//
//
//对于标量是数据返回的是1*1矩阵，所以这有一列，这里使用0
//
//5.FMDataBase删除记录
//
//NSString *sql=@"delete from QFStu where ID=2;";
//
//ret=[fmdb executeUpdate:sql];
//
//
//
//使用通配符进行处理
//
//ret=[fmdb executeUpdate:@"delete from QFStu where ID = ?",@"3"];
//
//6.FMDataBase修改记录
//
//NSString *sql=@"update QFStu set Name='千锋2' whereID=9；"；
//
//ret=[fmdb executeUpdate:sql];
//
//ret=[fmdb executeUpdate;@"update QFStu set Name='千锋2' where ID =？",@"10"];
//
//
//
//从数据库分页读取数据
//
//limit是mysql的语法：
//select * from table limit m,n
//其中m是指记录开始的index，从0开始，表示第一条记录
//n是指从第m+1条开始，取n条。
//select * from tablename limit 2,4
//即取出第3条至第6条，4条记录
