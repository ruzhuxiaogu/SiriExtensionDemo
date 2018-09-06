//
//  SendMessageIntentView.m
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/10.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "SendMessageIntentView.h"
#import "UserInfoModel.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:0.8]

#define kWidth (self.frame.size.width - 28)   //扩展UI的View自带左右margin = 14

@interface SendMessageIntentView ()

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *targetIconView;

@property (nonatomic, strong) UILabel *targetUserLabel;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIImageView *msgBgView;

@property (nonatomic, strong) UIImageView *myIconView;

    
@end

@implementation SendMessageIntentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
    
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headView];
    [self addSubview:self.targetUserLabel];
    [self addSubview:self.myIconView];
    [self addSubview:self.msgBgView];
    [self addSubview:self.commentLabel];
}

-(void)setIntent:(INSendMessageIntent *)intent {
    NSString *name = [[intent.recipients lastObject] displayName];
    NSString *content = intent.content;
    
    NSLog(@"发送内容:%@", content);
    
    // 显示与隐藏
    self.targetIconView.hidden = !name.length;
    self.commentLabel.hidden = !content.length;
    self.msgBgView.hidden = !content.length;
    
    // 发消息目标
    if (name.length == 0) {
        self.targetUserLabel.text = [NSString stringWithFormat:@"发消息给\"谁?\""];
    }else {
        self.targetUserLabel.text = [NSString stringWithFormat:@"发消息给\"%@\"", name];

    }
    // 消息内容
    self.commentLabel.text = content;
 
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 64)];
        _headView.backgroundColor = RGBCOLOR(237, 108, 0);
        [_headView addSubview:self.targetIconView];
    }
    return _headView;
}

- (UILabel *)targetUserLabel {
    if (!_targetUserLabel) {
        _targetUserLabel = [[UILabel alloc] initWithFrame:CGRectMake((kWidth - 120)/2, (64 - 20)/2, 120, 20)];
        _targetUserLabel.textAlignment = NSTextAlignmentCenter;
        _targetUserLabel.textColor = [UIColor whiteColor];
        _targetUserLabel.font = [UIFont systemFontOfSize:16];
        _targetUserLabel.text = @"准备发消息";
    }
    return _targetUserLabel;
}

- (UIImageView *)targetIconView{
    if (!_targetIconView) {
        _targetIconView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 7, 50, 50)];
        _targetIconView.image = [UIImage imageNamed:@"icon2"];
        _targetIconView.layer.masksToBounds = YES;
        _targetIconView.layer.cornerRadius = 25;
    }
    return _targetIconView;
}

- (UIImageView *)myIconView{
    if (!_myIconView) {
        _myIconView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 14 - 50, 64 + 40, 50, 50)];
        _myIconView.image = [UIImage imageNamed:@"icon1"];
        _myIconView.layer.masksToBounds = YES;
        _myIconView.layer.cornerRadius = 25;
    }
        return _myIconView;
}
    
- (UIImageView *)msgBgView{
    if (!_msgBgView) {
        _msgBgView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 14 - 50  - self.commentLabel.frame.size.width - 30, 64 + 40 + 5, self.commentLabel.frame.size.width + 30, 50)];
        _msgBgView.contentMode = UIViewContentModeScaleToFill;
        _msgBgView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _msgBgView.clipsToBounds  = YES;
        _msgBgView.image = [UIImage imageNamed:@"msg_bg"];
    }
    return _msgBgView;
}
    
- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWidth - 14 - 50 - 10 - 100 - 5, CGRectGetMidY(self.myIconView.frame), 100,16)];
        _commentLabel.font = [UIFont systemFontOfSize:16];
        _commentLabel.textAlignment = NSTextAlignmentRight;
        _commentLabel.text = @"你好";
    }
    return _commentLabel;
}


@end
