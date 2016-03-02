//
//  SJEmotionPopView.h
//  微博项目
//
//  Created by joe on 15/11/27.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJEmotion;

@interface SJEmotionPopView : UIView

+ (instancetype)popView;

@property (nonatomic,strong)SJEmotion *emotion;

@end
