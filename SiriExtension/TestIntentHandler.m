//
//  TestIntentHandler.m
//  SiriExtension
//
//  Created by tingdongli on 2018/9/3.
//  Copyright © 2018年 haofree. All rights reserved.
//

#import "TestIntentHandler.h"

@implementation TestIntentHandler

- (void)handleTest:(TestIntent *)intent completion:(void (^)(TestIntentResponse *response))completion NS_SWIFT_NAME(handle(intent:completion:)){
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([TestIntent class])];
    TestIntentResponse *response = [[TestIntentResponse alloc] initWithCode:TestIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

@end
