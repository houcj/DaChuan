//
//  contentModel.h
//  DaChuan
//
//  Created by app on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contentModel : NSObject
@property(nonatomic,copy)NSString *key;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,retain)NSArray *pics;
-(instancetype)initWithContentModelDic:(NSDictionary *)dic;
@end
