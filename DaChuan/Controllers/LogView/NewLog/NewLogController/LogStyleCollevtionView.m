//
//  LogStyleCollevtionView.m
//  DaChuan
//
//  Created by DaChuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LogStyleCollevtionView.h"
#import "CollectionViewCell.h"
#import "CollectionViewHeader.h"
#import "SystemCurrectDate.h"
#import "common.h"

@interface LogStyleCollevtionView()

@property (nonatomic , strong) NSMutableArray *titleArray;

@end

@implementation LogStyleCollevtionView

static NSString *const ID=@"deal";

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CollectionViewCell class]  forCellWithReuseIdentifier:ID];
        [self registerClass:[CollectionViewHeader class]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    }
    return self;
}

#pragma methed - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:220/255.0 green:251/255.0 blue:221/255.0 alpha:1];
    
    CGFloat Margin = 5;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Margin, Margin, cell.frame.size.width - 2*Margin + 2, cell.frame.size.height*0.5)];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.numberOfLines = 0;
    titleLabel.text = self.titleArray[indexPath.row];
    
    [cell.contentView addSubview:titleLabel];
    return cell;
}

#pragma methed - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if ([self.LogStyleDelegate respondsToSelector:@selector(ToEditLogViewController:TextOfTitle:)]) {
        [self.LogStyleDelegate ToEditLogViewController:self TextOfTitle:index];
    }
}

#pragma methed - 设置CollectionViewHeader
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    view.userInteractionEnabled=YES;
    view.backgroundColor = [UIColor whiteColor];
    
    CGFloat LabelDayW = 28;
    CGFloat Marign = 12;
    
    //几号
    _labelDay = [[UILabel alloc]initWithFrame:CGRectMake(Marign, Marign, LabelDayW, LabelDayW)];
    _labelDay.text = [SystemCurrectDate backSystemCurrentToday];
    _labelDay.font = [UIFont systemFontOfSize:24];
    _labelDay.textColor = [UIColor blackColor];
    [view addSubview:_labelDay];
    
    //周几
    _labelWeek = [[UILabel alloc] initWithFrame:CGRectMake(_labelDay.width + Marign + 1, _labelDay.frame.origin.y + 3, LabelDayW, LabelDayW*0.5 - 2)];
    _labelWeek.text = [SystemCurrectDate backSystemCurrentWeek];
    _labelWeek.font = [UIFont systemFontOfSize:8];
    _labelWeek.textColor = [UIColor grayColor];
    [view addSubview:_labelWeek];
    
    //年月
    _date = [[UILabel alloc]initWithFrame:CGRectMake(_labelDay.width + Marign + 1, _labelWeek.bottom, 80, _labelWeek.height)];
    _date.text = [SystemCurrectDate backSystemCurrentYearAndMouth];
    _date.font = [UIFont systemFontOfSize:8];
    _date.textColor = [UIColor grayColor];
    _date.textAlignment = NSTextAlignmentLeft;
    [view addSubview:_date];
    
    //心情图片
    CGFloat emotionImageW = (KScreenWidth*0.5 - Marign *3)/5;
    for (NSInteger i=0; i < 5; i ++) {
        _emotionImage = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth*0.5 + Marign + emotionImageW*i, _date.bottom + 4, emotionImageW, emotionImageW)];
        [_emotionImage setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"line_egg_128px_%ld",(long)i]] forState:UIControlStateNormal];
        [_emotionImage setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"line_egg_128px_%ld",(long)i]] forState:UIControlStateSelected];
        
        [_emotionImage addTarget:self action:@selector(selectedEmotion:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_emotionImage];
        
    }

    
    return view;
}

//选择心情
-(void)selectedEmotion:(UIButton *)btnImage
{
    _selectedImage.selected = NO;
    
    btnImage.selected = YES;
    _selectedImage = btnImage;
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
