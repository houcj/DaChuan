//
//  NewAppreciate_View.h
//  DaChuan
//
//  Created by dachuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Info.h"

@protocol newAppreciateDelegate <NSObject>

- (void)tagViewReserve:(Info *)info;
- (void)pushSeePublicAppreciate_View:(Info *)info;

@end

@interface NewAppreciate_View : UIView
//照片的还未设计

@property (nonatomic, strong)NSMutableArray *picsMuArr;

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *tagLabel;
@property (nonatomic, strong)UILabel *publicLabel;
@property (nonatomic, strong)UILabel *privateLabel;
@property (nonatomic, strong)UILabel *firstTagLabel;
@property (nonatomic, strong)UILabel *secondTagLabel;
@property (nonatomic, strong)UILabel *thirdTagLabel;

@property (nonatomic, strong)UIButton *tagBtn;

@property (nonatomic, strong)NSString *url;

@property (nonatomic, strong)UITextView *contentTextView;

@property (nonatomic, strong)UITextField *tagTextField;
@property (nonatomic, strong)UITextField *titleTextField;

@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIView *tagView;
@property (nonatomic, strong)UIView *tagBackgroundView;
@property (nonatomic, strong)UIView *tmptView;

@property (nonatomic, strong)UIButton *preserveBtn;
@property (nonatomic, strong)UIButton *photoBtn;
@property (nonatomic, strong)UIButton *publicBtn;
@property (nonatomic, strong)UIButton *privateBtn;

@property (nonatomic, strong)UIButton *psychologyBtn;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *preserveBtnTag;
@property (nonatomic, strong)UIButton *firstBtn;
@property (nonatomic, strong)UIButton *secondBtn;
@property (nonatomic, strong)UIButton *thirdBtn;

@property (nonatomic, assign)int flag;

@property (nonatomic, strong)UIAlertView *alert;

@property (nonatomic, strong)NSMutableArray *tagMuArr;
@property (nonatomic, strong)NSMutableArray *tmptMuArr;

@property (nonatomic, strong)NSUserDefaults *tagUserDefaults;

@property (nonatomic, strong)Info *info;

@property (nonatomic, strong)id<newAppreciateDelegate> delegate;

@end
