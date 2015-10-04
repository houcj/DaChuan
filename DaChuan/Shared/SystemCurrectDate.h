//
//  SystemCurrectDate.h
//  DaChuan
//
//  Created by DaChuan on 15/9/30.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SystemCurrectDate : NSObject

singleton_interface(SystemCurrectDate)

+(NSString *)backSystemCurrentDate;

+(NSString *)backSystemCurrentWeek;

+(NSString *)backSystemCurrentYearAndMouth;

+(NSString *)backSystemCurrentToday;

@end
