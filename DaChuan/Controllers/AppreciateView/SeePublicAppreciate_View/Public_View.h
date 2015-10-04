//
//  Public_View.h
//  DaChuan
//
//  Created by dachuan on 15/10/1.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public_TableViewCell.h"
#import "Info.h"
#import "AFNetworking.h"

@class Public_View;

@protocol PublicDelegate <NSObject>

- (void)public_ViewProtocol:(Info *)info;
- (void)public_ViewToLogInViewController:(Public_View *)Public_View;

@end

@interface Public_View : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSUserDefaults *tokenUserDefaults;

@property (nonatomic, strong)UITableView *mainTableView;

@property (nonatomic, strong)NSMutableArray *infoMuArr;
@property (nonatomic, strong)NSMutableArray *cellMuArr;

@property (nonatomic, strong)NSDictionary *responseDic;

@property (nonatomic, strong)UILabel *supportLabelImage;
@property (nonatomic, strong)UILabel *commentLabelImage;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UILabel *contentLabel;

@property (nonatomic, assign)CGFloat heightHead;

@property (nonatomic, strong)UIView *headerView;

@property (nonatomic, strong)Info *info;

@property (nonatomic, strong)Public_TableViewCell *publicCell;

@property (nonatomic, strong)id<PublicDelegate> delegate;

@end
