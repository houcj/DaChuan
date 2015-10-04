//
//  SystemCurrectDate.m
//  DaChuan
//
//  Created by DaChuan on 15/9/30.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "SystemCurrectDate.h"

@implementation SystemCurrectDate

singleton_implementation(SystemCurrectDate)

+(NSDateComponents *)backCurrentNSDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    
    return comps;
}

+(NSString *)backSystemCurrentDate
{
    //获取系统当前日期
    NSInteger year,month,day,hour,min,sec,week;
    NSString *weekStr=nil;
    
    NSDateComponents *comps = [self backCurrentNSDateComponents];
    
    year = [comps year];
    week = [comps weekday];
    month = [comps month];
    day = [comps day];
    hour = [comps hour];
    min = [comps minute];
    sec = [comps second];
    
    NSArray *weeks = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    
    week = [comps weekday];
    
    weekStr = weeks[week + 1];
    NSString *dateCurrent = [NSString stringWithFormat:@"%ld年%ld月%ld日", year, month, day];
    
    return dateCurrent;
    
}

+(NSString *)backSystemCurrentWeek
{
    //获取系统当前日期
    NSInteger week;
    NSString *weekStr=nil;
    
    NSDateComponents *comps = [self backCurrentNSDateComponents];
    
    NSArray *weeks = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期天"];
    
    week = [comps weekday];
    
    weekStr = weeks[week + 1];
    
    return weekStr;

    
}

+(NSString *)backSystemCurrentYearAndMouth
{
    //获取系统当前日期
    NSInteger year,month;
  
    NSDateComponents *comps = [self backCurrentNSDateComponents];
    
    year = [comps year];
    month = [comps month];
    
    NSString *dateCurrent = [NSString stringWithFormat:@"%ld年%ld月", year, month];
    
    return dateCurrent;

}

+(NSString *)backSystemCurrentToday
{
    //获取系统当前日期
    NSInteger day;
    
    NSDateComponents *comps = [self backCurrentNSDateComponents];
    
    day = [comps day];
    
    NSString *dateCurrent = [NSString stringWithFormat:@"%ld", day];
    
    return dateCurrent;

}

@end
