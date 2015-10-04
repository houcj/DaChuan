//
//  Main_UITableViewCell.h
//  Demo
//
//  Created by dachuan on 15/9/22.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"
#import "common.h"

@interface Main_UITableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)UIButton *supportBtn;

@property (nonatomic, strong)UIImageView *privateImageView;

@property (nonatomic, strong)Info *info;

@property (nonatomic, assign)CGFloat hight;

@end
