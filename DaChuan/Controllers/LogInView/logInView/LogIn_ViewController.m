//
//  LogIn_ViewController.m
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LogIn_ViewController.h"
#import "Regist_ViewController.h"

@interface LogIn_ViewController ()

@end

@implementation LogIn_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上船";
    self.navigationController.navigationBar.translucent = NO;
    
    LogInView *logInView = [[LogInView alloc] initWithFrame:self.view.bounds];
    logInView.logInDelegate = self;
    
    [self.view addSubview:logInView];
    
}

-(void)logInBtnClick:(Info *)info{
//    NSLog(@"    ---------%@",info.name);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)lostBtnClick:(Info *)info{
    NSLog(@"忘记口令           %@",info.name);
}

-(void)createNewNameBtnClick{
    Regist_ViewController *regist = [[Regist_ViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
