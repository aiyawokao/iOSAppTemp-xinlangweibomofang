//
//  SJEmotion.h
//  微博项目
//
//  Created by joe on 15/11/26.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic,copy)NSString *chs;
/** 表情的png图片名 */
@property (nonatomic,copy)NSString *png;
/** emiji的16进制编码 */
@property (nonatomic,copy)NSString *code;


@end
