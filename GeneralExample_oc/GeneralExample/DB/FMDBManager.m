//
//  FMDBManager.m
//  GeneralExample
//
//  Created by pxh on 2018/5/17.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "FMDBManager.h"

@implementation FMDBManager

+(NSString* )FMDBPath{
    //document
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //file path
    NSString* filePath = [documentPath stringByAppendingPathComponent:@"fmdb.sqlite"];
    return filePath;
}

+(FMDatabaseQueue* )DataBase{
    return [[FMDatabaseQueue alloc] initWithPath:[self FMDBPath]];
}

/**
 创建表表格
 
 @param tableName 表名称
 @param arFields 表字段
 @param arFieldsType 表名称
 */
+(void)creatTableWithTableName:(NSString* )tableName arFields:(NSArray<NSString* >* )arFields arFieldsType:(NSArray<NSString* >* )arFieldsType{
    
    NSString* sql = [NSString stringWithFormat:@"%@%@%@",@"CREATE TABLE IF NOT EXISTS ",tableName,@"(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "];
    NSArray<NSString* >* fieldKeys = arFields;
    NSArray<NSString* >* fieldTypes = arFieldsType;
    for (int i = 0;i < fieldTypes.count;i ++){
        if (i != fieldTypes.count - 1){
            sql = [sql stringByAppendingFormat:@"%@%@%@, ",fieldKeys[i],@" ",fieldTypes[i]];
        }else{
            sql = [sql stringByAppendingFormat:@"%@%@%@)",fieldKeys[i],@" ",fieldTypes[i]];
        }
    }
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db tableExists:tableName]){
            NSLog(@"current table : %@ is exist",tableName);
            return;
        }else{
            if([db executeUpdate:sql]){
                NSLog(@"table:%@ create success !",tableName);
            }else{
                NSLog(@"table:%@ create fail !",tableName);
            }
        }
    }];
}


/**
 在表中插入数据 -- 增
 
 @param tableName 表名称
 @param dicFields key:value 键值对 key为表字段 value为对应的字段值
 */
+(void)insertDataToTable:(NSString* )tableName dicFields:(NSDictionary* )dicFields{
    NSArray* arFieldsKeys = dicFields.allKeys;
    NSArray* arFieldsValues = dicFields.allValues;
    NSString* sqlUpdateFirst = [NSString stringWithFormat:@"INSERT INTO '%@' (",tableName];
    NSString* sqlUpdateLast = @" VALUES(";
    for (int i = 0;i < arFieldsKeys.count;i ++){
        if(i != arFieldsKeys.count - 1){
            sqlUpdateFirst = [sqlUpdateFirst stringByAppendingFormat:@"%@,",arFieldsKeys[i]];
            sqlUpdateLast = [sqlUpdateLast stringByAppendingString:@"?,"];
        }else{
            sqlUpdateFirst = [sqlUpdateFirst stringByAppendingFormat:@"%@)",arFieldsKeys[i]];
            sqlUpdateLast = [sqlUpdateLast stringByAppendingString:@"?)"];
        }
    }
    NSString* sql = [NSString stringWithFormat:@"%@%@",sqlUpdateFirst,sqlUpdateLast];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if([db executeUpdate:sql values:arFieldsValues error:&error]){
            NSLog(@"table : %@ insert data success !",tableName);
        }else{
            NSLog(@"table : %@ insert data fail !",tableName);
        }
    }];
}

/**
 删除数据 -- 删
 
 @param tableName 表名称
 @param conditionKey 筛选字段
 @param conditionValue 筛选对应的值
 */
+(void)deleteFromTable:(NSString* )tableName conditionKey:(NSString* )conditionKey conditionValue:(id)conditionValue{
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE %@ = ?",tableName,conditionKey];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if ([db executeUpdate:sql values:@[conditionValue] error:&error]){
            NSLog(@"table : %@ delect success !",tableName);
        }else{
            NSLog(@"table : %@ delect fail !",tableName);
        }
    }];
}


/**
 丢弃无用的表 -- 删
 
 @param tableName 表名称
 */
+(void)dropTable:(NSString* )tableName{
    NSString* sql = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if([db executeUpdate:sql values:nil error:&error]){
            NSLog(@"table : %@ drop success !",tableName);
        }else{
            NSLog(@"table : %@ drop fail !",tableName);
        }
    }];
}


/**
 修改表数据 -- 改
 
 @param tableName 表名称
 @param dicFields key:value键值对 key为表字段 value为要修改的值
 @param conditionKey 过滤筛选字段
 @param conditionValue 过滤筛选字段对应的value
 */
+(void)modifyDataToTable:(NSString* )tableName dicFields:(NSDictionary* )dicFields conditionKey:(NSString* )conditionKey conditionValue:(id)conditionValue{
    NSArray* arFieldsKeys = dicFields.allKeys;
    NSArray* arFieldsValues = dicFields.allValues;
    NSMutableArray* values = [NSMutableArray arrayWithArray:arFieldsValues];
    [values addObject:conditionValue];
    NSString* sql = [NSString stringWithFormat:@"UPDATE %@ SET ",tableName];
    for(int i = 0;i < arFieldsKeys.count;i ++){
        if(i != arFieldsKeys.count - 1){
            sql = [sql stringByAppendingFormat:@"%@ = ?,",arFieldsKeys[i]];
        }else{
            sql = [sql stringByAppendingFormat:@"%@ = ?",arFieldsKeys[i]];
        }
    }
    sql = [sql stringByAppendingFormat:@" WHERE %@ = ?",conditionKey];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if ([db executeUpdate:sql values:values error:&error]){
            NSLog(@"table : %@ modify data success !",tableName);
        }else{
            NSLog(@"table : %@ modify data fail !",tableName);
        }
    }];
}

/**
 查询数据 -- 查

 @param tableName 表名称
 @param arFieldsKeys 查询字段
 @return 查询到所有key value
 */
+(NSArray<NSDictionary* >* )selectFromTable:(NSString* )tableName arFieldsKeys:(NSArray<NSString* >* )arFieldsKeys{
    NSMutableArray* arFieldsVaules = [NSMutableArray array];
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet* rs = [db executeQuery:sql];
        while (rs.next) {
            NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
            for (int i = 0;i < arFieldsKeys.count; i++){
                [dictionary setObject:[rs stringForColumn:arFieldsKeys[i]] forKey:arFieldsKeys[i]];
            }
            [arFieldsVaules addObject:dictionary];
        }
    }];
    return [arFieldsVaules copy];
}

/** 查询数据 -- 查
 查询具体关键字的方法

 @param tableName 表名称
 @param arFieldsKeys 查询的所有字段
 @param conditionsKey 筛选条件关键字
 @param conditionsValue 筛选条件的值
 @return 返回所有查询到的key value
 */
+(NSArray<NSDictionary* >* )selectFromTable:(NSString* )tableName arFieldsKeys:(NSArray<NSString* >* )arFieldsKeys conditionsKey:(NSString* )conditionsKey conditionsValue:(id)conditionsValue{
    NSMutableArray* arFieldsVaules = [NSMutableArray array];
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ?",tableName,conditionsKey];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        FMResultSet* rs = [db executeQuery:sql values:@[conditionsValue] error:&error];
        while (rs.next) {
            NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
            for (int i = 0;i < arFieldsKeys.count; i++){
                [dictionary setObject:[rs stringForColumn:arFieldsKeys[i]] forKey:arFieldsKeys[i]];
            }
            [arFieldsVaules addObject:dictionary];
        }
    }];
    return [arFieldsVaules copy];
}


/**
 新增加表字段

 @param tableName 表名称
 @param newField 新增表字段
 @param arFields 所有字段
 @param arFieldsType 所有字段的属性
 */
+(void)changeTable:(NSString* )tableName newField:(NSString* )newField arFields:(NSArray<NSString* >* )arFields arFieldsType:(NSArray<NSString* >* )arFieldsType{
    NSString* sql = [NSString stringWithFormat:@"ALTER TABLE '%@' RENAME TO 'old_Table'",tableName];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db columnExists:newField inTableWithName:tableName]){
            NSError* error;
            [db executeUpdate:sql values:nil error:&error];
            //create new table
            [self creatTableWithTableName:tableName arFields:arFields arFieldsType:arFieldsType];
            //import data
            [self importData:@"old_Table" newTableName:tableName];
            //delete old table
            [self dropTable:@"old_Table"];
        }
    }];
}


/**
 导入数据

 @param oldTableName 原有表名
 @param newTableName 导入表名
 */
+(void)importData:(NSString* )oldTableName newTableName:(NSString* )newTableName{
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO %@ SELECT  id,usedName, date, age, phone, ''  FROM %@",newTableName,oldTableName];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if([db executeUpdate:sql values:nil error:&error]){
            NSLog(@"%@ importData to %@ success !",oldTableName,newTableName);
        }else{
            NSLog(@"%@ importData to %@ fail !",oldTableName,newTableName);
        }
    }];
}

/**
 给表添加新字段

 @param tableName 表名称
 @param addField 新增字段
 @param addFieldType 新增字段属性
 */
+(void)changeTable:(NSString* )tableName addField:(NSString* )addField addFieldType:(NSString* )addFieldType{
    NSString* sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@%@",tableName,addField,addFieldType];
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        NSError* error;
        if([db executeUpdate:sql values:nil error:&error]){
            NSLog(@"table : %@ changeTable success !",tableName);
        }else{
            NSLog(@"table : %@ changeTable success !",tableName);
        }
    }];
}

@end
