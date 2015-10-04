//
//  GYLAddImage.h
//  DZPublicGood
//
//  Created by dezhao on 15/7/4.
//  Copyright (c) 2015年 GYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePhotoPickerVCManager.h"

@interface GYLAddImage : UIView
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *imageDataArr;
@property (nonatomic, strong) void(^block)(UIViewController *pickerVC);
@end
