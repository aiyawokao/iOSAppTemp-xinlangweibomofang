//
//  SJAccount.m
//  微博项目
//
//  Created by joe on 15/10/14.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJAccount.h"

@implementation SJAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SJAccount *account = [[self alloc]init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    
    // 获得账号存储的时间（accessToken 产生的时间）
    account.created_time = [NSDate date];
    
    return account;
}

/**
 * 当一个对象要归档进沙盒时，就会调用这个方法  也要先遵守 <NSCoding> 协议！！！！！！！！！！！！！！！！！！
 * 目的：在此方法中说明这个对象的那些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

/**
 * 当从沙盒中解档一个对象时，就会调用这个方法  ！！！！！！！！！！！！！！！！！！
 * 目的：在此方法中说明沙盒中的属性该怎么解析（需要取出那些属性）
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
         

    }
    return self;
}


@end
