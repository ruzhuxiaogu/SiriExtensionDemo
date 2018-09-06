//
//  UserInfoModel.m
//  SiriExtensionDemo
//
//  Created by haofree on 2017/7/8.
//  Copyright © 2017年 haofree. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSArray<UserInfoModel *> *)userList {
    
    UserInfoModel *me  = [[UserInfoModel alloc] init];
    me.userIcon        = @"http://img4.imgtn.bdimg.com/it/u=1290022293,2115015385&fm=26&gp=0.jpg";
    me.userName        = @"张三";
    me.userAccount     = @"18888888888";
    me.userRemarks     = @"恭喜发财";
    
    UserInfoModel *bo  = [[UserInfoModel alloc] init];
    bo.userIcon        = @"http://img4.imgtn.bdimg.com/it/u=1290022293,2115015385&fm=26&gp=0.jpg";
    bo.userName        = @"孙波";
    bo.userAccount     = @"11437126";
    bo.userRemarks     = @"恭喜发财";
    
    UserInfoModel *jf  = [[UserInfoModel alloc] init];
    jf.userIcon        = @"http://img4.imgtn.bdimg.com/it/u=1290022293,2115015385&fm=26&gp=0.jpg";
    jf.userName        = @"王五";
    jf.userAccount     = @"11437126";
    jf.userRemarks     = @"恭喜发财";
    
    UserInfoModel *qj  = [[UserInfoModel alloc] init];
    qj.userIcon        = @"http://img4.imgtn.bdimg.com/it/u=1290022293,2115015385&fm=26&gp=0.jpg";
    qj.userName        = @"李明";
    qj.userAccount     = @"11437126";
    qj.userRemarks     = @"恭喜发财";
    
    UserInfoModel *xm  = [[UserInfoModel alloc] init];
    xm.userIcon        = @"http://img4.imgtn.bdimg.com/it/u=1290022293,2115015385&fm=26&gp=0.jpg";
    xm.userName        = @"小明";
    xm.userAccount     = @"18817581720";
    xm.userRemarks     = @"恭喜发财";
    
    return @[me, bo, jf, qj, xm];
}

+ (UserInfoModel *)userInfoNamed:(NSString *)name {

    if (!name.length) {
        return nil;
    }
    
    for (UserInfoModel *info in [self userList]) {
        if ([info.userName isEqualToString:name]) {
            return info;
        }
    }
    
    return nil;
    
}

@end

