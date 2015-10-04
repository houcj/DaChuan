//
//  LogInView.h
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"

@protocol LogInViewDelegate <NSObject>

-(void)logInBtnClick:(Info *)info;
-(void)lostBtnClick:(Info *)info;
-(void)createNewNameBtnClick;

@end

@interface LogInView : UIView

@property (nonatomic, strong)UIView *view1;
@property (nonatomic, strong)UIView *view2;
@property (nonatomic, strong)UIView *view3;

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UILabel *weekLabel;
@property (nonatomic, strong)UILabel *yearAndMonthLabel;
@property (nonatomic, strong)UILabel *dayLabel;

@property (nonatomic, strong)UIButton *logInBtn;
@property (nonatomic, strong)UIButton *lostBtn;
@property (nonatomic, strong)UIButton *createNewNameBtn;
@property (nonatomic, strong)UIButton *backgroundBtn;

@property (nonatomic, strong)UITextField *nameTextField;
@property (nonatomic, strong)UITextField *passwordTextField;

@property (nonatomic, strong)NSString *emailStr;
@property (nonatomic, strong)NSString *resultStr;

@property (nonatomic, strong)NSArray *tokenArr;

@property (nonatomic, strong)NSUserDefaults *tokenUserDefaults;

@property (nonatomic, weak)id<LogInViewDelegate> logInDelegate;

@end
