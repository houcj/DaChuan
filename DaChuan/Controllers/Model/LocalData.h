//
//  LocalData.h
//  DaChuan
//
//  Created by DaChuan on 15/9/30.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <FMDB.h>

@interface LocalData : NSObject

singleton_interface(LocalData)

@property (nonatomic ,strong) FMDatabaseQueue *queue;

/*********** 表db_logdata ************/
//插入新日志－－日期和表情
-(void)insertLogdata:(NSString *)date idOfEmotion:(NSInteger)emotion;
//查询日志－－返回表情id、日期
-(NSDictionary *)queryLogdata:(NSString *)date;

/*********** 表db_logcontent ************/
//插入新日志－－标题、内容、日期、唯一标识符
-(void)insertLogcontent:(NSString *)date udidOfLog:(NSString *)key titleOfLog:(NSString *)title contentOfLog:(NSString *)content;
//刷新日志－－内容
-(void)updateLogcontent:(NSString *)key titleOfLog:(NSString *)title contentOfLog:(NSString *)content;
//查询日志－－返回该日期下所有格子标题及内容
-(NSArray *)queryLogcontent:(NSString *)date;

/*********** 表db_pics ************/
//插入新日志－－图片
-(void)insertPics:(NSString *)key imageOfImage:(NSString *)image;
//查询日志－－返回图片数组
-(NSArray *)queryPics:(NSString *)key;

@end
