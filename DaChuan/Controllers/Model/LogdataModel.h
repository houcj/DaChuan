//
//  LogdataModel.h
//  DaChuan
//
//  Created by app on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"contentModel.h"
@interface LogdataModel : NSObject
@property(nonatomic,copy)NSString *sid;
@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *emotion;
@property(nonatomic,retain)NSArray *content;
-(instancetype)initWithLogdataModelDic:(NSDictionary*)dic;
@end
