//
//  NewLogViewController.m
//  DaChuan
//
//  Created by DaChuan on 15/9/22.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "NewLogViewController.h"
#import "LogStyleCollevtionView.h"
#import "EditLogViewController.h"
#import "EditLogStyleViewController.h"
#import "SystemCurrectDate.h"
#import "common.h"

@interface NewLogViewController ()<LogStyleCollectionViewDelegate>

//日志格式
@property (nonatomic ,strong) UIScrollView *logStyle;
@property (nonatomic ,strong) LogStyleCollevtionView *logContent;
@end

@implementation NewLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //日记格式
    _logStyle = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
    _logStyle.contentSize = CGSizeMake(KScreenWidth*6, _logStyle.frame.size.height);
    _logStyle.pagingEnabled = YES;
    _logStyle.showsHorizontalScrollIndicator = NO;
    _logStyle.showsVerticalScrollIndicator = NO;
    _logStyle.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_logStyle];
    
    //CollectionView配置
    //布局
    CGFloat Margin = 5;
    CGFloat logContentW = _logStyle.width;
    CGFloat kItemH = (logContentW - 1)*0.96;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemH*0.5, kItemH*3/4*0.5); // 每一个网格的尺寸
    layout.minimumLineSpacing = Margin; // 每一行之间的间距
    layout.minimumInteritemSpacing = 1;//每一列之间的间距
    layout.sectionInset=UIEdgeInsetsMake(Margin, Margin, 0, Margin);
    //设置header大小
    layout.headerReferenceSize = CGSizeMake(KScreenWidth, 70);
    
    for (NSInteger i=0; i<1; i++) {
        _logContent = [[LogStyleCollevtionView alloc]initWithFrame:CGRectMake(logContentW*i, 0, logContentW, _logStyle.height) collectionViewLayout:layout];
        _logContent.LogStyleDelegate = self;
        _logContent.backgroundColor = [UIColor clearColor];
        _logContent.showsVerticalScrollIndicator = NO;
        
        [_logStyle addSubview:_logContent];
    }

    
    //添加自定义tabBar
    [self costomTabBar];
    
    [self.logContent reloadData];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

#pragma mothed - 自定义tabBar
-(void)costomTabBar
{
    UIView *tabBar = [[UIView alloc]init];
    tabBar.frame = CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49);
    tabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    [self.view addSubview:tabBar];
    
    CGFloat btnWH = 30;
    CGFloat marginH = (KScreenWidth - btnWH*5)/6;
    CGFloat marginV = (49 - btnWH)/2;
    
    for (NSInteger i=0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(marginH + (marginH + btnWH)*i, marginV, btnWH, btnWH)];
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn.tag = 0;
                [btn setBackgroundImage:[UIImage imageNamed:@"newLog_back"] forState:UIControlStateNormal];
                break;
            case 1:
                btn.tag = 1;
                [btn setBackgroundImage:[UIImage imageNamed:@"newLog_arrowLeft"] forState:UIControlStateNormal];
                break;
            case 2:
                btn.tag = 2;
                [btn setBackgroundImage:[UIImage imageNamed:@"newLog_arrowRight"] forState:UIControlStateNormal];
                break;
            case 3:
                btn.tag = 3;
                [btn setBackgroundImage:[UIImage imageNamed:@"newLog_setting"] forState:UIControlStateNormal];
                break;
            case 4:
                btn.tag = 4;
                [btn setBackgroundImage:[UIImage imageNamed:@"newLog_label"] forState:UIControlStateNormal];
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
    else if (index == 1 && _logStyle.contentOffset.x > 0)
    {
        NSInteger i = (_logStyle.contentOffset.x - KScreenWidth)/KScreenWidth;
        [_logStyle setContentOffset:CGPointMake(KScreenWidth*i, _logStyle.contentOffset.y) animated:YES];
    }
    else if (index == 2 && _logStyle.contentOffset.x < KScreenWidth*(9 - 1))
    {
        NSInteger i = (_logStyle.contentOffset.x + KScreenWidth)/KScreenWidth;
        [_logStyle setContentOffset:CGPointMake(KScreenWidth*i, _logStyle.contentOffset.y) animated:YES];
    }
    else if (index == 3)
    {
        EditLogStyleViewController *editLogVC = [[EditLogStyleViewController alloc]init];
        editLogVC.modalPresentationStyle = UIModalPresentationPopover;
        editLogVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        editLogVC.currentDate = [SystemCurrectDate backSystemCurrentDate];
        [self presentViewController:editLogVC animated:YES completion:nil];
    }
    else if (index == 4)
    {
        
    }
}

#pragma methed - LogStyleCollectionViewDelegate
-(void)ToEditLogViewController:(LogStyleCollevtionView *)LogStyleCollevtionView TextOfTitle:(NSInteger)title
{
    EditLogViewController *editLog = [[EditLogViewController alloc]init];
    editLog.index = title;
    [self.navigationController pushViewController:editLog animated:YES];
    
}

-(NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TitleList.plist" ofType:nil]];
        _titleArray = [NSMutableArray arrayWithArray:array];
    }
    
    return _titleArray;
}


@end
