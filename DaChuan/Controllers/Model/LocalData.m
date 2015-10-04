//
//  LocalData.m
//  DaChuan
//
//  Created by DaChuan on 15/9/30.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData

singleton_implementation(LocalData)

/*********** 表db_logdata ************/
//插入新日志－－日期和表情
-(void)insertLogdata:(NSString *)date idOfEmotion:(NSInteger)emotion
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_logdata.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_logdata.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
         [db executeUpdate:@"create table if not exists db_logdata (date text primary key autoincrement, emotion integer);"];
    }];
    
    //2. 插入数据
    [self.queue inDatabase:^(FMDatabase *db){
        
        [db beginTransaction];
        
        BOOL result = YES;
        
        result = [db executeUpdate:@"insert into db_logdata (date, emotion) values (?, ?);", date, emotion];
        
        if (result) {
            [db rollback];
        }
        
        [db commit];
    }];
    
}
//查询日志－－返回表情id、日期
-(NSArray *)queryLogdata:(NSString *)date
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_logdata.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_logdata.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_logdata (date text primary key autoincrement, emotion integer);"];
    }];

    
    //2. 查询数据
    NSMutableArray *dArray = [[NSMutableArray alloc]init];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 1.查询数据
        FMResultSet *rs = [db executeQuery:@"select * from db_logdata"];
        
        // 2.遍历结果集
        while (rs.next) {
            //将遍历到的日期和表情放入字典，再将字典放入数组并返回
            NSDictionary *mDict = [[NSDictionary alloc]init];
            NSInteger meotion = [rs intForColumn:@"emotion"];
            NSNumber *obnum = [NSNumber numberWithInteger:meotion];
            [mDict setValue:[rs stringForColumn:@"date"] forKey:@"date"];
            [mDict setValue:obnum forKey:@"emotion"];
            
            [dArray addObject:mDict];
        }
    }];

    
    return dArray;
}


/*********** 表db_logcontent ************/
//插入新日志－－标题、内容、日期、唯一标识符
-(void)insertLogcontent:(NSString *)date udidOfLog:(NSString *)key titleOfLog:(NSString *)title contentOfLog:(NSString *)content
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_logcontent.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_logcontent.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_logcontent (key text primary key autoincrement, title text, content text, date text);"];
    }];
    
    
    //2. 插入数据
    [self.queue inDatabase:^(FMDatabase *db){
        
        [db beginTransaction];
        
        BOOL result=YES;
        result = [db executeUpdate:@"insert into db_logcontent (key, title, content, date) values (?, ?, ?,?);", key, title, content, date];
        
        if (result) {
            [db beginTransaction];
        }
        
        [db rollback];
    }];

}
//刷新日志－－内容
-(void)updateLogcontent:(NSString *)key titleOfLog:(NSString *)title contentOfLog:(NSString *)content
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_logcontent.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_logcontent.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_logcontent (key text primary key autoincrement, title text, content text, date text);"];
    }];
    
    //2. 刷新数据
    [self.queue inDatabase:^(FMDatabase *db){
        
        [db beginTransaction];
        
        BOOL result = YES;
        
        result = [db executeUpdate:@"update db_logcontent set content = ? where key = ? and title = ?;", content, key, title];
        
        if (result) {
            [db rollback];
        }
        
        [db commit];
        
    }];

}
//查询日志－－返回该日期下所有格子标题及内容
-(NSArray *)queryLogcontent:(NSString *)date
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_logcontent.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_logcontent.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_logcontent (key text primary key autoincrement, title text, content text, date text);"];
    }];

    //2. 查询数据
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    [self.queue inDatabase:^(FMDatabase *db){
        
        FMResultSet *rs = [db executeQuery:@"select * from db_logcontent where date = ?;", date];
        while (rs.next) {
            
            NSDictionary *mDict = [[NSDictionary alloc]init];
    
            [mDict setValue:[rs stringForColumn:@"title"] forKey:@"title"];
            [mDict setValue:[rs stringForColumn:@"content"] forKey:@"content"];
            
            [mArray addObject:mDict];
            
        }
        
    }];
    
    return mArray;
}


/*********** 表db_pics ************/
//插入新日志－－图片
-(void)insertPics:(NSString *)key imageOfImage:(NSString *)image
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_pics.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_pics.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_pics (image text primary key autoincrement, key text);"];
    }];

    //2. 插入数据
    [self.queue inDatabase:^(FMDatabase *db){
        
        [db beginTransaction];
        
        BOOL result = YES;
        
        result = [db executeUpdate:@"insert into db_pics (image, key) values (?, ?);", image, key];
        
        if (result) {
            [db rollback];
        }
        
        [db commit];
        
    }];
}
//查询日志－－返回图片数组
-(NSArray *)queryPics:(NSString *)key
{
    //1. 获得沙盒中的数据库文件名
    // NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"db_pics.sqlite"];
    NSString *filename = @"/Users/dachuan/Desktop/db_pics.sqlite";
    
    //创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    //创建表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db){
        [db executeUpdate:@"create table if not exists db_pics (image text primary key autoincrement, key text);"];
    }];

    //2. 查询数据
    NSMutableArray *mArray = [[NSMutableArray alloc]init];
    
    [self.queue inDatabase:^(FMDatabase *db){
        
        FMResultSet *rs = [db executeQuery:@"select * from db_pics where key = ?;", key];
        
        while (rs.next) {
            NSString *image = [rs stringForColumn:@"image"];
            [mArray addObject:image];
        }
        
    }];
    
    return mArray;
}

@end
