//
//  GYLAddImage.m
//  DZPublicGood
//
//  Created by dezhao on 15/7/4.
//  Copyright (c) 2015年 GYL. All rights reserved.
//

#define imageH (([UIScreen mainScreen].bounds.size.width)-20)/4
#define imageW (([UIScreen mainScreen].bounds.size.width)-20)/4
#define kMaxColumn 3
#define MaxImageCount 9
#define deleImageWH 25
#define kAdeleImage @"Bigright"
#define kAddImage @"addpicture"

#import "GYLAddImage.h"

@interface GYLAddImage()<UINavigationControllerDelegate, UIActionSheetDelegate>
{
    NSInteger editTag;
}
@property(nonatomic,assign)int num;
@property(nonatomic,assign)int number;
@end
@implementation GYLAddImage
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [self createButtonWithImage:kAddImage andSeletor:@selector(addNew:)];
        [self addSubview:btn];
        }
    return self;
}
-(void)dealloc
{
    self.num=0;
}
-(NSMutableArray *)imageDataArr
{
    if (_imageDataArr==nil) {
        _imageDataArr=[NSMutableArray array];
    }
    return _imageDataArr;
}
-(NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
        }
    return _images;
}

- (void)addNew:(UIButton *)btn
{
    if (![self deleClose:btn]) {
        editTag = -1;
        [self callImagePicker];
        }
}

- (void)changeOld:(UIButton *)btn
{
    if (![self deleClose:btn]) {
        editTag = btn.tag;
        [self callImagePicker];
    }
}

- (BOOL)deleClose:(UIButton *)btn
{
    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
     return NO;
}

- (void)callImagePicker
{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"本地相册",@"系统拍照", nil];
    [sheet showInView:self];
}
- (UIButton *)createButtonWithImage:(id)imageNameOrImage andSeletor : (SEL)selector
{
    UIImage *addImage = nil;
    if ([imageNameOrImage isKindOfClass:[NSString class]]) {
        addImage = [UIImage imageNamed:imageNameOrImage];
    }else if([imageNameOrImage isKindOfClass:[UIImage class]]){
            addImage = imageNameOrImage;
    }
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:addImage forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    if(addBtn.tag != 0){
        UILongPressGestureRecognizer *gester = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [addBtn addGestureRecognizer:gester];
    }
    return addBtn;
}
- (void)longPress : (UIGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan){
            UIButton *btn = (UIButton *)gester.view;
            UIButton *dele = [UIButton buttonWithType:UIButtonTypeCustom];
            dele.bounds = CGRectMake(0, 0, deleImageWH, deleImageWH);
            [dele setImage:[UIImage imageNamed:kAdeleImage] forState:UIControlStateNormal];
             dele.tag=(int)[self.images indexOfObject:[btn imageForState:UIControlStateNormal]]+10;
            [dele addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
            //dele.frame = CGRectMake(btn.frame.size.width - dele.frame.size.width, 0, dele.frame.size.width, dele.frame.size.height);
            dele.frame = CGRectMake(0, 0, 10, 10);
         dele.backgroundColor = [UIColor greenColor];
        [self bringSubviewToFront:dele];
            [btn addSubview:dele];
            [self start : btn];
        }
}
- (void)start : (UIButton *)btn {
    double angle1 = -5.0 / 180.0 * M_PI;
    double angle2 = 5.0 / 180.0 * M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle1),  @(angle2), @(angle1)];
    anim.duration = 0.25;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [btn.layer addAnimation:anim forKey:@"shake"];
}
- (void)stop : (UIButton *)btn{
    [btn.layer removeAnimationForKey:@"shake"];
}
- (void)deletePic : (UIButton *)btn
{
    self.num-=1;
    int index = (int)btn.tag-10;
    [self.imageDataArr removeObjectAtIndex:index];
    [self.images removeObject:[(UIButton *)btn.superview imageForState:UIControlStateNormal]];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
       }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = (int)self.subviews.count;
    for (int i=0; i<count; i++) {
         UIButton *btn = self.subviews[i];
        CGFloat btnW = imageW;
        btn.frame=CGRectMake(10+btnW*(i%4), 5+btnW*(i/4), btnW-5, btnW-5);
    }
}
#pragma maek - 多选图片
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    CorePhotoPickerVCMangerType type;
    if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeCamera;
    if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeMultiPhoto;
    if(buttonIndex==2) return;
    CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
    manager.pickerVCManagerType=type;
    manager.maxSelectedPhotoNumber=9;

    if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
        
        return;
    }
    UIViewController *pickerVC=manager.imagePickerController;
    manager.finishPickingMedia=^(NSArray *medias)
    {
        NSLog(@"medias %@",medias);
        self.num+=(int)medias.count;
        if (self.num<=9) {
            [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
                if (editTag == -1) {
                    UIImage *image=photo.editedImage;
                    NSData*imageData=UIImageJPEGRepresentation(image, 0.01);
                    [self.imageDataArr addObject:imageData];
                    UIButton *btn = [self createButtonWithImage:image andSeletor:@selector(changeOld:)];
                    [self insertSubview:btn atIndex:self.subviews.count - 1];
                    [self.images addObject:image];
                   
                    if (self.subviews.count - 1 == MaxImageCount) {
                        [[self.subviews lastObject] setHidden:YES];
                    }
                }else{
                    UIImage *image=photo.editedImage;
                    NSData*imageData=UIImageJPEGRepresentation(image, 0.4);
                    UIButton *btn = (UIButton *)[self viewWithTag:editTag];
                    int index = (int)[self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
                    [self.images removeObjectAtIndex:index];
                    [self.imageDataArr removeObjectAtIndex:index];
                    [self.imageDataArr insertObject:imageData atIndex:index];
                    [btn setImage:image forState:UIControlStateNormal];
                    [self.images insertObject:image atIndex:index];
                }

            }];

        }else{
            self.num-=(int)medias.count;
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:Nil message:@"最多能添加9张图片" delegate:self cancelButtonTitle:@"重新添加" otherButtonTitles:nil];
            [alertView show];
            
        }
         NSLog(@"GYLAddImage %@",self.images);
    };
    _block(pickerVC);
    /**
     * 回调中加入该方法    [self presentViewController:pickerVC animated:YES completion:nil];
     */

}

@end
