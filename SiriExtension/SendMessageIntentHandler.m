//
//  SendMessageIntentHandler.m
//  SiriExtension
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "SendMessageIntentHandler.h"
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



@interface SendMessageIntentHandler () <INSendMessageIntentHandling, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling>

@end

@implementation SendMessageIntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // 这是默认的实现,如果你想要不同的对象来处理不同的意图,你可以覆盖重写
    return self;
}

//以下是发消息的意图类型代理方法
#pragma mark - INSendMessageIntentHandling

/*
 解析消息接收人方法	     - resolveRecipientsForSendMessage:withCompletion:
 解析发送消息内容方法	 - resolveContentForSendMessage:withCompletion:
 确认方法	             - confirmSendMessage:completion:
 处理方法	             - handleSendMessage:completion:
 */

// 解析发送消息语义，提取意图对象、消息发送对象
- (void)resolveRecipientsForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(NSArray<INPersonResolutionResult *> *resolutionResults))completion {
    NSArray<INPerson *> *recipients = intent.recipients;
    // 如果没有消息接收人,返回，需要Siri提示:你要发消息给谁。
    if (recipients.count == 0) {
        completion(@[[INPersonResolutionResult needsValue]]);
        return;
    }
    NSMutableArray<INPersonResolutionResult *> *resolutionResults = [NSMutableArray array];
    
    for (INPerson *recipient in recipients) {
        NSMutableArray<INPerson *> *matchingContacts = [NSMutableArray array]; // Implement your contact matching logic here to create an array of matching contacts
        
        // 此处添加自有匹配代码
        NSString *recipientName = recipient.displayName;   //匹配的名称
        
        // 先精确匹配
        UserInfoModel *user = [UserInfoModel userInfoNamed:recipientName];
        
        if (user) {
            
            // 创建一个匹配成功的用户
            INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:user.userAccount type:INPersonHandleTypePhoneNumber];
            
            INImage *icon = [INImage imageNamed:user.userIcon];
            
            INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:user.userName image:icon contactIdentifier:nil customIdentifier:nil aliases:nil suggestionType:INPersonSuggestionTypeSocialProfile];
            
            // 记录匹配的用户
            [matchingContacts addObject:person];
        }
        
        if (matchingContacts.count == 0) {
            // 如果精确匹配没有的话提供模糊匹配,匹配包含内容
            for (UserInfoModel *user in [UserInfoModel userList]) {
                
                // 用户名称
                NSString *name = user.userName;
                
                // 包含匹配
                if ([recipientName containsString:name]) {
                    
                    // 创建一个匹配成功的用户
                    INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:user.userAccount type:INPersonHandleTypeEmailAddress];
                    INImage *icon = [INImage imageWithURL:[NSURL URLWithString:user.userIcon]];
                    
                    INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:name image:icon contactIdentifier:nil customIdentifier:nil aliases:nil suggestionType:INPersonSuggestionTypeSocialProfile];
                    
                    //  记录匹配的用户
                    [matchingContacts addObject:person];
                }
                
            }
        }
        
        
        if (matchingContacts.count > 1) {
            // 我们需要Siri的帮助要求用户选择一个匹配.
            [resolutionResults addObject:[INPersonResolutionResult disambiguationWithPeopleToDisambiguate:matchingContacts]];
        } else if (matchingContacts.count == 1) {
            // 我们有一个匹配的联系人
            [resolutionResults addObject:[INPersonResolutionResult successWithResolvedPerson:recipient]];
        } else {
            // 数据模型中没有匹配到联系人
            [resolutionResults addObject:[INPersonResolutionResult unsupported]];
        }
    }
    completion(resolutionResults);
}

// 解析发送消息内容方法
- (void)resolveContentForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSString *text = intent.content;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// 确认方法，确认准备发消息
- (void)confirmSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Verify user is authenticated and your app is ready to send a message.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeReady userActivity:userActivity];
    completion(response);
}

// 处理方法，处理发送信息逻辑
- (void)handleSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Implement your application logic to send a message here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

// Implement handlers for each intent you wish to handle.  As an example for messages, you may wish to also handle searchForMessages and setMessageAttributes.

#pragma mark - INSearchForMessagesIntentHandling

- (void)handleSearchForMessages:(INSearchForMessagesIntent *)intent completion:(void (^)(INSearchForMessagesIntentResponse *response))completion {
    // Implement your application logic to find a message that matches the information in the intent.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSearchForMessagesIntent class])];
    INSearchForMessagesIntentResponse *response = [[INSearchForMessagesIntentResponse alloc] initWithCode:INSearchForMessagesIntentResponseCodeSuccess userActivity:userActivity];
    // Initialize with found message's attributes
    response.messages = @[[[INMessage alloc]
        initWithIdentifier:@"identifier"
        content:@"I am so excited about SiriKit!"
        dateSent:[NSDate date]
        sender:[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"sarah@example.com" type:INPersonHandleTypeEmailAddress] nameComponents:nil displayName:@"Sarah" image:nil contactIdentifier:nil customIdentifier:nil]
        recipients:@[[[INPerson alloc] initWithPersonHandle:[[INPersonHandle alloc] initWithValue:@"+1-415-555-5555" type:INPersonHandleTypePhoneNumber] nameComponents:nil displayName:@"John" image:nil contactIdentifier:nil customIdentifier:nil]]
    ]];
    completion(response);
}

#pragma mark - INSetMessageAttributeIntentHandling

- (void)handleSetMessageAttribute:(INSetMessageAttributeIntent *)intent completion:(void (^)(INSetMessageAttributeIntentResponse *response))completion {
    // Implement your application logic to set the message attribute here.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSetMessageAttributeIntent class])];
    INSetMessageAttributeIntentResponse *response = [[INSetMessageAttributeIntentResponse alloc] initWithCode:INSetMessageAttributeIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}

@end

