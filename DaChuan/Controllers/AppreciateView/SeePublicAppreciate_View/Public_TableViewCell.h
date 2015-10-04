//
//  Public_TableViewCell.h
//  DaChuan
//
//  Created by dachuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "Info.h"

@interface Public_TableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *dateLabel;

@property (nonatomic, strong)UILabel *supportLabelImage;
@property (nonatomic, strong)UILabel *commentLabelImage;
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *commentLabel;

@property (nonatomic, strong)UITableView *commentTableView;

@property (nonatomic, strong)UIButton *editBtn;
@property (nonatomic, strong)UIButton *deleteBtn;
@property (nonatomic, strong)UIButton *supportBtn;

@property (nonatomic, strong)Info *info;

@property (nonatomic, assign)CGFloat height;

@end
