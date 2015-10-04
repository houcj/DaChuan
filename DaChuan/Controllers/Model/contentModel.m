//
//  contentModel.m
//  DaChuan
//
//  Created by app on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "contentModel.h"

@implementation contentModel
-(instancetype)initWithContentModelDic:(NSDictionary *)dic
{
    if (self=[super init]) {
        self.key=dic[@"key"];
        self.title=dic[@"title"];
        self.content=dic[@"content"];
        self.pics=dic[@"pics"];
    }
    return self;


}
@end
