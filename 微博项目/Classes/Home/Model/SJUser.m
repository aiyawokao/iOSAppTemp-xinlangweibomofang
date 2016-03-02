//
//  SJUser.m
//  微博项目
//
//  Created by joe on 15/10/16.
//  Copyright © 2015年 joe. All rights reserved.
//  用户模型

#import "SJUser.h"

@implementation SJUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}
//- (BOOL)isVip
//{
//    return self.mbrank > 2; 
//}
@end
