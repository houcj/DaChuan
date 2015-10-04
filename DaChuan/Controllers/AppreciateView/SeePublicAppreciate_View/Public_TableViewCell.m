//
//  Public_TableViewCell.m
//  DaChuan
//
//  Created by dachuan on 15/9/29.
//  Copyright (c) 2015年 DaChuan. All rights reserved.
//

#import "Public_TableViewCell.h"


@implementation Public_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createBtn];
    }
    return self;
}

- (void)createBtn{
    
//    _contentLabel = [[UILabel alloc] init];
//    _contentLabel.font = [UIFont systemFontOfSize:14];
//   
//    _supportLabelImage = [[UILabel alloc] init];
//    
//    _commentLabelImage = [[UILabel alloc] init];
    
    _nameLabel = [[UILabel alloc] init];

    _commentLabel = [[UILabel alloc] init];
    _commentLabel.font = [UIFont systemFontOfSize:14];
    
    _supportBtn = [[UIButton alloc] init];
    
    
    _editBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.2, KScreenHeight*0.1, KScreenWidth*0.25, KScreenHeight*0.05)];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth*0.55, KScreenHeight*0.1, KScreenWidth*0.25, KScreenHeight*0.05)];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_nameLabel];
    [self addSubview:_commentLabel];
    [self addSubview:_supportBtn];
//    [self addSubview:_editBtn];
//    [self addSubview:_deleteBtn];
}

- (void)setInfo:(Info *)info{
    
    _nameLabel.frame =CGRectMake(KScreenWidth*0.1, KScreenHeight*0.01, KScreenWidth*0.75, KScreenHeight*0.05);
    
    _commentLabel.frame = CGRectMake(KScreenWidth*0.1, _nameLabel.origin.y+_nameLabel.size.height+KScreenHeight*0.01, KScreenWidth*0.75, KScreenHeight*0.05);
    
    _supportBtn.frame = CGRectMake(_nameLabel.origin.x+_nameLabel.size.width+KScreenWidth*0.02, KScreenHeight*0.08, KScreenWidth*0.1, KScreenHeight*0.05);
    [_supportBtn setTitle:@"赞" forState:UIControlStateNormal];
    [_supportBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [_supportBtn addTarget:self action:@selector(supportBtnMethod) forControlEvents:UIControlEventTouchUpInside];

    _height = CGRectGetMaxY(_commentLabelImage.frame);
}

- (void)supportBtnMethod{
    NSLog(@"------------------------点赞－－－－－－－－－－－－－－－－－－－");
}

- (void)editBtnMethod{
    NSLog(@"－－－－－－－－－－－－－－－编辑－－－－－－－－－－－－－－－－－－－－－－");
}

- (void)deleteBtnMethod{
    NSLog(@"－－－－－－－－－－－－－－－－－－删除－－－－－－－－－－－－－－－－－－－－－");
}

- (void)shareBtnMethod{
    NSLog(@"－－－－－－－－－－－－－－－－分享－－－－－－－－－－－－－－－－－－－－－－－");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
