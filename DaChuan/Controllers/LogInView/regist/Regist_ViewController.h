//
//  Regist_ViewController.h
//  Demo
//
//  Created by dachuan on 15/9/21.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Regist_View.h"

@interface Regist_ViewController : UIViewController<registProtocol>

@property (nonatomic, strong)UITableView *registTableView;
@property (nonatomic, strong)NSMutableArray *labelArr;
@property (nonatomic, strong)UIButton *registBtn;
@property (nonatomic, assign)int flag;

@end
