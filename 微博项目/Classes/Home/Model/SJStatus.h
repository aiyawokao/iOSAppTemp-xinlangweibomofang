//
//  SJStatus.h
//  微博项目
//
//  Created by joe on 15/10/16.
//  Copyright © 2015年 joe. All rights reserved.
//  微博模型

#import <Foundation/Foundation.h>
@class SJUser;

@interface SJStatus : NSObject
/** idstr 	string 	字符串型的微博ID */
@property (nonatomic,copy) NSString *idstr;
/** text 	string 	微博信息内容 */
@property (nonatomic,copy) NSString *text;
/** text 	string 	微博信息内容  带有属性（特殊文字高亮、表情）  */
@property (nonatomic,weak) NSAttributedString *attributedText;
/** user 	object 	微博作者的用户信息字段 详细 */
@property (nonatomic,strong) SJUser *user;
/** string 微博创建时间  */
@property (nonatomic,copy) NSString *created_at;
/** string 微博来源 */
@property (nonatomic,copy) NSString *source;

/** 微博配图地址。 多配图时返回多图链接，无配图返回“[]” */
@property (nonatomic,strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic,strong) SJStatus *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
