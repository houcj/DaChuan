//
//  Main_UITableViewCell.m
//  Demo
//
//  Created by dachuan on 15/9/22.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "Main_UITableViewCell.h"

@implementation Main_UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    _titleLabel = [[UILabel alloc] init];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.backgroundColor = [UIColor brownColor];
    
    _commentBtn = [[UIButton alloc] init];
    [_commentBtn setTitleColor:[UIColor colorWithRed:212/255.0 green:213/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
    
    _supportBtn = [[UIButton alloc] init];
    [_supportBtn setTitleColor:[UIColor colorWithRed:212/255.0 green:213/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
    
    _privateImageView = [[UIImageView alloc] init];
    //    _privateImageView.backgroundColor = [UIColor brownColor];
    
    [self addSubview:_titleLabel];
    [self addSubview:_timeLabel];
    [self addSubview:_contentLabel];
    
    [self addSubview:_commentBtn];
    [self addSubview:_supportBtn];
    
    [self addSubview:_privateImageView];
    
    
}

- (void)setInfo:(Info *)info{
        
    _titleLabel.frame = CGRectMake(KScreenWidth * 0.02, KScreenHeight * 0, KScreenWidth * 0.5, KScreenHeight * 0.05);
    _titleLabel.text = info.title;
    
    _timeLabel.frame = CGRectMake(_titleLabel.origin.x+_titleLabel.size.width+KScreenWidth * 0.05, KScreenHeight * 0, KScreenWidth * 0.4, KScreenHeight * 0.05);
    _timeLabel.text = info.time;
    
    
    _contentLabel.text = info.content;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width*0.98f;
    CGSize contentSize = [info.content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    _contentLabel.frame = CGRectMake(KScreenWidth*0.02, _timeLabel.origin.y+_timeLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.96, contentSize.height);
    [_contentLabel sizeToFit];
    
    _commentBtn.frame = CGRectMake(KScreenWidth * 0.3, _contentLabel.origin.y+_contentLabel.size.height+KScreenHeight * 0.01, KScreenWidth * 0.2, KScreenHeight * 0.02);
    
    _supportBtn.frame = CGRectMake(_commentBtn.origin.x+_commentBtn.size.width+KScreenWidth * 0.1, _contentLabel.origin.y+_contentLabel.size.height+KScreenHeight * 0.01, KScreenWidth * 0.2, KScreenHeight * 0.02);
    
    _privateImageView.frame = CGRectMake(KScreenWidth * 0.45, _contentLabel.origin.y+_contentLabel.size.height+KScreenHeight * 0.01, KScreenWidth * 0.03, KScreenHeight * 0.02);

    if ([_info.isPublic isEqualToString:@"0"]) {
        _hight = CGRectGetMaxY(_privateImageView.frame)+KScreenHeight*0.01;
    }else{
        _hight = CGRectGetMaxY(_commentBtn.frame)+KScreenHeight*0.01;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
