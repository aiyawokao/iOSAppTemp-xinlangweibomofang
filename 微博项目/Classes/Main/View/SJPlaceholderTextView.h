//
//  SJPlaceholderTextView.h
//  微博项目
//
//  Created by joe on 15/11/20.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;

@end
