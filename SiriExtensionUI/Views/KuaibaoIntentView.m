//
//  KuaibaoIntentView.m
//  SiriExtensionUI
//
//  Created by tingdongli on 2018/8/31.
//  Copyright © 2018年 haofree. All rights reserved.
//

#import "KuaibaoIntentView.h"

@interface KuaibaoIntentView()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation KuaibaoIntentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
