//
//  UIBarButtonItem+Extension.h
//  微博项目
//
//  Created by joe on 15/10/8.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
@end
