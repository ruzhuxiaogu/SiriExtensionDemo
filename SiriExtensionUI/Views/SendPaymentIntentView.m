//
//  SendPaymentIntentView.m
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/10.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "SendPaymentIntentView.h"
#import "UserInfoModel.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:0.8]

#define kWidth (self.frame.size.width - 28)   //扩展UI的View自带左右margin = 14
#define kHeight (self.frame.size.height - 28)

@interface SendPaymentIntentView ()

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UIImageView *targetIconView;

@property (nonatomic, strong) UILabel *targetUserLabel;

@property (nonatomic, strong) UILabel *amountLabel;

@property (nonatomic, strong) UIImageView *myIconView;

@property (nonatomic, strong) UILabel *commentLabel;

    
@end

@implementation SendPaymentIntentView

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
    [self addSubview:self.amountLabel];
    [self addSubview:self.commentLabel];
}

-(void)setIntent:(INSendPaymentIntent *)intent {
    NSString *name = intent.payee.displayName;
    NSString *amount = [NSString stringWithFormat:@"%@元",intent.currencyAmount.amount];
    NSString *comment = intent.note;

    
    NSLog(@"付款金额:%@", amount);
    
    // 显示与隐藏
    self.targetIconView.hidden = !name.length;
    self.amountLabel.hidden = !amount.length;
    self.commentLabel.hidden = !comment.length;

    
    // 转账目标
    if (name.length == 0) {
        self.targetUserLabel.text = [NSString stringWithFormat:@"转账给\"谁?\""];
    }else {
        self.targetUserLabel.text = [NSString stringWithFormat:@"转账给\"%@\"", name];

    }
    // 转账金额
    self.amountLabel.text = amount;
    // 转账备注
    self.commentLabel.text = [NSString stringWithFormat:@"备注:%@", comment];;

 
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _headView.backgroundColor = RGBCOLOR(63, 177, 251);
        [_headView addSubview:self.targetIconView];
    }
    return _headView;
}

- (UILabel *)targetUserLabel {
    if (!_targetUserLabel) {
        _targetUserLabel = [[UILabel alloc] initWithFrame:CGRectMake((kWidth - 120)/2, (80 - 20)/2, 120, 20)];
        _targetUserLabel.textAlignment = NSTextAlignmentCenter;
        _targetUserLabel.textColor = [UIColor whiteColor];
        _targetUserLabel.font = [UIFont systemFontOfSize:16];
        _targetUserLabel.text = @"准备发转账";
    }
    return _targetUserLabel;
}

- (UIImageView *)targetIconView{
    if (!_targetIconView) {
        _targetIconView = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth - 14 - 50, 15, 50, 50)];
        _targetIconView.image = [UIImage imageNamed:@"icon2"];
        _targetIconView.layer.masksToBounds = YES;
        _targetIconView.layer.cornerRadius = 25;
    }
    return _targetIconView;
}

- (UIImageView *)myIconView{
    if (!_myIconView) {
        _myIconView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 15, 50, 50)];
        _myIconView.image = [UIImage imageNamed:@"icon1"];
        _myIconView.layer.masksToBounds = YES;
        _myIconView.layer.cornerRadius = 25;
    }
        return _myIconView;
}
    
    
- (UILabel *)amountLabel{
    if (!_amountLabel) {
        _amountLabel =  [[UILabel alloc] initWithFrame:CGRectMake((kWidth - 120)/2, 80, 120, 60)];
        _amountLabel.font = [UIFont systemFontOfSize:28];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.textColor = [UIColor whiteColor];
        _amountLabel.text = @"你好";
    }
    return _amountLabel;
}

- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, 80 + 60, kWidth, 60)];
        _commentLabel.font = [UIFont systemFontOfSize:16];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.text = @"100元";
    }
    return _commentLabel;
}

@end
