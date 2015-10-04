//
//  AppreciateView.m
//  Demo
//
//  Created by DaChuan on 15/9/18.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "AppreciateView.h"
#import "Main_UITableViewCell.h"
#import "NewAppreciate_ViewController.h"
#import "common.h"
#import "AFNetworking.h"

@implementation AppreciateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //添加导航栏
        [self addNavigation];
        
        [self getMethod];
    }
    
    return self;
}

-(void)addNavigation
{
    _tokenUserDefaults = [NSUserDefaults standardUserDefaults];
    _infoMuArr = [NSMutableArray array];
    _cellMuArr = [NSMutableArray array];
    
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    //导航栏
    UIView *Nav = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    Nav.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
//    [Nav addSubview:myAppreciateLabel];
    //导航栏标题
    CGFloat titleW = KScreenWidth*0.3;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth*0.35, 20+11, titleW, 22)];
    title.text = @"我的感悟";
    title.font = [UIFont systemFontOfSize:14];
    [title setTextAlignment:NSTextAlignmentCenter];
    [Nav addSubview:title];
    //导航栏按钮
    CGFloat btnW = 36;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-btnW-6, 20+4, btnW, 36)];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"编辑" forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(didEdit) forControlEvents:UIControlEventTouchUpInside];
    [Nav addSubview:btn];
    
    [self addSubview:Nav];
    
//    if ([_tokenUserDefaults objectForKey:@"token"]) {
//        [self getMethod];
//    }else{
//        
//    }
    
    
    
}


-(void)getMethod{
    NSLog(@"-------token----------%@",[_tokenUserDefaults objectForKey:@"token"]);
    
    if ([_tokenUserDefaults objectForKey:@"token"]) {
        NSString *url = @"http://101.200.91.181:81/api_article/loadArticleList.htm";
        NSDictionary *dic = @{
                              @"token" : [_tokenUserDefaults objectForKey:@"token"],
                              @"pageNo" : @"0"
                              };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"------result ------%@",[responseObject objectForKey:@"result"]);
            
            if ([[responseObject objectForKey:@"result"] isEqual:@"login"]) {
                [self.AppreciateDelegate AppreciateVIewToLogIn_ViewController:self];
            }else{
                
                NSLog(@"---->%@",responseObject);
                
                
                NSArray *arr = [NSArray arrayWithArray:[responseObject objectForKey:@"content"]];
                
                for (NSDictionary *dic in arr) {
                    _info = [[Info alloc] init];
                    _info.sid = [dic objectForKey:@"sid"];
                    _info.title = [dic objectForKey:@"title"];
                    _info.time = [dic objectForKey:@"time"];
                    _info.content = [dic objectForKey:@"content"];
                    _info.like = [dic objectForKey:@"like"];
                    _info.comment = [dic objectForKey:@"comment"];
                    _info.isPublic = [dic objectForKey:@"isPublic"];
//                    NSLog(@"----------------------%d",arr.count);
                    _info.labels = [dic objectForKey:@"labels"];
                    _info.pics = [dic objectForKey:@"pics"];
                    [_infoMuArr addObject:_info];
                    Main_UITableViewCell *cell = [[Main_UITableViewCell alloc] init];
                    cell.info = _info;
                    [_cellMuArr addObject:cell];
                    
//                    NSLog(@"--------------%@------------%@---------------%@---------%@------------%@----------%@----------%@-------------%@----------%@",_info.sid,_info.title,_info.time,_info.content,_info.like,_info.comment,_info.isPublic,_info.labels,_info.pics);
                }
                //添加主视图
                [self addMainContent];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];

    }else{
        
        _alert.message = @"你还未登录，是否登录？";
        [_alert show];
        //-------------------------------------还要更改－－－－－－－－－－－－－－－－－－－－－－－
    }
}

-(void)addMainContent
{
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-49) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self addSubview:_mainTableView];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_cell) {
        _cell = [[Main_UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    _cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    _cell.info = [_infoMuArr objectAtIndex:indexPath.row];
    
    if ([_cell.info.isPublic isEqualToString:@"0"]) {
        _cell.privateImageView.image = [UIImage imageNamed:@"encrypt.png"];
    }else{
        [_cell.commentBtn setTitle:[NSString stringWithFormat:@"评论  %@",_info.comment] forState:UIControlStateNormal];
        [_cell.commentBtn addTarget:self action:@selector(commentBtnAndSupportBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        
        [_cell.supportBtn setTitle:[NSString stringWithFormat:@"赞  %@",_info.like] forState:UIControlStateNormal];
        [_cell.supportBtn addTarget:self action:@selector(commentBtnAndSupportBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cell;
}

- (void)commentBtnAndSupportBtnMethod{
    if (/*判读用户是否登陆*/1) {
        //push到浏览感悟界面
    }else{
        //push到登录界面
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Main_UITableViewCell *cell = [_cellMuArr objectAtIndex:indexPath.row];
    
    if ([cell.info.isPublic isEqualToString:@"0"]) {
        //push到私密浏览感悟
    }else{
        //push公开浏览感悟
        NSLog(@"token  %@",[_tokenUserDefaults objectForKey:@"token"]);
        if ([_tokenUserDefaults objectForKey:@"token"]) {
            Info *info = [_infoMuArr objectAtIndex:indexPath.row];
            NSLog(@"是否有值＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝%@＝＝＝＝＝＝＝%@",info.sid,info.title);
            [self.AppreciateDelegate AppreciateViewToSeePublicAppreciate_ViewController:info];
            
        }else{//未登录
            [self.AppreciateDelegate AppreciateVIewToLogIn_ViewController:self];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Main_UITableViewCell *mainCell = [_cellMuArr objectAtIndex:indexPath.row];
    mainCell.info = [_infoMuArr objectAtIndex:indexPath.row];
    return _cell.hight;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _infoMuArr.count;
}
//点击导航栏右侧按钮事件响应
-(void)didEdit
{
    /*-------------------------------判断用户是否登录-------------------------------------------*/
    
    if ([_tokenUserDefaults objectForKey:@"token"]) {
        if ([self.AppreciateDelegate respondsToSelector:@selector(AppreciateViewToNewAppreciate_ViewController:)]) {
            [self.AppreciateDelegate AppreciateViewToNewAppreciate_ViewController:self];
        }
    }else{
        
        [_alert show];
        
        }
    
 }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if ([self.AppreciateDelegate respondsToSelector:@selector(AppreciateViewToRegist_ViewController:)]) {
            [self.AppreciateDelegate AppreciateViewToRegist_ViewController:self];
        }
    }
}


@end
