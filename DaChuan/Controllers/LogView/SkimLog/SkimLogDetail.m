//
//  SkimLogDetail.m
//  Demo
//
//  Created by DaChuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "SkimLogDetail.h"
#import "GPUImage.h"
#import "common.h"

@implementation SkimLogDetail

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        [self addSubViews];
        
    }
    return self;
}

-(void)addSubViews
{
    //1.顶部背景图
    _topBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, KScreenWidth - 2, 100)];
    //_topBackImage.image = blurImage;
    
    NSBlockOperation *loadFilter = [NSBlockOperation  blockOperationWithBlock:^{
        
        //1.1图片模糊(把第一张图片模糊，用于顶部背景图)
        GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
        blurFilter.blurRadiusInPixels = 5.0;
        UIImage * image = [UIImage imageNamed:@"topBackImage.png"];
        _topBackImage.image = [blurFilter imageByFilteringImage:image];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:loadFilter];
    
    [self addSubview:_topBackImage];
    
    CGFloat MarginLeft = 12;
    CGFloat MarginTop = 3;
    CGFloat dayWidth = 32;
      //1.1几号
    _day = [[UILabel alloc]initWithFrame:CGRectMake(MarginLeft, MarginTop, dayWidth, dayWidth)];
    _day.text = @"30";
    _day.textAlignment = NSTextAlignmentJustified;
    _day.textColor = [UIColor whiteColor];
    _day.font = [UIFont boldSystemFontOfSize:28];
    
    [_topBackImage addSubview:_day];
    
      //1.2星期几
    _week = [[UILabel alloc]initWithFrame:CGRectMake(_day.right, MarginTop, dayWidth*2, dayWidth*0.5)];
    _week.text = @"星期一";
    _week.textAlignment = NSTextAlignmentLeft;
    _week.textColor = [UIColor whiteColor];
    _week.font = [UIFont systemFontOfSize:10];
    
    [_topBackImage addSubview:_week];
    
      //1.3年月
    _year = [[UILabel alloc]initWithFrame:CGRectMake(_day.right, _week.bottom, dayWidth*2, dayWidth*0.5)];
    _year.text = @"2015年8月";
    _year.textAlignment = NSTextAlignmentLeft;
    _year.textColor = [UIColor whiteColor];
    _year.font = [UIFont systemFontOfSize:10];
    
    [_topBackImage addSubview:_year];
    
      //1.4心情图片
    CGFloat feelImageW = KScreenWidth - MarginLeft*4 - _day.width - _year.width;
    _feelImage = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - feelImageW*0.2 - MarginLeft, MarginTop, dayWidth, dayWidth)];
    _feelImage.image = [UIImage imageNamed:@"Boop_emotion_77"];
    
    [_topBackImage addSubview:_feelImage];
    
    //2.日志标题
    _logTitle = [[UILabel alloc]initWithFrame:CGRectMake(MarginLeft, _topBackImage.bottom + 16, KScreenWidth -MarginLeft*2, 20)];
    _logTitle.text = @"今天心情怎么样？";
    _logTitle.font = [UIFont systemFontOfSize:18];
    _logTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_logTitle];
    
    //3.日志内容
    _logContent = [[UILabel alloc]init];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:10]};
    
    _logContent.numberOfLines = 0;
    _logContent.text = @"是你始终甘心靠近 我方知拥有着缘份 重建我信心 曾被破碎过的心 让你今天轻轻贴近 多少安慰及疑问 偷偷的再生 情难自禁 我却其实属于 极度容易受伤的女人 不要　不要 不要骤来骤去 请珍惜我的心 如明白我 继续情愿热恋 这个容易受伤的女人 终此一生 也火般的热吻 是你始终甘心靠近 我方知拥有着缘份 重建我信心 曾被破碎过的心 让你今天轻轻贴近 多少安慰及疑问 偷偷的再生 情难自禁 我却其实属于 极度容易受伤的女人 不要　不要 不要骤来骤去 请珍惜我的心 如明白我 继续情愿热恋 这个容易受伤的女人 终此一生 也火般的热吻 是你始终甘心靠近 我方知拥有着缘份 重建我信心 曾被破碎过的心 让你今天轻轻贴近 多少安慰及疑问 偷偷的再生 情难自禁 我却其实属于 极度容易受伤的女人 不要　不要 不要骤来骤去 请珍惜我的心 如明白我 继续情愿热恋 这个容易受伤的女人 终此一生 也火般的热吻 是你始终甘心靠近 我方知拥有着缘份 重建我信心 曾被破碎过的心 让你今天轻轻贴近 多少安慰及疑问 偷偷的再生 情难自禁 我却其实属于 极度容易受伤的女人 不要　不要 不要骤来骤去 请珍惜我的心 如明白我 继续情愿热恋 这个容易受伤的女人 终此一生 也火般的热吻";
    CGSize size = [_logContent.text boundingRectWithSize:CGSizeMake(100, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [_logContent setFrame:CGRectMake(MarginLeft + 5, _logTitle.bottom + 3, KScreenWidth - MarginLeft*2, size.height)];
    [self addSubview:_logContent];
    
    //4.日志图片
    _logImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _logContent.bottom, KScreenWidth, 120)];
    _logImage.image = [UIImage imageNamed:@"topBackImage.png"];
    
    [self addSubview:_logImage];

    self.contentSize = CGSizeMake(KScreenWidth, _logImage.bottom + 20);
    
}

@end
