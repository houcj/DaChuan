//
//  LogView.m
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LogView.h"
#import "LogTableViewCell.h"
#import "NewLogViewController.h"
#import "common.h"

@interface LogView()

@property (nonatomic ,assign) CGFloat heightCell;

@end

@implementation LogView

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

#pragma methed －－－－－ 添加子视图
-(void)addNavigation
{
    //导航栏
    _Nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    _Nav.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    //导航栏标题
    CGFloat titleW = 40;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((KScreenWidth - titleW)/2, 20+11, titleW, 22)];
    title.text = @"日志";
    title.font = [UIFont systemFontOfSize:14];
    [title setTextAlignment:NSTextAlignmentCenter];
    [_Nav addSubview:title];
    //导航栏按钮
    CGFloat btnW = 36;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-btnW-6, 20+4, btnW, 36)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(didEdit) forControlEvents:UIControlEventTouchUpInside];
    [_Nav addSubview:btn];
    
    [self addSubview:_Nav];
}

#pragma mark-点击导航栏右侧按钮事件响应
-(void)didEdit
{
    if ([self.logdelegate respondsToSelector:@selector(logViewToNewLogViewController:)]) {
        [self.logdelegate logViewToNewLogViewController:self];
    }
    
}

-(void)addMainContent
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _Nav.frame.size.height, KScreenWidth, KScreenHeight - _Nav.frame.size.height - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =  self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
}

#pragma mark-UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    LogTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
    
        cell = [[LogTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    _heightCell = cell.cellHeight;
    return cell;
}

#pragma mark-UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.logdelegate respondsToSelector:@selector(logViewToSkimLogViewController:)])
    {
        [self.logdelegate logViewToSkimLogViewController:self];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _heightCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    
    UILabel *date = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    date.backgroundColor = [UIColor colorWithRed:66/255.0 green:185/255.0 blue:194/255.0 alpha:1];
    date.text = @"2015年9月";
    date.font = [UIFont systemFontOfSize:12];
    date.textColor = [UIColor whiteColor];
    date.textAlignment = NSTextAlignmentCenter;
    [view addSubview:date];
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}

#pragma methed -－－－－ 数据操作


@end
