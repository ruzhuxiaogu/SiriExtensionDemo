//
//  UserInfoModel.h
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户模型
@interface UserInfoModel : NSObject

// 用户头像
@property (nonatomic, copy) NSString *userIcon;

// 用户名称
@property (nonatomic, copy) NSString *userName;

// 用户账号
@property (nonatomic, copy) NSString *userAccount;

// 备注信息
@property (nonatomic, copy) NSString *userRemarks;


// 测试数据返回用户列表
+ (NSArray <UserInfoModel *> *)userList;

// 返回名称对应的用户信息
+ (UserInfoModel *)userInfoNamed:(NSString *)name;

@end
