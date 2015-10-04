//
//  EditLogViewController.m
//  DaChuan
//
//  Created by DaChuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "EditLogViewController.h"
#import "GYLAddImage.h"
#import "common.h"

// 重写base64Encoding方法
#pragma mrak - 重写base64Encoding方法
@interface NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64Encoding;

@end
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (MBBase64)

+ (id)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    
    if (decodingTable == NULL) {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (YES) {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++) {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX) {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1) {
            free(bytes);
            return nil;
        }
        
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

- (NSString *)base64Encoding {
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < [self length]) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES] ;
}

@end
#pragma mark - 重写base64Encoding结束


@interface EditLogViewController ()<UIScrollViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

//标题
@property (nonatomic ,strong) UILabel *currentTitle;
//内容文本
@property (nonatomic ,strong) UITextView *textView;
//标题数组
@property (nonatomic ,strong) NSArray *array;

@property (nonatomic ,assign) CGFloat textViewH;

@property (nonatomic ,strong) UIScrollView *scrollLog;

//@@@@@@@@@@
@property (nonatomic ,strong) GYLAddImage *addImageView;
@property (nonatomic ,strong) UIView *cover;
@end

@implementation EditLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控件
    [self addSubviews];
    
    //添加tabBar
    [self costomTabBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //监听键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self hidenkeyboard];
}

-(void)addSubviews
{
    CGFloat MarginLeft = 16;
    CGFloat MarginTop = 12;
    CGFloat currentTitleW = KScreenWidth - (MarginLeft - 5)*2;
    
    _scrollLog = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 49)];
    _scrollLog.pagingEnabled = YES;
    _scrollLog.showsHorizontalScrollIndicator = NO;
    _scrollLog.showsVerticalScrollIndicator = NO;
    _scrollLog.backgroundColor = [UIColor clearColor];
    _scrollLog.delegate = self;
    [self.view addSubview:_scrollLog];
    
    for (NSInteger i = 0; i < self.array.count - 1; i ++) {
        
        //1.日志标题
        _currentTitle = [[UILabel alloc]initWithFrame:CGRectMake(MarginLeft - 5 + (currentTitleW + (MarginLeft - 5)*2)*i, MarginTop, currentTitleW, MarginLeft)];
        _currentTitle.text = self.array[i];
        _currentTitle.backgroundColor = [UIColor whiteColor];
        _currentTitle.font = [UIFont systemFontOfSize:12];
        [_scrollLog addSubview:_currentTitle];
        
        //2.日志内容
        _textViewH = KScreenHeight - 49 - _currentTitle.height - 5;
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(MarginLeft- 5 +(currentTitleW+ (MarginLeft - 5)*2) *i, _currentTitle.bottom,  currentTitleW, _textViewH)];
        _textView.tag = i;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:12];
        _textView.text = [[NSUserDefaults standardUserDefaults] objectForKey:_currentTitle.text];
        _textView.textAlignment = NSTextAlignmentJustified;
        [_scrollLog addSubview:_textView];
        
    }
    
    _scrollLog.contentOffset = CGPointMake(KScreenWidth *self.index, _scrollLog.contentOffset.y);
    _scrollLog.contentSize = CGSizeMake(KScreenWidth *(self.array.count - 1), KScreenHeight - 49);

}

#pragma mothed - 自定义tabBar
-(void)costomTabBar
{
    _tabBar = [[UIView alloc]init];
    _tabBar.frame = CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49);
    _tabBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBar];
    
    CGFloat btnWH = 22;
    CGFloat marginH = (KScreenWidth - btnWH*4)/5;
    CGFloat marginV = (49 - btnWH)/2;
    
    for (NSInteger i=0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(marginH + (marginH + btnWH)*i, marginV, btnWH, btnWH)];
        btn.backgroundColor = [UIColor clearColor];
        switch (i) {
            case 0:
                btn.tag = 0;
                [btn setBackgroundImage:[UIImage imageNamed:@"editLog_back"] forState:UIControlStateNormal];
                break;
            case 1:
                btn.tag = 1;
                [btn setBackgroundImage:[UIImage imageNamed:@"editLog_arrow_left"] forState:UIControlStateNormal];
                break;
            case 2:
                btn.tag = 2;
                [btn setBackgroundImage:[UIImage imageNamed:@"editLog_arrow_right"] forState:UIControlStateNormal];
                break;
            case 3:
                btn.tag = 3;
                [btn setBackgroundImage:[UIImage imageNamed:@"editLog_image"] forState:UIControlStateNormal];
                break;
        }
        
        [btn addTarget:self action:@selector(clikBarBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:btn];
    }
    
    //退出键盘
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hidenkeyboard)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [_tabBar addGestureRecognizer:swipe];
    
}

-(void)hidenkeyboard
{
    [self.view endEditing:YES];
    
}

-(void)clikBarBtn:(UIButton *)button
{
    NSInteger index = button.tag;
    if (index == 0) {
        [_cover removeFromSuperview];
        _cover = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (index == 1 )
    {
        
        
        NSInteger indexT = _scrollLog.contentOffset.x / KScreenWidth;
        if (indexT > 0)
        {
            _scrollLog.contentOffset = CGPointMake(_scrollLog.contentOffset.x - KScreenWidth, _scrollLog.contentOffset.y);
            [self.view endEditing:YES];
        }
    }
    else if (index == 2 )
    {
        NSInteger indexT = _scrollLog.contentOffset.x / KScreenWidth;
        if (indexT < self.array.count - 2)
        {
            _scrollLog.contentOffset = CGPointMake(_scrollLog.contentOffset.x + KScreenWidth, _scrollLog.contentOffset.y);
            [self.view endEditing:YES];
         }
    }
    else if (index == 3)
    {
        
        //添加遮罩
//        _cover = [[UIView alloc]init];
//        _cover.frame = self.view.frame;
//        _cover.alpha = 0.7;
//        _cover.backgroundColor = [UIColor blackColor];
//        
//        
//        [self.view addSubview:_cover];
        
        [self hidenkeyboard];
        
        //选取图片
        _addImageView = [[GYLAddImage alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.5, self.view.frame.size.width, self.view.frame.size.height*0.5)];
        _addImageView.backgroundColor = [UIColor cyanColor];
        __weak typeof(self) weakSelf = self;
        _addImageView.block = ^(UIViewController *pickerVC){
            [weakSelf presentViewController:pickerVC animated:YES completion:nil];
        };
        
        [self.view bringSubviewToFront:_addImageView];
        [self.view addSubview:_addImageView];
    }
    
}

#pragma methed - 监听键盘响应事件
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    // 2.取得键盘参数
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // 3.动画
    [UIView animateWithDuration:duration animations:^{
        
        CGFloat ty = keyboardY - self.view.frame.size.height;
        
        if (_textView.height == _textViewH)
        {
            CGRect frameTV = CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textViewH - keyboardY);
            _textView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
            _textView.frame = frameTV;
            
           
            CGRect frame = CGRectMake(_tabBar.frame.origin.x, KScreenHeight + ty + 20, _tabBar.frame.size.width, _tabBar.frame.size.height);
            _tabBar.frame = frame;
        }
        else
        {
            CGRect frameTV =CGRectMake(_textView.frame.origin.x, _textView.frame.origin.y, _textView.frame.size.width, _textViewH);
            _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _textView.frame = frameTV;
            
            CGRect frame = CGRectMake(_tabBar.frame.origin.x, KScreenHeight - 49, _tabBar.frame.size.width, _tabBar.frame.size.height);
            _tabBar.frame = frame;
        }
        
    }];
    
    
}

#pragma methed - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    //保存文本到本地
    NSString *key = self.array[textView.tag];
    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:key];
}

#pragma methed - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self hidenkeyboard];
}

#pragma methed - setter、getter
-(void)setIndex:(NSInteger)index
{
    _index = index;
}

//取标题数据
-(NSArray *)array
{
    if (_array == nil) {
        
        _array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TitleList.plist" ofType:nil]];
    }
    
    return _array;

}
@end
