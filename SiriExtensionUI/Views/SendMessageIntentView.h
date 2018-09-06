//
//  SendMessageIntentView.h
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/10.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Intents/Intents.h>

@interface SendMessageIntentView : UIView

@property (nonatomic , strong) INSendMessageIntent *intent;    //发消息意图

@end
