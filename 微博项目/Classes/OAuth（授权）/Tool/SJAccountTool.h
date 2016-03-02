//
//  SJAccountTool.h
//  微博项目
//
//  Created by joe on 15/10/14.
//  Copyright © 2015年 joe. All rights reserved.
// 管理一切与账号有关的操作：账号的存储，取出，验证

#import <Foundation/Foundation.h>
@class SJAccount;
@interface SJAccountTool : NSObject

// 存储账号信息
+ (void)saveAccount:(SJAccount *)account;

// 返回账号信息
+ (SJAccount *)account;
@end
