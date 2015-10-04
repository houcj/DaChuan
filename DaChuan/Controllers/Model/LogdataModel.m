//
//  LogdataModel.m
//  DaChuan
//
//  Created by app on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LogdataModel.h"

@implementation LogdataModel
-(instancetype)initWithLogdataModelDic:(NSDictionary*)dic
{
    if (self=[super init]) {
        self.sid=dic[@"sid"];
        self.date=dic[@"date"];
        self.emotion=dic[@"emotion"];
        NSMutableArray *array=[[NSMutableArray alloc]init];
        for (NSDictionary *dict in dic[@"content"]) {
            contentModel *conmodel=[[contentModel alloc]initWithContentModelDic:dict];
            [array addObject:conmodel];
        }
        self.content=array;
        
    }


    return self;
}
@end
