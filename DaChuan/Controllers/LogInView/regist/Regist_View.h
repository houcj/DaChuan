//
//  Regist_View.h
//  DaChuan
//
//  Created by dachuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"

@protocol registProtocol <NSObject>

- (void)logIn:(Info *)info;
- (void)pushNewAppreciate_ViewController:(Info *)info;

@end

@interface Regist_View : UIView<UIAlertViewDelegate>

@property (nonatomic, strong)UIView *firstView;
@property (nonatomic, strong)UIView *secondView;
@property (nonatomic, strong)UIView *thirdView;

@property (nonatomic, strong)UILabel *dayLabel;
@property (nonatomic, strong)UILabel *weekLabel;
@property (nonatomic, strong)UILabel *yearAndMonthLabel;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *emailLabel;
@property (nonatomic, strong)UILabel *passwordLabel;
@property (nonatomic, strong)UILabel *nameLabel;

@property (nonatomic, strong)UITextField *emailTextField;
@property (nonatomic, strong)UITextField *passwordTextField;
@property (nonatomic, strong)UITextField *nameTextField;

@property (nonatomic, strong)UIButton *LogInBtn;
@property (nonatomic, strong)UIButton *registBtn;
@property (nonatomic, strong)UIButton *bigBtn;

@property (nonatomic, strong)NSMutableArray *tokenMuArr;
@property (nonatomic, strong)NSUserDefaults *tokenUserDefaults;

@property (nonatomic, strong)Info *info;

@property (nonatomic, weak)id<registProtocol> delegateRegist;

@end
