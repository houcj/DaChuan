//
//  SkimLogDetail.h
//  Demo
//
//  Created by DaChuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkimLogDetail : UIScrollView<UIScrollViewDelegate>
//1.顶部背景图
@property (nonatomic ,strong) UIImageView *topBackImage;
   //1.1几号
@property (nonatomic ,strong) UILabel *day;
   //1.2星期几
@property (nonatomic ,strong) UILabel *week;
   //1.3年月
@property (nonatomic ,strong) UILabel *year;
   //1.4心情图片
@property (nonatomic ,strong) UIImageView *feelImage;
//2.日志标题
@property (nonatomic ,strong) UILabel *logTitle;
//3.日志内容
@property (nonatomic ,strong) UILabel *logContent;
//4.日志图片
@property (nonatomic ,strong) UIImageView *logImage;

@end
