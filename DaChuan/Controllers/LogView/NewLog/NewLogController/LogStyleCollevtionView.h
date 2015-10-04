//
//  LogStyleCollevtionView.h
//  DaChuan
//
//  Created by DaChuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogStyleCollevtionView;

@protocol LogStyleCollectionViewDelegate <NSObject>

-(void)ToEditLogViewController:(LogStyleCollevtionView *)LogStyleCollevtionView TextOfTitle:(NSInteger )title;

@end

@interface LogStyleCollevtionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) id<LogStyleCollectionViewDelegate>LogStyleDelegate;

//几号
@property (nonatomic ,strong) UILabel *labelDay;
//周几
@property (nonatomic ,strong) UILabel *labelWeek;
//年月
@property (nonatomic ,strong) UILabel *date;
//心情图片
@property (nonatomic ,strong) UIButton *emotionImage;
//被选中的心情图片
@property (nonatomic ,strong) UIButton *selectedImage;

@end
