//
//  SendPaymentIntentView.h
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/10.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Intents/Intents.h>

@interface SendPaymentIntentView : UIView

@property (nonatomic , strong) INSendPaymentIntent *intent;    //转账付款意图

@end
