//
//  SeePublicAppreciate_ViewController.h
//  DaChuan
//
//  Created by dachuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public_View.h"
#import "Public_TableViewCell.h"
#import "Info.h"

@interface SeePublicAppreciate_ViewController : UIViewController<PublicDelegate>

@property (nonatomic, strong)UIButton *shareBtn;
@property (nonatomic, strong)Info *info;

@end
