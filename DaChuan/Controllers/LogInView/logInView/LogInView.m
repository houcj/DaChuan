//
//  LogInView.m
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//


#import "LogInView.h"
#import "AFNetworking.h"
#import "common.h"

@implementation LogInView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

-(void)createView{
    
    _tokenUserDefaults = [NSUserDefaults standardUserDefaults];
    
    self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    _backgroundBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [_backgroundBtn addTarget:self action:@selector(backgroundBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backgroundBtn];
    
    //获取时间
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
    NSLog(@"%ld年%ld月%ld日%ld时%ld分%ld秒  %@",(long)year,(long)month,(long)day,(long)hour,(long)min,(long)sec,weekStr);
    
    _view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight * 0.05)];
    _view1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth * 0.01, _view1.size.height+KScreenHeight*0.01, KScreenWidth*0.12, KScreenHeight*0.08)];
    _dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
    _dayLabel.font = [UIFont systemFontOfSize:35];
    
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayLabel.origin.x+_dayLabel.size.width, _view1.size.height+KScreenHeight*0.02, KScreenWidth*0.4, KScreenHeight*0.03)];
    _weekLabel.text = [NSString stringWithFormat:@"%@",weekStr];
    _weekLabel.font = [UIFont systemFontOfSize:14];
    
    _yearAndMonthLabel = [[UILabel alloc] initWithFrame:CGRectMake(_dayLabel.origin.x+_dayLabel.size.width, _weekLabel.origin.y+_weekLabel.size.height, KScreenWidth*0.4, KScreenHeight*0.03)];
    _yearAndMonthLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month];
    _yearAndMonthLabel.font = [UIFont systemFontOfSize:14];
    
    
    [self addSubview:_dayLabel];
    [self addSubview:_weekLabel];
    [self addSubview:_yearAndMonthLabel];
    
    _view2 = [[UIView alloc] initWithFrame:CGRectMake(0, _yearAndMonthLabel.origin.y + _yearAndMonthLabel.size.height +KScreenHeight * 0.01, KScreenWidth, KScreenHeight*0.07)];
    _view2.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth*0.1, _view2.origin.y+_view2.size.height+KScreenHeight*0.03, KScreenWidth*0.25, KScreenHeight*0.05)];
    _nameLabel.text = @"用户名";
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(_nameLabel.origin.x+_nameLabel.size.width+KScreenWidth*0.03, _view2.origin.y+_view2.size.height+KScreenHeight*0.03, KScreenWidth*0.5, KScreenHeight*0.05)];
    _nameTextField.borderStyle = UITextBorderStyleBezel;
    _nameTextField.placeholder = @"请输入邮箱名";
    
    _passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth*0.1, _nameLabel.origin.y+_nameLabel.size.height+KScreenHeight*0.03, KScreenWidth*0.25, KScreenHeight*0.05)];
    _passwordLabel.textAlignment = NSTextAlignmentLeft;
    _passwordLabel.text = @"输入口令";
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(_passwordLabel.origin.x+_passwordLabel.size.width+KScreenWidth*0.03, _nameLabel.origin.y+_nameLabel.size.height+KScreenHeight*0.03, KScreenWidth*0.5, KScreenHeight*0.05)];
    _passwordTextField.placeholder = @"不少于6位";
    _passwordTextField.borderStyle = UITextBorderStyleBezel;
    
    _logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _logInBtn.frame = CGRectMake(KScreenWidth*0.15, _passwordLabel.origin.y+_passwordLabel.size.height+KScreenHeight*0.06, KScreenWidth*0.3, KScreenHeight*0.05);
    _logInBtn.layer.borderWidth = 1.0;
    _logInBtn.layer.cornerRadius = 4.5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColorRef = CGColorCreate(colorSpace, (CGFloat[]){0,0,0,1});
    _logInBtn.layer.borderColor = borderColorRef;
    [_logInBtn setTitle:@"立刻上船" forState:UIControlStateNormal];
    [_logInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_logInBtn addTarget:self action:@selector(logInBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _lostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lostBtn.frame = CGRectMake(_logInBtn.origin.x+_logInBtn.size.width+KScreenWidth*0.1, _passwordLabel.origin.y+_passwordLabel.size.height+KScreenHeight*0.06, KScreenWidth*0.3, KScreenHeight*0.05);
    [_lostBtn setTitle:@"忘记口令？" forState:UIControlStateNormal];
    [_lostBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _lostBtn.layer.borderWidth = 1.0;
    _lostBtn.layer.cornerRadius = 4.5;
    _lostBtn.layer.borderColor = borderColorRef;
    [_lostBtn addTarget:self action:@selector(lostBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _view3 = [[UIView alloc] initWithFrame:CGRectMake(0, _logInBtn.origin.y+_logInBtn.size.height+KScreenHeight*0.07, KScreenWidth, KScreenHeight-(_logInBtn.origin.y+_logInBtn.size.height))];
    _view3.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:237/255.0 alpha:1];
    
    _createNewNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _createNewNameBtn.frame = CGRectMake(KScreenWidth*0.25, KScreenHeight*0.06, KScreenWidth*0.5, KScreenHeight*0.05);
    _createNewNameBtn.layer.borderWidth = 1.0;
    _createNewNameBtn.layer.cornerRadius = 4.5;
    _createNewNameBtn.layer.borderColor = borderColorRef;
    _createNewNameBtn.backgroundColor = [UIColor whiteColor];
    [_createNewNameBtn setTitle:@"创建新账号" forState:UIControlStateNormal];
    [_createNewNameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_createNewNameBtn addTarget:self action:@selector(createNewNameBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [_view3 addSubview:_createNewNameBtn];
    
    [self addSubview:_view1];
    [self addSubview:_view2];
    [self addSubview:_nameLabel];
    [self addSubview:_passwordLabel];
    [self addSubview:_nameTextField];
    [self addSubview:_passwordTextField];
    [self addSubview:_logInBtn];
    [self addSubview:_lostBtn];
    [self addSubview:_view3];
    
}

-(void)logInBtnMethod{
    Info *info = [[Info alloc] init];
    _tokenArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tokenMuArr"];
    
    NSString *url = @"http://101.200.91.181:81/api_user/login.htm";
    NSDictionary *dic1 = @{
                           @"email":_nameTextField.text,
                           @"password":_passwordTextField.text
                           };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"－－－－－－－－－－－－－－－%@－－－－－－－－－－－%@------%@------%@",[dic objectForKey:@"message"],[dic objectForKey:@"result"],[dic objectForKey:@"token"],[dic objectForKey:@"name"]);
        
        _resultStr = [dic objectForKey:@"result"];
        
        [_tokenUserDefaults setObject:[dic objectForKey:@"token"] forKey:@"token"];
        
        //跳入到原来的界面
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }];

        [self.logInDelegate logInBtnClick:info];
    
}
-(void)lostBtnMethod{
    Info *info = [[Info alloc] init];
    info.name = _nameTextField.text;
    [_logInDelegate lostBtnClick:info];
    
    NSString *url = @"http://101.200.91.181:81/api_user/pwd.htm";
    NSDictionary *dic = @{
                          @"email":_nameTextField.text
                          };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"－－－－－－－－－－－－－－－%@－－－－－－－－－－－%@",[dic objectForKey:@"message"],[dic objectForKey:@"result"]);
        
        //跳入到原来的界面
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[dic objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"===>%@",error);
    }];
}
-(void)createNewNameBtnMethod{
    
    [_logInDelegate createNewNameBtnClick];
    
}
-(void)backgroundBtnMethod{
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

@end
