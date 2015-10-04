//
//  Info.h
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject

//登录
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *password;

//感悟首页
@property (nonatomic, strong)NSString *sid;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *time;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *like;
@property (nonatomic, strong)NSString *comment;
@property (nonatomic, strong)NSString *isPublic;
@property (nonatomic, strong)NSArray *labels;
@property (nonatomic, strong)NSArray *pics;

//浏览感悟（公共）
@property (nonatomic, strong)NSString *userId;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSArray *likes;
@property (nonatomic, strong)NSArray *comments;
@property (nonatomic, strong)NSString *isMine;

@end
