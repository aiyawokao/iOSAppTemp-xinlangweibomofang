//
//  SJUser.h
//  微博项目
//
//  Created by joe on 15/10/16.
//  Copyright © 2015年 joe. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    SJUserVerifiedTypeNone = -1, // 没有任何认证
    
    SJUserVerifiedPersonal = 0,  // 个人认证
    
    SJUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    SJUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    SJUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    SJUserVerifiedDaren = 220 // 微博达人
    
} SJUserVerifiedType;

@interface SJUser : NSObject

/** idstr 	string 	字符串型的用户UID */
@property (nonatomic,copy) NSString *idstr;
/** name 	string 	友好显示名称 */
@property (nonatomic,copy) NSString *name;
/** profile_image_url 	string 	用户头像地址（中图），50×50像素 */
@property (nonatomic,copy) NSString *profile_image_url;
/** 会员类型  值 > 2，才代表是会员  */
@property (nonatomic,assign) int mbtype;
/** 会员等级 */
@property (nonatomic,assign) int mbrank;
@property (nonatomic,assign,getter = isVip) BOOL vip;

/** 认证类型（显示在头像右下角）*/
@property (nonatomic,assign) SJUserVerifiedType verified_type;

@end
