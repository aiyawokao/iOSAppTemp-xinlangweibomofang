//
//  SJComposeToolBar.h
//  微博项目
//
//  Created by joe on 15/11/23.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum SJComposeToolBarButtonType:NSUInteger{
    SJComposeToolBarButtonTypeCamera,// 拍照
    SJComposeToolBarButtonTypePicture,// 相册
    SJComposeToolBarButtonTypeMention,// @
    SJComposeToolBarButtonTypeTrend,// #
    SJComposeToolBarButtonTypeEmotion// 表情
    
}SJComposeToolBarButtonType;

@class SJComposeToolBar;
@protocol SJComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(SJComposeToolBar *)toolbar didClickButton:(SJComposeToolBarButtonType)buttonType;


@end
@interface SJComposeToolBar : UIView

@property (nonatomic,weak) id <SJComposeToolBarDelegate> delegate;
/** 是否显示键盘图标 */
@property (nonatomic,assign) BOOL showKeyboardButton;

@end
