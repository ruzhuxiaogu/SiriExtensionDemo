//
//  KuaiBaoIntentHandler.m
//  SiriExtension
//
//  Created by tingdongli on 2018/8/31.
//  Copyright © 2018年 haofree. All rights reserved.
//

#import "KuaiBaoIntentHandler.h"

@implementation KuaiBaoIntentHandler

- (void)confirmKuaibao:(KuaibaoIntent *)intent completion:(void (^)(KuaibaoIntentResponse *response))completion NS_SWIFT_NAME(confirm(intent:completion:)){
    
}

- (void)handleKuaibao:(nonnull KuaibaoIntent *)intent completion:(nonnull void (^)(KuaibaoIntentResponse * _Nonnull))completion  API_AVAILABLE(ios(12.0)){
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([KuaibaoIntent class])];
    KuaibaoIntentResponse *response = [[KuaibaoIntentResponse alloc] initWithCode:KuaibaoIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

@end
