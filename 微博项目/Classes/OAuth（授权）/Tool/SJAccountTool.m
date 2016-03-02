//
//  SJAccountTool.m
//  微博项目
//
//  Created by joe on 15/10/14.
//  Copyright © 2015年 joe. All rights reserved.
//

#define SJAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "SJAccountTool.h"
#import "SJAccount.h"

@implementation SJAccountTool

+ (void)saveAccount:(SJAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:SJAccountPath];
    
}

+ (SJAccount *)account
{
    // 加载模型
    SJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SJAccountPath];
    /* 验证账号是否过期 */
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期的时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    // 获得当前的时间
    NSDate *now = [NSDate date];
    // 比较过期时间跟当前时间
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {// 过期
        return nil;
    }
    return account;
    
}
@end
