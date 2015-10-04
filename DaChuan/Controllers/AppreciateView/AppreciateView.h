//
//  AppreciateView.h
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Main_UITableViewCell.h"
#import "Info.h"

@class AppreciateView;
@protocol AppreciateViewDelegate <NSObject>

@optional

- (void)AppreciateViewToNewAppreciate_ViewController:(AppreciateView *)appreciateView;

- (void)AppreciateVIewToLogIn_ViewController:(AppreciateView *)appreciateView;

- (void)AppreciateViewToSeePublicAppreciate_ViewController:(Info *)info;

- (void)AppreciateViewToRegist_ViewController:(AppreciateView *)appreciateView;

@end

@interface AppreciateView : UIView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong)UITableView *mainTableView;

@property (nonatomic, strong)Main_UITableViewCell *cell;

@property (nonatomic, weak)id<AppreciateViewDelegate> AppreciateDelegate;

@property (nonatomic, strong)NSMutableArray *infoMuArr;
@property (nonatomic, strong)NSMutableArray *cellMuArr;

@property (nonatomic, strong)UIAlertView *alert;

@property (nonatomic, strong)NSUserDefaults *tokenUserDefaults;

@property (nonatomic, strong)Info *info;

@end
