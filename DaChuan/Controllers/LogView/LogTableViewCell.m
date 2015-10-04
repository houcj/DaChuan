//
//  LogTableViewCell.m
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "LogTableViewCell.h"
#import "UIViewExt.h"

@implementation LogTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initSubViews];
        self.selectionStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}

-(void)initSubViews
{
    CGFloat LabelDayW = 28;
    CGFloat Marign = 12;
    
    //几号
    UILabel *labelDay = [[UILabel alloc]initWithFrame:CGRectMake(Marign, Marign, LabelDayW, LabelDayW)];
    labelDay.text = @"29";
    labelDay.font = [UIFont systemFontOfSize:24];
    labelDay.textColor = [UIColor blackColor];
    [self.contentView addSubview:labelDay];
    
    //周几
    UILabel *labelWeek = [[UILabel alloc] initWithFrame:CGRectMake(labelDay.width + Marign + 1, labelDay.frame.origin.y + 3, LabelDayW, LabelDayW*0.5)];
    labelWeek.text = @"周八";
    labelWeek.font = [UIFont systemFontOfSize:8];
    labelWeek.textColor = [UIColor grayColor];
    [self.contentView addSubview:labelWeek];
    
    //心情
    UIImageView *fineImage = [[UIImageView alloc] initWithFrame:CGRectMake(labelDay.bottomRight.x - 3, labelDay.bottom, LabelDayW * 0.8, LabelDayW * 0.8)];
    fineImage.image = [UIImage imageNamed:@"530.png"];
    [self.contentView addSubview:fineImage];
    
    //文本
    UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(labelWeek.right+4, 2, self.contentView.frame.size.width - labelWeek.right - 4, fineImage.bottom + 2)];
    labelText.text = @"亲爱的 我永远祝福你 好人就有好梦 有缘分不用说长相守 好人就有好梦 好人就有好梦 当你老了 头发白了 睡意昏沉 爱慕你的美丽 假意或真心";
    labelText.font = [UIFont systemFontOfSize:11];
    labelText.numberOfLines = 0;
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//    CGSize size = [text boundingRectWithSize:CGSizeMake(100, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    [labelText setFrame:CGRectMake(labelWeek.right+4, 2, self.contentView.frame.size.width - labelWeek.right - 4, size.height)];
    
    [self.contentView addSubview:labelText];
    
    _cellHeight = labelText.bottom + 6;
}

@end
