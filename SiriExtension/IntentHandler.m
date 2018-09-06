//
//  IntentHandler.m
//  SiriExtension
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "IntentHandler.h"
#import "UserInfoModel.h"
#import "SendMessageIntentHandler.h"
#import "SendPaymentIntentHandler.h"
#import "KuaiBaoIntentHandler.h"
#import "KuaibaoIntent.h"
#import "TestIntent.h"

/*************************************************************************
 *   说明：本Demo演示涉及苹果官方指定的6个意图的2个，分别是：发消息、转账。
 *        分别在对应的SiriExtension和SiriExtensionUI中的Info.plit
 *        文件中添加INSendMessageIntent，INSendPaymentIntent两个意图类型支持。在此类中也有实现对应的代理方法。
 *        如想实现其他意图的，可以另外添加支持和相关代理方法和函数
 **************************************************************************/



/*************************************************************************
 *   你可以对Siri用以下对话（推荐）来测试：
 *   ----发消息----
 *   "用<appName>给小明发消息"
 *   ----转 账----
 *   "用<appName>转账15元给小明"
 **************************************************************************/


@interface IntentHandler ()

@end

@implementation IntentHandler

// 这里是SiriExtension的入口，判断意图类型
- (id)handlerForIntent:(INIntent *)intent {
    // 这是默认的实现,如果你想要不同的对象来处理不同的意图,你可以覆盖重写
    if ([intent isKindOfClass:[INSendMessageIntent class]]) {
        SendMessageIntentHandler *SendMsgHandler = [[SendMessageIntentHandler alloc] init];
        return SendMsgHandler;
    }else if ([intent isKindOfClass:[INSendPaymentIntent class]]) {
        //SendPaymentIntentHandler *SendPayHandler = [[SendPaymentIntentHandler alloc] handlerForIntent:intent];
        SendPaymentIntentHandler *SendPayHandler = [[SendPaymentIntentHandler alloc] init];
        return SendPayHandler;
    }else if([intent isKindOfClass:[KuaibaoIntent class]]){
        KuaiBaoIntentHandler *kuaibaoIntentHandler = [[KuaiBaoIntentHandler alloc] init];
        return kuaibaoIntentHandler;
    }else{
        return self;
    }
}


@end

