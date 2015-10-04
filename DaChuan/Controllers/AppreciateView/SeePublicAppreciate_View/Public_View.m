//
//  Public_View.m
//  DaChuan
//
//  Created by dachuan on 15/10/1.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "Public_View.h"

@implementation Public_View

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setInfo:(Info *)info{
    _info = info;
    [self getMethod];
}
-(void)getMethod{
    _tokenUserDefaults = [NSUserDefaults standardUserDefaults];
    if ([_tokenUserDefaults objectForKey:@"token"]) {
        NSString *url = @"http://101.200.91.181:81/api_article/loadArticle.htm";
        
        NSLog(@":_info.sid=================%@",_info.sid);
        
        NSDictionary *dic = @{
                              @"token" : [_tokenUserDefaults objectForKey:@"token"],
                              @"id":@"1"
//                              @"id":_info.sid
                              };
        NSLog(@"dic----%@",dic);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"成功");
            
            if ([[responseObject objectForKey:@"result"] isEqual:@"login"])
            {
                
                [self.delegate public_ViewToLogInViewController:self];
                NSLog(@"成功1");
            }else{
//                _responseDic = responseObject;
                NSLog(@"成功2－－－－－－－－－》%@",responseObject);
                _info = [[Info alloc] init];
                _info.title = [responseObject objectForKey:@"title"];
                _info.time = [responseObject objectForKey:@"time"];
                _info.sid = [responseObject objectForKey:@"sid"];
                _info.userId = [responseObject objectForKey:@"userId"];
                _info.userName = [responseObject objectForKey:@"userName"];
                _info.content = [responseObject objectForKey:@"content"];
                _info.isMine = [responseObject objectForKey:@"isMine"];
                _info.isPublic = [responseObject objectForKey:@"isPublic"];
                _info.like = [responseObject objectForKey:@"like"];
                _info.comment = [responseObject objectForKey:@"comment"];
                
                //添加主视图
                [self createView];
                NSLog(@"成功3");
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"===>%@",error);
            
        }];
        
    }else{
//        _alert.message = @"你还未登录，是否登录？";
//        [_alert show];
//        //-------------------------------------还要更改－－－－－－－－－－－－－－－－－－－－－－－
    }
}

- (void)createView{
    
    
    _headerView = [[UIView alloc] init];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = _info.title;
    _titleLabel.frame = CGRectMake(KScreenWidth*0.01, KScreenHeight*0.01, KScreenWidth*0.6, KScreenHeight*0.05);
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = _info.time;
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.frame = CGRectMake(KScreenWidth*0.65, _titleLabel.origin.y+_titleLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.3, KScreenHeight*0.05);
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.text = _info.content;
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width*0.98f;
    CGSize contentSize = [_info.content boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
    _contentLabel.frame = CGRectMake(KScreenWidth*0.02, _timeLabel.origin.y+_timeLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.96, contentSize.height);
    [_contentLabel sizeToFit];
    
    _supportLabelImage = [[UILabel alloc] init];
    _supportLabelImage.text = [NSString stringWithFormat:@"赞：%@",_info.like];
    _supportLabelImage.frame = CGRectMake(KScreenWidth*0.02, _contentLabel.origin.y+_contentLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.8, KScreenHeight*0.05);
    
    _commentLabelImage = [[UILabel alloc] init];
    _commentLabelImage.text = [NSString stringWithFormat:@"评：%@",_info.comment];
    _commentLabelImage.frame = CGRectMake(KScreenWidth*0.02, _supportLabelImage.origin.y+_supportLabelImage.size.height+KScreenHeight*0.01, KScreenWidth*0.8, KScreenHeight*0.05);
    
    [_headerView addSubview:_titleLabel];
    [_headerView addSubview:_timeLabel];
    [_headerView addSubview:_contentLabel];
    [_headerView addSubview:_supportLabelImage];
    [_headerView addSubview:_commentLabelImage];
    
    _heightHead = CGRectGetMaxY(_commentLabelImage.frame)+KScreenHeight*0.01;
    
    NSLog(@"heightHeader---------------%f",_heightHead);
    
    _headerView.frame = CGRectMake(0, 64, KScreenWidth, _heightHead);
    
    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.origin.y+_headerView.size.height+KScreenHeight*0.01, KScreenWidth, KScreenHeight*0.9) style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    
    [self addSubview:_headerView];
    [self addSubview:_mainTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"Cell";
    Public_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[Public_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.info = _info;
    if (indexPath.row == 0) {
        
        [cell.supportBtn removeFromSuperview];
        
    }else{
        [cell.contentLabel removeFromSuperview];
        cell.titleLabel.text = @"谁评论的";
        cell.commentLabel.text = @"11";
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Public_TableViewCell *cell = [[Public_TableViewCell alloc] init];
    cell.info = _info;
    if (cell.height>88) {
        return 88;
    }else{
        return cell.height;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Public_TableViewCell *cell = [[Public_TableViewCell alloc] init];
    
    //点击进行回复
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


@end
