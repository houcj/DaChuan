//
//  SkimLogViewController.m
//  Demo
//
//  Created by DaChuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "SkimLogViewController.h"
#import "common.h"
#import "SkimLogDetail.h"
#import "UMSocial.h"

@interface SkimLogViewController()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) SkimLogDetail *detailView;
//(友盟)带屏幕阴影的分享视图
@property (nonatomic ,strong) UIView *windowShadowView;
//(友盟)底部弹出分享框架视图
@property (nonatomic ,strong) UIView *popupShareView;

@end

@implementation SkimLogViewController

-(void)loadView
{
    [super loadView];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
    [_scrollView setBackgroundColor:[UIColor grayColor]];
    _scrollView.pagingEnabled = YES;
    _scrollView.tag = 1;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //添加自定义tabBar
    [self costomTabBar];
    
    //初始化分享视图
    [self initShareView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (NSInteger i = 0; i < 9; i ++) {
        _detailView = [[SkimLogDetail alloc]initWithFrame:CGRectMake(KScreenWidth * i, 0, KScreenWidth, KScreenHeight - 49)];
        _detailView.delegate = self;
        [_scrollView addSubview:_detailView];
    }
    
    _scrollView.contentSize = CGSizeMake(KScreenWidth * 9, KScreenHeight - 49 - 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mothed - 自定义tabBar
-(void)costomTabBar
{
    UIView *tabBar = [[UIView alloc]init];
    tabBar.frame = CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49);
    //tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabBar_bc"]];
    [self.view addSubview:tabBar];
    
    CGFloat btnWH = 22;
    CGFloat marginH = (KScreenWidth - btnWH*4)/5;
    CGFloat marginV = (49 - btnWH)/2;
    
    for (NSInteger i=0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(marginH + (marginH + btnWH)*i, marginV, btnWH, btnWH)];
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn.tag = 0;
                [btn setBackgroundImage:[UIImage imageNamed:@"3d_square_120"] forState:UIControlStateNormal];
                break;
            case 1:
                btn.tag = 1;
                [btn setBackgroundImage:[UIImage imageNamed:@"arrow_left_128"] forState:UIControlStateNormal];
                break;
            case 2:
                btn.tag = 2;
                [btn setBackgroundImage:[UIImage imageNamed:@"arrow_right_128"] forState:UIControlStateNormal];
                break;
            case 3:
                btn.tag = 3;
                [btn setBackgroundImage:[UIImage imageNamed:@"twitter_157"] forState:UIControlStateNormal];
                break;
        }
        
        [btn addTarget:self action:@selector(clikBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        [tabBar addSubview:btn];
    }
    
}

-(void)clikBarBtn:(UIButton *)button
{
    NSInteger index = button.tag;
    if (index == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (index == 1 && _scrollView.contentOffset.x > 0)
    {
        NSInteger i = (_scrollView.contentOffset.x - KScreenWidth)/KScreenWidth;
        [_scrollView setContentOffset:CGPointMake(KScreenWidth*i, _scrollView.contentOffset.y) animated:YES];
    }
    else if (index == 2 && _scrollView.contentOffset.x < KScreenWidth*(9 - 1))
    {
        NSInteger i = (_scrollView.contentOffset.x + KScreenWidth)/KScreenWidth;
        [_scrollView setContentOffset:CGPointMake(KScreenWidth*i, _scrollView.contentOffset.y) animated:YES];
    }
    else if (index == 3)
    {
        //弹出分享
        [self shareAction];
    }
    
}

#pragma mark - 弹出分享
-(void)shareAction
{
    _windowShadowView.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = _popupShareView.frame;
        frame.origin.y = KScreenHeight-200;
        _popupShareView.frame = frame;
    }];
}

#pragma mark - 初始化分享视图
- (void)initShareView
{
    _windowShadowView = [[UIView alloc] init];
    _windowShadowView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    _windowShadowView.hidden = YES;
    _windowShadowView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.3500];
    [self.view bringSubviewToFront:_windowShadowView];
    [self.view addSubview:_windowShadowView];
    
    
    //分享框架View
    _popupShareView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 200)];
    _popupShareView.backgroundColor = [UIColor clearColor];
    [_windowShadowView addSubview:_popupShareView];
    
    //分享View
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 150)];
    shareView.backgroundColor = [UIColor whiteColor];
    [_popupShareView addSubview:shareView];
    
    //取消View
    UIView *cancelView = [[UIView alloc] initWithFrame:CGRectMake(0, 155, KScreenWidth, 45)];
    cancelView.backgroundColor = [UIColor whiteColor];
    [_popupShareView addSubview:cancelView];
    
    //分享标题
    UILabel *shareTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 45)];
    shareTitle.text = @"分享";
    shareTitle.textAlignment = NSTextAlignmentCenter;
    shareTitle.textColor = [UIColor colorWithRed:0.620 green:0.616 blue:0.616 alpha:1.000];
    [shareView addSubview:shareTitle];
    
    
    NSArray *ShareImageArr =[NSArray arrayWithObjects:@"xinlangweibo",@"xinlangweibo",@"xinlangweibo",@"xinlangweibo", nil];
    NSArray *ShareNameArr = [NSArray arrayWithObjects:@"新浪微博",@"微信好友",@"微信朋友圈",@"邮箱", nil];
    
    /*
     创建分享按钮
     **/
    
    CGFloat Margin = 8;
    CGFloat imageAndBtnW = (_popupShareView.width - Margin*5)/4;
    for (int i = 0; i<ShareImageArr.count; i++) {
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Margin+(imageAndBtnW+Margin)*i , 36, imageAndBtnW, imageAndBtnW)];
        [image setImage:[UIImage imageNamed:ShareImageArr[i]]];
        [_popupShareView addSubview:image];
        
        UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        shareBtn.tag = i+1;
        shareBtn.frame = CGRectMake(Margin-5+(imageAndBtnW+Margin)*i , 36, imageAndBtnW+10, 100);
        [shareBtn setTitle:ShareNameArr[i] forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor colorWithWhite:0.224 alpha:1.000] forState:UIControlStateNormal];
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 20, 0, 0);
        shareBtn.titleEdgeInsets = UIEdgeInsetsMake(80, 0, 0, 0);
        [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_popupShareView addSubview:shareBtn];
    }
    
    UIButton *quxiaoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    quxiaoBtn.frame = CGRectMake(0, 0, KScreenWidth, 45);
    quxiaoBtn.backgroundColor = [UIColor whiteColor];
    [quxiaoBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [quxiaoBtn setTitleColor:[UIColor colorWithWhite:0.224 alpha:1.000] forState:(UIControlStateNormal)];
    [quxiaoBtn addTarget:self action:@selector(cancelShare) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelView addSubview:quxiaoBtn];
}

#pragma mark - 分享点击事件
-(void)shareClick:(UIButton *)sender
{
    UIButton *Btn = (UIButton *)sender;
    NSInteger index = Btn.tag-1;
    switch (index) {
        case 0:
            [self shareXilang]; //分享新浪微博
            
            break;
        case 1:
            [self shareWeixin]; //分享微信好友
            
            break;
        case 2:
            [self shareWeixinCircle]; //分享微信朋友圈
            
            break;
        case 3:
            [self shareEmail]; //分享邮箱
            
            break;
            
        default:
            break;
    }
}

//分享新浪微博
-(void)shareXilang {
   // NSLog(@"//分享新浪微博");
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
    {
        [self cancelShare];
        
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"分享成功了哦～" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"啊哦 分享没成功呀" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }

    }];
}

//分享微信好友
-(void)shareWeixin
{
   // NSLog(@"//分享微信好友");
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
    {
        [self cancelShare];
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"分享成功了哦～" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"啊哦 分享没成功呀" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }

    }];
    
}

//分享微信朋友圈
-(void)shareWeixinCircle
{

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
    {
        [self cancelShare];
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"分享成功了哦～" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"啊哦 分享没成功呀" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }

    }];
    
}

//分享邮箱
-(void)shareEmail
{

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToEmail] content:_detailView.logContent.text image:_detailView.logImage.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response)
    {
        [self cancelShare];
        
        if (response.responseCode == UMSResponseCodeSuccess)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"分享成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"大船提醒" message:@"分享失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [alertView show];
        }

    }];
    
}

#pragma mark - 取消分享
-(void)cancelShare
{
    [UIView animateWithDuration:0 animations:^{
        CGRect frame = _popupShareView.frame;
        frame.origin.y = KScreenWidth;
        _popupShareView.frame = frame;
    } completion:^(BOOL finished)
    {
        _windowShadowView.hidden = YES;
    }];
}

@end
