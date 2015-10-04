//
//  Regist_ViewController.m
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "Regist_ViewController.h"
#import "LogIn_ViewController.h"
#import "NewAppreciate_ViewController.h"
#import "common.h"

@interface Regist_ViewController ()

@end

@implementation Regist_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.navigationController.navigationBar.translucent = NO;
    Regist_View *regist = [[Regist_View alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    regist.delegateRegist = self;
    [self.view addSubview:regist];
}
//进入新感悟界面
- (void)pushNewAppreciate_ViewController:(Info *)info{
    NewAppreciate_ViewController *newAppreciate = [[NewAppreciate_ViewController alloc] init];
    newAppreciate.info = info;
    [self.navigationController pushViewController:newAppreciate animated:YES];
}

- (void)logIn:(Info *)info{
    LogIn_ViewController *logIn = [[LogIn_ViewController alloc] init];
    logIn.infoLogIn_VC = info;
    [self.navigationController pushViewController:logIn animated:YES];
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
