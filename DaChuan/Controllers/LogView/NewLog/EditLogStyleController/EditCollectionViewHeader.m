//
//  EditCollectionViewHeader.m
//  DaChuan
//
//  Created by DaChuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "EditCollectionViewHeader.h"
#import "common.h"

@implementation EditCollectionViewHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled=YES;
        self.backgroundColor = [UIColor cyanColor];
        _dateLAabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreenWidth - 100)/2, 20, 100, 24)];
        _dateLAabel.textAlignment = NSTextAlignmentCenter;
        _dateLAabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_dateLAabel];
        
    }
    
    return self;
}

-(void)setDate:(NSString *)date
{
    _date = date;
    [_dateLAabel setText:_date];
}

@end
