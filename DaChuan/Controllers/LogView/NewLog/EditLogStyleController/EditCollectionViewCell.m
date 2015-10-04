//
//  EditCollectionViewCell.m
//  DaChuan
//
//  Created by DaChuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "EditCollectionViewCell.h"

@implementation EditCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubviews];
        
    }
    return self;
}

-(void)addSubviews
{
    self.backgroundColor = [UIColor colorWithRed:220/255.0 green:251/255.0 blue:221/255.0 alpha:1];
    
    CGFloat Margin = 5;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Margin, 4*(Margin + 1), self.frame.size.width - 2*Margin + 2, self.frame.size.height*0.5)];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.numberOfLines = 0;
    
    [self.contentView addSubview:_titleLabel];
    
    _dele = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    [_dele setBackgroundImage:[UIImage imageNamed:@"Delete_128"] forState:UIControlStateNormal];
    _dele.tag = self.cellIndex;
    
    [self.contentView addSubview:_dele];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}

-(void)setCellIndex:(NSInteger)cellIndex
{
    _cellIndex = cellIndex;
    _dele.tag = _cellIndex;
}

@end
