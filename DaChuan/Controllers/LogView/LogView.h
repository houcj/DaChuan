//
//  LogView.h
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogView;
@protocol LogViewDelegate <NSObject>

@optional
-(void)logViewToSkimLogViewController:(LogView *)LogView;
-(void)logViewToNewLogViewController:(LogView *)LogView;

@end

@interface LogView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIView *Nav;
@property (nonatomic ,strong) id<LogViewDelegate>logdelegate;

@end
