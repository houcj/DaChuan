//
//  Regist_View.m
//  DaChuan
//
//  Created by dachuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "Regist_View.h"
#import "AFNetworking.h"
#import "common.h"
#import "LogIn_ViewController.h"

@implementation Regist_View

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    
    _tokenUserDefaults = [NSUserDefaults standardUserDefaults];
    _tokenMuArr = [NSMutableArray arrayWithArray:[_tokenUserDefaults objectForKey:@"tokenMuArr"]];
    _info = [[Info alloc] init];
    
    self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    
    NSInteger year,month,day,hour,min,sec,week;
    NSString *weekStr=nil;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    year = [comps year];
    week = [comps weekday];
    month = [comps month];
    day = [comps day];
    
    switch (week) {
        case 1:
            weekStr=@"星期天";
            break;
        case 2:
            weekStr=@"星期一";
            break;
        case 3:
            weekStr=@"星期二";
            break;
        case 4:
            weekStr=@"星期三";
            break;
        case 5:
            weekStr=@"星期四";
            break;
        case 6:
            weekStr=@"星期五";
            break;
        case 7:
            weekStr=@"星期六";
            break;
            
        default:
            break;
    }
//    NSLog(@"%ld年%ld月%ld日%ld时%ld分%ld秒  %@",(long)year,(long)month,(long)day,(long)hour,(long)min,(long)sec,weekStr);
    
    _firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight * 0.06)];
    _firstView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.01, _firstView.origin.y+_firstView.size.height+KScreenHeight * 0.01, KScreenWidth * 0.12, KScreenHeight * 0.08)];
    _dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
    _dayLabel.font = [UIFont systemFontOfSize:35];
    
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayLabel.origin.x+_dayLabel.size.width+KScreenWidth * 0.01, _firstView.origin.y+_firstView.size.height+KScreenHeight * 0.01, KScreenWidth * 0.3, KScreenHeight * 0.04)];
    _weekLabel.text = weekStr;
    _weekLabel.font = [UIFont systemFontOfSize:14];
    
    _yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayLabel.origin.x+_dayLabel.size.width+KScreenWidth * 0.01, _weekLabel.origin.y+_weekLabel.size.height, KScreenWidth * 0.3, KScreenHeight * 0.02)];
    _yearAndMonthLabel.font = [UIFont systemFontOfSize:14];
    _yearAndMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_yearAndMonthLabel.origin.x+_yearAndMonthLabel.size.width+KScreenWidth * 0.02, _firstView.origin.y+_firstView.size.height+KScreenHeight * 0.02, KScreenWidth * 0.4, KScreenHeight * 0.04)];
    _titleLabel.text = @"开始新的航程...";
    
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, _dayLabel.origin.y+_dayLabel.size.height+KScreenHeight * 0.01, KScreenWidth, KScreenHeight * 0.08)];
    _secondView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, KScreenHeight * 0.025, KScreenWidth * 0.25, KScreenHeight * 0.055)];
    label.text = @"注册信息";
    label.backgroundColor = [UIColor colorWithRed:56/255.0 green:196/255.0 blue:213/255.0 alpha:1];
    
    _emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.1, _secondView.origin.y+_secondView.size.height+KScreenHeight * 0.01, KScreenWidth * 0.3, KScreenHeight * 0.05)];
    _emailLabel.text = @"请输入邮箱";
    
    _emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(_emailLabel.origin.x+_emailLabel.size.width+KScreenWidth * 0.02, _secondView.origin.y+_secondView.size.height+KScreenHeight * 0.01, KScreenWidth * 0.4, KScreenHeight * 0.05)];
    _emailTextField.borderStyle = UITextBorderStyleBezel;
    
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.1, _emailLabel.origin.y+_emailLabel.size.height+KScreenHeight * 0.02, KScreenWidth * 0.3, KScreenHeight * 0.05)];
    _passwordLabel.text = @"设置密码";
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(_passwordLabel.origin.x+_passwordLabel.size.width+KScreenWidth * 0.02, _emailLabel.origin.y+_emailLabel.size.height+KScreenHeight * 0.02, KScreenWidth * 0.4, KScreenHeight * 0.05)];
    _passwordTextField.borderStyle = UITextBorderStyleBezel;
    _passwordTextField.placeholder = @"不少于6位";
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.1, _passwordLabel.origin.y+_passwordLabel.size.height+KScreenHeight * 0.02, KScreenWidth * 0.3, KScreenHeight * 0.05)];
    _nameLabel.text = @"显示名称";
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(_nameLabel.origin.x+_nameLabel.size.width+KScreenWidth * 0.02, _passwordLabel.origin.y+_passwordLabel.size.height+KScreenHeight * 0.02, KScreenWidth * 0.4, KScreenHeight * 0.05)];
    _nameTextField.borderStyle = UITextBorderStyleBezel;
    
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, _nameLabel.origin.y+_nameLabel.size.height+KScreenHeight * 0.02, KScreenWidth, KScreenHeight)];
    _thirdView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    _LogInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LogInBtn.frame = CGRectMake(KScreenWidth * 0.25, KScreenHeight * 0.05, KScreenWidth * 0.5, KScreenHeight * 0.04);
    _LogInBtn.layer.borderWidth = 1.0;
    _LogInBtn.layer.cornerRadius = 4.5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){0,0,0,1});
    _LogInBtn.layer.borderColor = borderColorRef;
    _LogInBtn.backgroundColor = [UIColor whiteColor];
    [_LogInBtn setTitle:@"立刻加入大船" forState:UIControlStateNormal];
    [_LogInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_LogInBtn addTarget:self action:@selector(logInBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    
    _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _registBtn.frame = CGRectMake(KScreenWidth * 0.25, _LogInBtn.origin.y+_LogInBtn.size.height+KScreenHeight * 0.05, KScreenWidth * 0.5, KScreenHeight * 0.04);
    _registBtn.layer.borderWidth = 1.0;
    _registBtn.layer.cornerRadius = 4.5;
    _registBtn.layer.borderColor = borderColorRef;
    _registBtn.backgroundColor = [UIColor whiteColor];
    [_registBtn setTitle:@"已经注册过了" forState:UIControlStateNormal];
    [_registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _bigBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, _nameLabel.origin.y+_nameLabel.size.height+KScreenHeight * 0.04)];
    [_bigBtn addTarget:self action:@selector(bigBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [_thirdView addSubview:_LogInBtn];
    [_thirdView addSubview:_registBtn];
    [_secondView addSubview:label];
    
    [self addSubview:_firstView];
    [self addSubview:_dayLabel];
    [self addSubview:_weekLabel];
    [self addSubview:_yearAndMonthLabel];
    [self addSubview:_titleLabel];
    [self addSubview:_secondView];
    [self addSubview:_thirdView];
    [self addSubview:_emailLabel];
    [self addSubview:_passwordLabel];
    [self addSubview:_nameLabel];
    [self addSubview:_bigBtn];
    [self addSubview:_emailTextField];
    [self addSubview:_passwordTextField];
    [self addSubview:_nameTextField];
    
}

- (void)bigBtnMethod{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
}

- (void)logInBtnMethod{
    //注册的方法

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL b = [emailTest evaluateWithObject:_emailTextField.text];
    if (b == 0) {
        UIAlertView *aletr = [[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱格式不正确，正确格式为xxx@xxx.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aletr show];
    }else{
        NSLog(@"注册成功");
        NSString *url = @"http://101.200.91.181:81/api_user/reg.htm";
        NSDictionary *dic = @{
                              @"email" : _emailTextField.text,
                              @"password" : _passwordTextField.text,
                              @"name":_nameTextField.text
                              };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//            NSLog(@"－－－－－－－－－－－－－－－%@－－－－－－－－－－－%@－－－－－－－－－－%@",[dic objectForKey:@"message"],[dic objectForKey:@"result"],[dic objectForKey:@"token"]);
            
            NSString *str = _emailTextField.text;
            
            NSDictionary *tokenDic = [NSDictionary dictionaryWithObjects:@[[dic objectForKey:@"token"],_nameTextField.text,_emailTextField.text] forKeys:@[str,@"name",@"email"]];
            [_tokenMuArr addObject:tokenDic];
            
            [_tokenUserDefaults setObject:_tokenMuArr forKey:@"tokenMuArr"];
            [_tokenUserDefaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
            
            //跳入到原来的界面
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([_tokenUserDefaults objectForKey:@"token"]) {
        if ([self respondsToSelector:@selector(pushNewAppreciate_ViewController:)]) {
            [self.delegateRegist pushNewAppreciate_ViewController:_info];
        }
    }
}

// 已经注册过了
- (void)registBtnMethod{
//    NSLog(@"＝＝＝＝＝＝＝＝＝＝＝＝ %@",[_tokenUserDefaults objectForKey:@"token"]);

    [self.delegateRegist logIn:_info];
}

@end
