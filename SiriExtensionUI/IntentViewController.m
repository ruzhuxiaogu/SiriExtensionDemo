//
//  IntentViewController.m
//  SiriExtensionUI
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "IntentViewController.h"
#import <Intents/Intents.h>
#import "UserInfoModel.h"
#import "SendMessageIntentView.h"
#import "SendPaymentIntentView.h"
#import "KuaibaoIntent.h"
#import "KuaibaoIntentView.h"

#define cellIdentifier @"cellIdentifier"


@interface IntentViewController () <INUIHostedViewSiriProviding, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SendMessageIntentView *sendMsgView;
    
@property (nonatomic, strong) SendPaymentIntentView *sendPayView;

@property (nonatomic, strong) KuaibaoIntentView *kuaibaoIntentView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation IntentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sendMsgView];
    [self.view addSubview:self.sendPayView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (SendMessageIntentView *)sendMsgView {
    if (!_sendMsgView) {
        _sendMsgView = [[SendMessageIntentView alloc] initWithFrame:self.view.frame];
        _sendMsgView.hidden = YES;
    }
    return _sendMsgView;
}
    
- (SendPaymentIntentView *)sendPayView {
    if (!_sendPayView) {
        _sendPayView = [[SendPaymentIntentView alloc] initWithFrame:self.view.frame];
        _sendPayView.hidden = YES;
    }
    return _sendPayView;
}

- (KuaibaoIntentView *)kuaibaoIntentView{
    if (!_kuaibaoIntentView) {
        _kuaibaoIntentView = [[KuaibaoIntentView alloc] initWithFrame:self.view.frame];
        _kuaibaoIntentView.hidden = YES;
    }
    return _kuaibaoIntentView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


#pragma mark - INUIHostedViewControlling

// 获取siri解析的意图，准备视图展示
- (void)configureWithInteraction:(INInteraction *)interaction context:(INUIHostedViewContext)context completion:(void (^)(CGSize))completion {
    if ([interaction.intent isKindOfClass:[INSendMessageIntent class]]) {
        // 获取发送消息的意图
        INSendMessageIntent *intent = (INSendMessageIntent *)(interaction.intent);
        self.sendMsgView.hidden = YES;
        self.sendPayView.hidden = YES;
        self.tableView.hidden = YES;
        self.sendMsgView.intent = intent;
        // 获取错误信息
        //NSUserActivity *activity = interaction.intentResponse.userActivity;
        
    }else if ([interaction.intent isKindOfClass:[INSendPaymentIntent class]]) {
        // 获取转账付款的意图
        INSendPaymentIntent *intent = (INSendPaymentIntent *)(interaction.intent);
        self.sendMsgView.hidden = YES;
        self.sendPayView.hidden = YES;
        self.tableView.hidden = YES;
        self.sendPayView.intent = intent;
        
    }else if([interaction.intent isKindOfClass:[KuaibaoIntent class]]){
        self.sendMsgView.hidden = YES;
        self.sendPayView.hidden = YES;
        self.tableView.hidden = NO;
        if (completion) {
            completion(CGSizeMake([self desiredSize].width, 280));
        }
    }else {
        return;
    }
}

- (CGSize)desiredSize {
    return [self extensionContext].hostedViewMaximumAllowedSize;
}

#pragma mark - INUIHostedViewSiriProviding
// 用代理方法返YES禁止默认的发消息界面
- (BOOL)displaysMessage {
    return NO;
}

// 用代理方法返YES禁止默认的转账的界面
- (BOOL)displaysPaymentTransaction {
    return NO;
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"天天快报新闻";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280 / 3;
}

@end
