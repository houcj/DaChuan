//
//  SeePublicAppreciate_ViewController.m
//  DaChuan
//
//  Created by dachuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "SeePublicAppreciate_ViewController.h"

@interface SeePublicAppreciate_ViewController ()

@end

@implementation SeePublicAppreciate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"感悟";
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame = CGRectMake(KScreenWidth*0.7, KScreenHeight*0.05, KScreenWidth*0.1, KScreenHeight*0.1);
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    _shareBtn.backgroundColor = [UIColor yellowColor];
    [_shareBtn addTarget:self action:@selector(shareBtnMethod) forControlEvents:UIControlEventTouchDragInside];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:_shareBtn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    Public_View *publicView = [[Public_View alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [publicView setInfo:_info];
    publicView.delegate = self;
    [self.view addSubview:publicView];
    
}

- (void)shareBtnMethod{
    //不需要接口
    NSLog(@"--------------------分享－－－－－－－－－－－－－－");
}

-(void)public_ViewProtocol:(Info *)info{

}

- (void)public_ViewToLogInViewController:(Public_View *)Public_View{
    //跳转至登录界面
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
