//
//  ViewController.m
//  Demo
//
//  Created by DaChuan on 15/9/17.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "MainViewController.h"
#import "common.h"
#import "FindView.h"
#import "AppreciateView.h"
#import "LogView.h"
#import "MineView.h"
#import "SkimLogViewController.h"
#import "NewLogViewController.h"

#import "NewAppreciate_ViewController.h"
#import "LogIn_ViewController.h"
#import "SeePublicAppreciate_ViewController.h"
#import "Regist_ViewController.h"


@interface MainViewController ()<UIScrollViewDelegate,UITabBarDelegate,LogViewDelegate,AppreciateViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIView *tabBar;
@property (nonatomic ,strong) UIButton *selectedBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    //隐藏自带的导航栏
    self.navigationController.navigationBarHidden = YES;
    
    //添加底部bar
    [self customTabbar];
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //添加视图
    [self addViews];
}

-(void)customTabbar
{
    _tabBar = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49)];
    _tabBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBar];
    
    CGFloat btnWH = 30;
    CGFloat marginH = (KScreenWidth - btnWH*4)/5;
    CGFloat marginV = (49 - btnWH)/2;
    
    for (NSInteger i=0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(marginH + (marginH + btnWH)*i, marginV, btnWH, btnWH)];
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn.tag = 0;
                [btn setTitle:@"日志" forState:UIControlStateNormal];
                [btn setTitle:@"日志" forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                break;
            case 1:
                btn.tag = 1;
                [btn setTitle:@"感悟" forState:UIControlStateNormal];
                [btn setTitle:@"感悟" forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                //设置为被默认选中
                btn.selected = YES;
                _selectedBtn = btn;
                break;
            case 2:
                btn.tag = 2;
                [btn setTitle:@"发现" forState:UIControlStateNormal];
                [btn setTitle:@"发现" forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                break;
            case 3:
                btn.tag = 3;
                [btn setTitle:@"我的" forState:UIControlStateNormal];
                [btn setTitle:@"我的" forState:UIControlStateSelected];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                break;
        }
        
        [btn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:btn];
    }
    
    
}

//底部Bar按钮与视图联动
-(void)changeView:(UIButton *)selectBtn
{
    _selectedBtn.selected = NO;
    selectBtn.selected = YES;
    _selectedBtn = selectBtn;
    
    NSInteger i = selectBtn.tag;
    _scrollView.contentOffset = CGPointMake(KScreenWidth*i, 0);
}

-(void)addViews
{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    
    LogView *logView = [[LogView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
    logView.backgroundColor = [UIColor redColor];
    logView.logdelegate = self;
    [_scrollView addSubview:logView];
    
    AppreciateView *appreciateView = [[AppreciateView alloc]initWithFrame:CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight - 49)];
    appreciateView.backgroundColor = [UIColor blueColor];
    appreciateView.AppreciateDelegate = self;
    [_scrollView addSubview:appreciateView];
    
    FindView *findView = [[FindView alloc]initWithFrame:CGRectMake(KScreenWidth*2, 0, KScreenWidth, KScreenHeight - 49)];
    findView.backgroundColor = [UIColor greenColor];
    [_scrollView addSubview:findView];
    
    MineView *mineView = [[MineView alloc]initWithFrame:CGRectMake(KScreenWidth*3, 0, KScreenWidth, KScreenHeight - 49)];
    mineView.backgroundColor = [UIColor cyanColor];
    [_scrollView addSubview:mineView];
    
    _scrollView.contentSize = CGSizeMake(KScreenWidth*4, KScreenHeight - 44 - 20 - 49);
    
    //设置默认显示中间
    _scrollView.contentOffset = CGPointMake(KScreenWidth, 0);
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_scrollView];
}

#pragma mothed - UIScrollViewDelegate
//根据Scroll偏移量做view和按钮的联动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _selectedBtn.selected = NO;
    
    NSInteger i = (_scrollView.contentOffset.x + _scrollView.frame.size.width/2)/KScreenWidth;
    UIButton *btn = (UIButton *)_tabBar.subviews[i];
    btn.selected = YES;
    _selectedBtn = btn;
    
}

#pragma mothed - LogViewDelegate
//从logView转至其它控制器
-(void)logViewToSkimLogViewController:(LogView *)LogView
{
    SkimLogViewController *skimLog = [[SkimLogViewController alloc]init];
    [self.navigationController pushViewController:skimLog animated:YES];
}

-(void)logViewToNewLogViewController:(LogView *)LogView
{
    NSLog(@"logView");
    NewLogViewController *Newlog = [[NewLogViewController alloc]init];
    [self.navigationController pushViewController:Newlog animated:YES];
}
//转至新感悟控制器
-(void)AppreciateViewToNewAppreciate_ViewController:(AppreciateView *)appreciateView{
    NewAppreciate_ViewController *newAppreciate = [[NewAppreciate_ViewController alloc] init];
    [self.navigationController pushViewController:newAppreciate animated:YES];
}
//转至登录控制器
-(void)AppreciateVIewToLogIn_ViewController:(AppreciateView *)appreciateView{
    LogIn_ViewController *logIn = [[LogIn_ViewController alloc] init];
    [self.navigationController pushViewController:logIn animated:YES];
}
//转至注册控制器
- (void)AppreciateViewToRegist_ViewController:(AppreciateView *)appreciateView{
    NSLog(@"9999999999999");
    Regist_ViewController *regist = [[Regist_ViewController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

//转至公开浏览感悟控制器
- (void)AppreciateViewToSeePublicAppreciate_ViewController:(Info *)info{
    NSLog(@"----------------pushSeePublicAppreciate-------%@",info.content);
    SeePublicAppreciate_ViewController *seePublic = [[SeePublicAppreciate_ViewController alloc] init];
    seePublic.info = info;
    [self.navigationController pushViewController:seePublic animated:YES];
}
@end
