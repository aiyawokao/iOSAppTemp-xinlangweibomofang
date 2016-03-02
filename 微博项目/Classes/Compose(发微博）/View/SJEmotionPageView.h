//
//  SJEmotionPageView.h
//  微博项目
//
//  Created by joe on 15/11/26.
//  Copyright © 2015年 joe. All rights reserved.
//  用来表示一页的表情（1~20）

#import <UIKit/UIKit.h>

// 每页表情个数
#define SJEmotionPageSize ((SJEmotionMaxCols * SJEmotionMaxRows) - 1)
// 每页最多7列
#define SJEmotionMaxCols 7
// 每页最多3行
#define SJEmotionMaxRows 3

@interface SJEmotionPageView : UIView
/** 这一页显示的表情（里面存放的是 SJEmotion模型） */
@property (nonatomic,strong) NSArray *emotions;

@end
