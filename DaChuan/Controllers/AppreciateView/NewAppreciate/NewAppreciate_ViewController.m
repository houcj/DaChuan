//
//  NewAppreciate_ViewController.m
//  DaChuan
//
//  Created by dachuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "NewAppreciate_ViewController.h"
#import "NewAppreciate_View.h"
#import "SeePublicAppreciate_ViewController.h"
#import "common.h"

@interface NewAppreciate_ViewController ()

@end

@implementation NewAppreciate_ViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NewAppreciate_View *newAppreciate = [[NewAppreciate_View alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    newAppreciate.delegate = self;
    [self.view addSubview:newAppreciate];
}

- (void)tagViewReserve:(Info *)info{
    //tagView点击保存被移除后调用协议
}

- (void)pushSeePublicAppreciate_View:(Info *)info{
    SeePublicAppreciate_ViewController *seePublicAppreciate = [[SeePublicAppreciate_ViewController alloc] init];
    seePublicAppreciate.info = info;
    NSLog(@"seePublicAppreciate.info==================%@",seePublicAppreciate.info.sid);
    [self.navigationController pushViewController:seePublicAppreciate animated:YES];
    
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
