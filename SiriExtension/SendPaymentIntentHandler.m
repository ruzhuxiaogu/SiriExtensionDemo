//
//  SendPaymentIntentHandler.m
//  SiriExtension
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "SendPaymentIntentHandler.h"
#import "UserInfoModel.h"

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



@interface SendPaymentIntentHandler () <INSendPaymentIntentHandling>

@end

@implementation SendPaymentIntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // 这是默认的实现,如果你想要不同的对象来处理不同的意图,你可以覆盖重写
    return self;
}

// 以下是转账的意图类型代理方法

#pragma mark - INSendPaymentIntentHandling

/*
   解析收款人方法	 - resolvePayeeForSendPayment:withCompletion:
   解析货币单位方法	 - resolveCurrencyAmountForSendPayment:withCompletion:
   解析附加语方法	 - resolveNoteForSendPayment:withCompletion:
   解析付款方式方法	 - resolvePaymentMethodForSendPayment:withCompletion:
   确认方法	     - confirmSendPayment:completion:
   处理方法	     - handleSendPayment:completion:
 */

// 解析收款人方法
- (void)resolvePayeeForSendPayment:(INSendPaymentIntent *)intent withCompletion:(void (^)(INPersonResolutionResult * resolutionResult))completion {
    NSLog(@"%@",intent.payee.displayName);
    NSLog(@"%@",intent.payee.nameComponents.givenName);
    NSLog(@"%@",intent.payee.nameComponents.familyName);

    INPerson *payee = intent.payee;
    // 如果没有收款人,返回，需要Siri提示:你要付款给谁。
    if (!payee) {
        completion([INPersonResolutionResult needsValue]);
        return;
    }
    
    INPerson *matchingContact;
    
    INPersonResolutionResult *resolutionResult;
    
    // 此处添加自有匹配代码
    NSString *payeeName = intent.payee.displayName;   //匹配的名称
    
    // 先精确匹配
    UserInfoModel *user = [UserInfoModel userInfoNamed:payeeName];
    
    if (user) {
        // 创建一个匹配成功的用户
        INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:user.userAccount type:INPersonHandleTypePhoneNumber];
        
        INImage *icon = [INImage imageNamed:user.userIcon];
        
        INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:user.userName image:icon contactIdentifier:nil customIdentifier:nil aliases:nil suggestionType:INPersonSuggestionTypeSocialProfile];
        
        // 记录匹配的用户
        matchingContact = person;
    }
    
    if (matchingContact) {
        // We need Siri's help to ask user to pick one from the matches.
        resolutionResult = [INPersonResolutionResult successWithResolvedPerson:matchingContact];
        
    }else {
        // We have no contacts matching the description provided
        resolutionResult = [INPersonResolutionResult unsupported];
    }


    completion(resolutionResult);
    
}

// 解析货币单位方法
- (void)resolveCurrencyAmountForSendPayment:(INSendPaymentIntent *)intent withCompletion:(void (^)(INCurrencyAmountResolutionResult * resolutionResult))completion {
    INCurrencyAmount *amount = intent.currencyAmount;
    //amount.currencyCode = @"CNH";
    if (amount == nil) {
        completion([INCurrencyAmountResolutionResult needsValue]);
        return;
    }
    completion([INCurrencyAmountResolutionResult successWithResolvedCurrencyAmount:amount]);
}

// 解析附加语方法
- (void)resolveNoteForSendPayment:(INSendPaymentIntent *)intent withCompletion:(void (^)(INStringResolutionResult * resolutionResult))completion {
    NSString *text = intent.note;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// 确认方法
- (void)confirmSendPayment:(INSendPaymentIntent *)intent completion:(void (^)(INSendPaymentIntentResponse * response))completion {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendPaymentIntent class])];
    INSendPaymentIntentResponse *response = [[INSendPaymentIntentResponse alloc] initWithCode:INSendPaymentIntentResponseCodeReady userActivity:userActivity];    
    response.paymentRecord = [[INPaymentRecord alloc] initWithPayee:intent.payee payer:nil currencyAmount:intent.currencyAmount paymentMethod:nil note:intent.note status:INPaymentStatusPending];
    completion(response);
}

// 处理方法
- (void) handleSendPayment:(INSendPaymentIntent *)intent completion:(void (^)(INSendPaymentIntentResponse * response))completion {
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendPaymentIntent class])];
    INSendPaymentIntentResponse *response = [[INSendPaymentIntentResponse alloc] initWithCode:INSendPaymentIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

@end

