//
//  EditLogStyleViewController.m
//  DaChuan
//
//  Created by DaChuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "EditLogStyleViewController.h"
#import "EditCollectionViewCell.h"
#import "EditCollectionViewHeader.h"
#import "common.h"

@interface EditLogStyleViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong) UICollectionView *editCollectionView;

@end



@implementation EditLogStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示格子
    [self addStyles];
    
    //tabBar
    [self addTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addStyles
{
    //CollectionView配置
    //布局
    CGFloat Margin = 5;
    CGFloat logContentW = KScreenWidth;
    CGFloat kItemH = (logContentW - 1)*0.96;
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemH*0.5, kItemH*3/4*0.5); // 每一个网格的尺寸
    layout.minimumLineSpacing = Margin; // 每一行之间的间距
    layout.minimumInteritemSpacing = 1;//每一列之间的间距
    layout.sectionInset=UIEdgeInsetsMake(Margin, Margin, 0, Margin);
    //设置header大小
    layout.headerReferenceSize = CGSizeMake(KScreenWidth, 70);
    
    _editCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, logContentW, KScreenHeight - 49) collectionViewLayout:layout];
    _editCollectionView.delegate = self;
    _editCollectionView.dataSource = self;
    _editCollectionView.backgroundColor = [UIColor clearColor];
    _editCollectionView.showsVerticalScrollIndicator = NO;
    
    [_editCollectionView registerClass:[EditCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_editCollectionView registerClass:[EditCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    [self.view addSubview:_editCollectionView];
    
}

#pragma methed - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (long)self.titleArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const ID=@"cell";
    EditCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    [cell sizeToFit];
    
    [cell.dele addTarget:self action:@selector(deleteItem:) forControlEvents:UIControlEventTouchUpInside];
    cell.title = self.titleArray[indexPath.row];
    cell.cellIndex = indexPath.row;
    return cell;
}

-(void)deleteItem:(UIButton *)btn
{
    NSInteger index = btn.tag;
    [self.titleArray removeObjectAtIndex:index];
    
    [self.editCollectionView reloadData];
}

#pragma methed - 设置CollectionViewHeader
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    EditCollectionViewHeader *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    view.date = self.currentDate;
    
    return view;
}


-(void)addTabBar
{
    UIView *tabBar = [[UIView alloc]init];
    tabBar.frame = CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49);
    tabBar.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tabBar];
    
    CGFloat btnWH = 30;
    CGFloat marginH = (KScreenWidth - btnWH*4)/5;
    CGFloat marginV = (49 - btnWH)/2;
    
    for (NSInteger i=0; i < 4; i++)
    {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(marginH + (marginH + btnWH)*i, marginV, btnWH, btnWH)];
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn.tag = 0;
                [btn setBackgroundImage:[UIImage imageNamed:@"Edit_back"] forState:UIControlStateNormal];
                break;
            case 1:
                btn.tag = 1;
                [btn setBackgroundImage:[UIImage imageNamed:@"Edit_add_72"] forState:UIControlStateNormal];
                break;
            case 2:
                btn.tag = 2;
                [btn setBackgroundImage:[UIImage imageNamed:@"Edit_refresh"] forState:UIControlStateNormal];
                break;
            case 3:
                btn.tag = 3;
                [btn setBackgroundImage:[UIImage imageNamed:@"Edit_sure"] forState:UIControlStateNormal];
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
        //取消（不保存操作返回）
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (index == 1 )
    {
        //添加新的格式
        [self.titleArray addObject:@"今天你对他人微笑了吗？"];
        [self.editCollectionView reloadData];
    }
    else if (index == 2 )
    {
        //从库中刷新格式
        //[self.editCollectionView reloadData];
    }
    else if (index == 3)
    {
        //保存操作并返回
        //[self.editCollectionView reloadData];
    }
}

-(NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TitleList.plist" ofType:nil]];
        _titleArray = [NSMutableArray arrayWithArray:array];
    }
    
    return _titleArray;
}

-(void)setCurrentDate:(NSString *)currentDate
{
    _currentDate = currentDate;
    
}

@end
