//
//  FMDBManager.m
//  GeneralExample
//
//  Created by pxh on 2018/5/17.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "FMDBManager.h"
#import "FMDB.h"
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
    FMDatabaseQueue* db = [self DataBase];
    [db inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db tableExists:tableName]){
            NSLog(@"current table : %@ is exist",tableName);
            return;
        }
        NSString* sql = [NSString stringWithFormat:@"%@%@%@",@"CREATE TABLE IF NOT EXISTS ",tableName,@"(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "];
        NSArray<NSString* >* fieldKeys = arFields;
        NSArray<NSString* >* fieldTypes = arFieldsType;
        for (int i = 0;i < fieldTypes.count;i ++){
            if (i != fieldTypes.count - 1){
                sql = [sql stringByAppendingFormat:@"%@%@%@%@",fieldKeys[i],@" ",fieldTypes[i],@", "];
            }else{
                sql = [sql stringByAppendingFormat:@"%@%@%@%@",fieldKeys[i],@" ",fieldTypes[i],@")"];
            }
        }
        if([db executeUpdate:sql]){
            NSLog(@"table:%@ create success!",tableName);
        }else{
            NSLog(@"table:%@ create fail!",tableName);
        }
    }];
}

@end
