//
//  NewAppreciate_View.m
//  DaChuan
//
//  Created by dachuan on 15/9/24.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "NewAppreciate_View.h"
#import "common.h"
#import "AFNetworking.h"

@implementation NewAppreciate_View

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    
    _flag = 0;
    _tagMuArr = [NSMutableArray array];
    _tmptMuArr = [NSMutableArray array];
    _picsMuArr = [NSMutableArray array];
    _tagUserDefaults = [NSUserDefaults standardUserDefaults];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth*0.05, KScreenHeight*0.045, KScreenWidth*0.15, KScreenHeight*0.03)];
    _titleLabel.text = @"标题：";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(_titleLabel.origin.x+_titleLabel.size.width+KScreenWidth*0.01, KScreenHeight*0.045, KScreenWidth*0.65, KScreenHeight*0.03)];
    _titleTextField.borderStyle = UITextBorderStyleNone;
    _titleTextField.placeholder = @"请输入标题";
    _titleTextField.font = [UIFont systemFontOfSize:14];
    
    _tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth*0.05, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.015, KScreenWidth*0.31, KScreenHeight*0.02)];
    _tagLabel.text = @"标签（可选）:";
    _tagLabel.font = [UIFont systemFontOfSize:14];
    
    _tagBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.85, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.015, KScreenWidth*0.1, KScreenHeight*0.02)];
    [_tagBtn setTitle:@"➕" forState:UIControlStateNormal];
    [_tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_tagBtn addTarget:self action:@selector(tagBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(KScreenWidth*0.05, _tagLabel.origin.y+_tagLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.9, KScreenHeight*0.92-(_tagLabel.origin.y+_tagLabel.size.height+KScreenHeight*0.01))];
    _contentTextView.backgroundColor = [UIColor grayColor];
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth*0.05, KScreenHeight*0.93, KScreenWidth*0.9, KScreenHeight*0.06)];
    _bottomView.backgroundColor = [UIColor redColor];
    
    _preserveBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.01, 0, KScreenWidth*0.2, KScreenHeight*0.06)];
    _preserveBtn.backgroundColor = [UIColor yellowColor];
    [_preserveBtn addTarget:self action:@selector(preserveBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [_preserveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_preserveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(_preserveBtn.origin.x+_preserveBtn.size.width+KScreenWidth*0.02, 0, KScreenWidth*0.2, KScreenHeight*0.06)];
    _photoBtn.backgroundColor = [UIColor yellowColor];
    [_photoBtn addTarget:self action:@selector(photoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [_photoBtn setTitle:@"相册" forState:UIControlStateNormal];
    [_photoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _publicBtn = [[UIButton alloc] initWithFrame:CGRectMake(_photoBtn.origin.x+_photoBtn.size.width+KScreenWidth*0.02, 0, KScreenWidth*0.1, KScreenHeight*0.06)];
    [_publicBtn setImage:[UIImage imageNamed:@"noSelect.png"] forState:UIControlStateNormal];
    [_publicBtn setImage:[UIImage imageNamed:@"preserve.png"] forState:UIControlStateSelected];
    [_publicBtn addTarget:self action:@selector(publicBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    _publicBtn.selected = YES;
    
    _publicLabel = [[UILabel alloc] initWithFrame:CGRectMake(_publicBtn.origin.x+_publicBtn.size.width+KScreenWidth*0.01, 0, KScreenWidth*0.1, KScreenHeight*0.06)];
    _publicLabel.text = @"公开";
    _publicLabel.font = [UIFont systemFontOfSize:12];
    
    _privateBtn = [[UIButton alloc] initWithFrame:CGRectMake(_publicLabel.origin.x+_publicLabel.size.width+KScreenWidth*0.01, 0, KScreenWidth*0.1, KScreenHeight*0.06)];
    [_privateBtn setImage:[UIImage imageNamed:@"noSelect.png"] forState:UIControlStateNormal];
    [_privateBtn setImage:[UIImage imageNamed:@"preserve.png"] forState:UIControlStateSelected];
    _privateBtn.selected = NO;
    [_privateBtn addTarget:self action:@selector(privateBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _privateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_privateBtn.size.width+_privateBtn.origin.x+KScreenWidth*0.01, 0, KScreenWidth*0.1, KScreenHeight*0.06)];
    _privateLabel.text = @"私密";
    _privateLabel.font = [UIFont systemFontOfSize:12];
    
    _firstBtn = [[UIButton alloc] initWithFrame:CGRectMake(_tagLabel.origin.x+_tagLabel.size.width, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.16, KScreenHeight*0.02)];
    _secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(_firstBtn.origin.x+_firstBtn.size.width+KScreenWidth*0.015, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.16, KScreenHeight*0.02)];
    _thirdBtn = [[UIButton alloc] initWithFrame:CGRectMake(_secondBtn.origin.x+_secondBtn.size.width+KScreenWidth*0.015, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.16, KScreenHeight*0.02)];
    
    _firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _thirdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    [_bottomView addSubview:_preserveBtn];
    [_bottomView addSubview:_photoBtn];
    [_bottomView addSubview:_publicBtn];
    [_bottomView addSubview:_publicLabel];
    [_bottomView addSubview:_privateBtn];
    [_bottomView addSubview:_privateLabel];
    
    [self addSubview:_titleLabel];
    [self addSubview:_titleTextField];
    [self addSubview:_tagLabel];
    [self addSubview:_tagBtn];
    [self addSubview:_contentTextView];
    [self addSubview:_bottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test1:) name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test2:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

- (void)publicBtnMethod{
    _publicBtn.selected = YES;
    _privateBtn.selected = NO;
//    NSLog(@"===================%hhd",_publicBtn.selected);
}

- (void)privateBtnMethod{
    _privateBtn.selected = YES;
    _publicBtn.selected = NO;
//    NSLog(@"===================%hhd",_publicBtn.selected);
}

#pragma mark 添加标签的界面
- (void)tagBtnMethod{
    
    NSArray *tagArr = [NSArray arrayWithObjects:@"心理",@"能量",@"治愈",@"修行",@"佛学",@"健康",@"占卜",@"目标", nil];
    
    _tagBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _tagBackgroundView.backgroundColor = [UIColor blackColor];
    _tagBackgroundView.alpha = 0.4;
    
    _tagView = [[UIView alloc] initWithFrame:CGRectMake(KScreenWidth*0.06, KScreenHeight*0.2, KScreenWidth*0.88, KScreenHeight*0.3)];
    _tagView.backgroundColor = [UIColor whiteColor];
    
    _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.76, KScreenHeight*0.01, KScreenWidth*0.1, KScreenHeight*0.05)];
    [_cancelBtn setImage:[UIImage imageNamed:@"noSelect.png"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < tagArr.count; i ++) {
        if (i < 4) {
            _psychologyBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.05+KScreenWidth*0.14*i, _cancelBtn.origin.y+_cancelBtn.size.height+KScreenHeight*0.01, KScreenWidth*0.12, KScreenHeight*0.05)];
            
        }else{
            _psychologyBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.05+KScreenWidth*0.14*(i-4), _cancelBtn.origin.y+_cancelBtn.size.height+KScreenHeight*0.07, KScreenWidth*0.12, KScreenHeight*0.05)];
        }
        _psychologyBtn.tag = i;
        [_psychologyBtn setTitle:[tagArr objectAtIndex:i] forState:UIControlStateNormal];
        [_psychologyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_psychologyBtn addTarget:self action:@selector(allTagBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        _psychologyBtn.backgroundColor = [UIColor grayColor];
        [_tagView addSubview:_psychologyBtn];
    }
    
    _tagTextField = [[UITextField alloc] initWithFrame:CGRectMake(KScreenWidth*0.05, _psychologyBtn.size.height+_psychologyBtn.origin.y+KScreenHeight*0.02, KScreenWidth*0.6, KScreenHeight*0.05)];
    _tagTextField.borderStyle = UITextBorderStyleBezel;
    _tagTextField.placeholder = @"只能输入一个标签";
    
    _preserveBtnTag = [[UIButton alloc] initWithFrame:CGRectMake(_tagTextField.origin.x+_tagTextField.size.width+KScreenWidth*0.02, _psychologyBtn.size.height+_psychologyBtn.origin.y+KScreenHeight*0.02,KScreenWidth*0.1, KScreenHeight*0.05)];
    [_preserveBtnTag setImage:[UIImage imageNamed:@"preserve.png"] forState:UIControlStateNormal];
    [_preserveBtnTag addTarget:self action:@selector(preserveBtnTagMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [_tagView addSubview:_cancelBtn];
    
    [_tagView addSubview:_tagTextField];
    
    [_tagView addSubview:_preserveBtnTag];
    
    [self addSubview:_tagBackgroundView];
    [self addSubview:_tagView];
}

- (void)preserveBtnTagMethod{
    NSLog(@"保存标签");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    NSString *str = _tagTextField.text;
    if ([_tagTextField.text isEqualToString:@""]) {
        alert.title = @"提示";
        alert.message = @"内容不能为空";
        [alert show];
    }else if ([_tagTextField.text containsString:@""]||[_tagTextField.text containsString:@"，"]||[_tagTextField.text containsString:@"；"]||_tagTextField.text.length > 6){
        alert.title = @"标签格式有错误";
        alert.message = @"标签不能含有空格和标点符号，一次只能输入一个标签且少于六个字";
        [alert show];
    }else{
        if (_tagMuArr.count == 0) {
            _flag++;
            [_tagMuArr addObject:_tagTextField.text];
            [_tagView removeFromSuperview];
            [_tagBackgroundView removeFromSuperview];
            
             _firstBtn.backgroundColor = [UIColor yellowColor];
            [_firstBtn setTitle:[NSString stringWithFormat:@"%@-",_tagTextField.text] forState:UIControlStateNormal];
            [_firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_firstBtn addTarget:self action:@selector(firstBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self addSubview:_firstBtn];
            
        }else if (_tagMuArr.count == 3){
            _flag++;
            alert.title = @"提示";
            alert.message = @"最多只能添加三个标签";
            [alert show];

        }else if(_tagMuArr.count == 1&&![str isEqualToString:[_tagMuArr objectAtIndex:0]]){
            
//        NSLog(@"========================%d",_tagMuArr.count);
            _flag++;
            [_tagMuArr addObject:_tagTextField.text];
            [_tagView removeFromSuperview];
            [_tagBackgroundView removeFromSuperview];
        }else if (_tagMuArr.count == 2 && !([str isEqualToString:[_tagMuArr objectAtIndex:0]]||[str isEqualToString:[_tagMuArr objectAtIndex:1]])){
//            NSLog(@"---------------%d",_tagMuArr.count);
            _flag++;
            [_tagMuArr addObject:_tagTextField.text];
            [_tagView removeFromSuperview];
            [_tagBackgroundView removeFromSuperview];
        }else{
            alert.title = @"提示";
            alert.message = @"选择标签重复";
            [alert show];
        }
        
        if (_flag == 2){
            _secondBtn.backgroundColor = [UIColor yellowColor];
            [_secondBtn setTitle:[NSString stringWithFormat:@"%@-",_tagTextField.text] forState:UIControlStateNormal];
            [_secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_secondBtn addTarget:self action:@selector(secondBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_secondBtn];
        }else if (_flag == 3){
            
            [_thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_thirdBtn setTitle:[NSString stringWithFormat:@"%@-",_tagTextField.text] forState:UIControlStateNormal];
            _thirdBtn.backgroundColor = [UIColor yellowColor];
            [_thirdBtn addTarget:self action:@selector(thirdBtnMethod) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_thirdBtn];
        }
    }
}

#pragma mark 删除标签
- (void)firstBtnMethod{
//    NSLog(@"----------------------%d",_tagMuArr.count);
    
    if (_tagMuArr.count == 3) {
        [_tagMuArr removeObjectAtIndex:0];
        [_firstBtn setTitle:[_tagMuArr objectAtIndex:0] forState:UIControlStateNormal];
        [_secondBtn setTitle:[_tagMuArr objectAtIndex:1] forState:UIControlStateNormal];
        [_thirdBtn removeFromSuperview];
        _flag--;
    }else if (_tagMuArr.count == 2){
        [_tagMuArr removeObjectAtIndex:0];
        [_secondBtn removeFromSuperview];
        [_firstBtn setTitle:[_tagMuArr objectAtIndex:0] forState:UIControlStateNormal];
        _flag--;
    }else if (_tagMuArr.count == 1){
        [_tagMuArr removeObjectAtIndex:0];
        [_firstBtn removeFromSuperview];
        _flag--;
    }
}

- (void)secondBtnMethod{
    NSLog(@"第二个btn被点击");
    if (_tagMuArr.count == 3) {
        [_tagMuArr removeObjectAtIndex:1];
        [_thirdBtn removeFromSuperview];
        [_secondBtn setTitle:[_tagMuArr objectAtIndex:1] forState:UIControlStateNormal];
        _flag--;
    }else if (_tagMuArr.count == 2){
        [_tagMuArr removeObjectAtIndex:1];
        [_secondBtn removeFromSuperview];
        _flag--;
    }
}

- (void)thirdBtnMethod{
    NSLog(@"第3个btn被点击");
    if (_tagMuArr.count == 3) {
        [_tagMuArr removeObjectAtIndex:2];
        [_thirdBtn removeFromSuperview];
        _flag--;
    }
}

- (void)allTagBtnMethod:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
            _tagTextField.text = @"心理";
            
            break;
        case 1:
            _tagTextField.text = @"能量";
            
            break;
        case 2:
            _tagTextField.text = @"治愈";

            break;
        case 3:
            _tagTextField.text = @"修行";

            break;
        case 4:
            _tagTextField.text = @"佛学";

            break;
        case 5:
            _tagTextField.text = @"佛学";

            break;
        case 6:
            _tagTextField.text = @"占卜";

            break;
        case 7:
            _tagTextField.text = @"目标";

            break;
            
        default:
            break;
    }
}

- (void)cancelBtnMethod{
    //标签的取消
    [_tagView removeFromSuperview];
    [_tagBackgroundView removeFromSuperview];
}

- (void)preserveBtnMethod{
    //保存按钮
//    NSLog(@"%hhd",_publicBtn.selected);
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    if (!_titleTextField.text) {
        _alert.message = @"请输入标题";
        [_alert show];
    }else{
        _info = [[Info alloc] init];
        _info.title = _titleTextField.text;
        _info.labels = _tagMuArr;
        _info.pics = _picsMuArr;
        _info.title = _titleTextField.text;
        _info.content = _contentTextView.text;
        if (_publicBtn.selected == YES) {
            _info.isPublic = @"1";
            
        }else{
            _info.isPublic = @"0";
            //push到私密感悟界面
        }
        //上传图片
//        [self uploadImg];
        
        [self getMethod];
    }
}
//
//-(void)uploadImg{
//    NSString *url = @"http://101.200.91.181:81/upload/upFile.htm";
//    //    NSDictionary *dic = @{
//    //                          @"key" : @"1dcab822fee5602f694c85def3fd2ebb",
//    //                          @"uername" : @1,
//    //
//    //                          };//封装上传者信息
//        UIImage *image = [UIImage imageNamed:@"preserve.png"];
//    NSDictionary *dic = @{
//                          @"imgFile":@"1.png"
//                          };
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    
//    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        UIImage *image = [UIImage imageNamed:@"preserve.png"];
//        NSData *data = UIImageJPEGRepresentation(image, 0.9);
//        
//        [formData appendPartWithFileData:data name:@"1" fileName:@"image" mimeType:@"image/png"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        [_picsMuArr addObject:responseObject];
//        NSLog(@"-------------response------%@",responseObject);
//        
//        //一般在这里返回图片的url
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"---------上传图片error－－－－－－－－－%@",error);
//    }];
//    
//}

-(void)getMethod{
    
    NSLog(@"--------------------%@----------------------%@",[_tagUserDefaults objectForKey:@"token"],[_info.labels objectAtIndex:0]);
    
    switch (_info.labels.count) {
        case 0:
            switch (_info.pics.count) {
                case 0:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic];
                    break;
                case 1:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0]];
                    break;
                case 2:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1]];
                    break;
                case 3:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2]];
                    break;
                case 4:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3]];
                    break;
                case 5:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&pics=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.pics objectAtIndex:4]];
                    break;
                    
                default:
                    break;
            }
            
            break;
        case 1:
            switch (_info.pics.count) {
                case 0:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.labels objectAtIndex:0]];
                    break;
                case 1:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.labels objectAtIndex:0]];
                    break;
                case 2:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.labels objectAtIndex:0]];
                    break;
                case 3:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.labels objectAtIndex:0]];
                    break;
                case 4:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.labels objectAtIndex:0]];
                    break;
                case 5:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.pics objectAtIndex:4],[_info.labels objectAtIndex:0]];
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (_info.pics.count) {
                case 0:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                case 1:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                case 2:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                case 3:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                case 4:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                case 5:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.pics objectAtIndex:4],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1]];
                    break;
                    
                default:
                    break;
            }

            break;
        case 3:
            switch (_info.pics.count) {
                case 0:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                case 1:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                case 2:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                case 3:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                case 4:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                case 5:
                    _url = [NSString stringWithFormat:@"http://101.200.91.181:81/api_article/saveNewArticle.htm?token=%@&title=%@&content=%@&isPublic=%@&pics=%@&pics=%@&pics=%@&pics=%@&pics=%@&labels=%@&labels=%@&labels=%@",[_tagUserDefaults objectForKey:@"token"],_titleTextField.text,_contentTextView.text,_info.isPublic,[_info.pics objectAtIndex:0],[_info.pics objectAtIndex:1],[_info.pics objectAtIndex:2],[_info.pics objectAtIndex:3],[_info.pics objectAtIndex:4],[_info.labels objectAtIndex:0],[_info.labels objectAtIndex:1],[_info.labels objectAtIndex:2]];
                    break;
                    
                default:
                    break;
            }


            break;
            
        default:
            break;
    }
    
//    NSDictionary *dic = @{
//                          :[_tagUserDefaults objectForKey:@"token"],
//                          @"title" : _titleTextField.text,
//                          @"" : _contentTextView.text,
//                          @"isPublic" : _info.isPublic,
//                          @"labels" : [_info.labels objectAtIndex:0],
//                          @"pics":_info.pics
//                          };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"_url----------------%@",_url);
    [manager GET:_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //请求成功，直接对responseObject进行解析即可
        NSLog(@"---->%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"===>%@",error);
    }];
    
    
}

- (void)photoBtnMethod{
    //相册按钮
    
    NSLog(@"－－－－－－－－－－－相册－－－－－－－－－－－－－－－－－－－－－－－－－－－－－");
}

-(void)test:(NSNotification *)note{
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    _bottomView.frame = CGRectMake(KScreenWidth*0.05, KScreenHeight*0.94-kbSize.height, KScreenWidth*0.9, KScreenHeight*0.06);
    
    _contentTextView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    _contentTextView.layoutManager.allowsNonContiguousLayout=NO;
}
- (void)test1:(NSNotification *)note{
    
    _bottomView.frame = CGRectMake(KScreenWidth*0.05, KScreenHeight*0.93, KScreenWidth*0.9, KScreenHeight*0.06);
    
    _contentTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _contentTextView.layoutManager.allowsNonContiguousLayout=NO;
}
- (void)test2:(NSNotification *)note{
    NSDictionary* info = [note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _contentTextView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0);
    _contentTextView.layoutManager.allowsNonContiguousLayout=NO;
}

@end
