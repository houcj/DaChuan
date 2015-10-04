//
//  MineView.m
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "MineView.h"
#import "common.h"

@implementation MineView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //添加导航栏
        [self addNavigation];
        //添加主视图
        [self addMainContent];
        
    }
    return self;
}

-(void)addNavigation
{
    //导航栏
    UIView *Nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    Nav.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    //导航栏标题
    CGFloat titleW = 40;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - titleW)/2, 20+11, titleW, 22)];
    title.text = @"我的";
    title.font = [UIFont systemFontOfSize:14];
    [title setTextAlignment:NSTextAlignmentCenter];
    [Nav addSubview:title];
    //导航栏按钮
    CGFloat btnW = 36;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-btnW-6, 20+4, btnW, 36)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(didEdit) forControlEvents:UIControlEventTouchUpInside];
    [Nav addSubview:btn];
    
    [self addSubview:Nav];
}

//点击导航栏右侧按钮事件响应
-(void)didEdit
{
    
}

-(void)addMainContent
{
    
}

@end
