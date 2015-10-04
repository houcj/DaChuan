//
//  EditCollectionViewCell.h
//  DaChuan
//
//  Created by DaChuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *titleLabel;//格子标题标签

@property (nonatomic ,strong) UIButton *dele;//格子上的删除按钮

@property (nonatomic ,copy) NSString *title;//格子标题

@property (nonatomic ,assign) NSInteger cellIndex;//格子位置

@end
