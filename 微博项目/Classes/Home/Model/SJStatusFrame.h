//
//  SJStatusFrame.h
//  微博项目
//
//  Created by joe on 15/11/11.
//  Copyright © 2015年 joe. All rights reserved.
//  一个SJStatusFrame模型里面所包含的信息有：
//  1、存放着一个cell中所有子控件的frame数据
//  2、存放着一个cell的高度
//  3、存放着一个数据模型SJStatus

#import <Foundation/Foundation.h>
// 昵称字体
#define SJStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define SJStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define SJStatusCellSourceFont SJStatusCellTimeFont
// 正文字体
#define SJStatusCellContentFont [UIFont systemFontOfSize:15]
// 被转发微博正文字体
#define SJStatusCellRetweetContentFont [UIFont systemFontOfSize:12]
// cell之间的间距
#define SJStatusCellMargin 15
// cell的边框宽度
#define SJStatusCellBorderW 10

@class SJStatus;

@interface SJStatusFrame : NSObject
@property (nonatomic,strong)SJStatus *status;
/* 原创微博整体view */
@property (nonatomic,assign) CGRect originalViewF;
/* 头像 */
@property (nonatomic,assign) CGRect iconViewF;
/* 会员图标 */
@property (nonatomic,assign) CGRect vipViewF;
/* 配图 */
@property (nonatomic,assign) CGRect photosViewF;
/* 昵称 */
@property (nonatomic,assign) CGRect nameLabelF;
/* 时间 */
@property (nonatomic,assign) CGRect timeLabelF;
/* 来源 */
@property (nonatomic,assign) CGRect sourceLabelF;
/* 正文 */
@property (nonatomic,assign) CGRect contentLabelF;

/* 转发微博 */
/* 转发微博整体view */
@property (nonatomic,assign) CGRect retweetViewF;
/* 转发微博正文 + 昵称 */
@property (nonatomic,assign) CGRect retweetContentLabelF;
/* 转发微博配图 */
@property (nonatomic,assign) CGRect retweetPhotosViewF;

/* 底部工具条 */
@property (nonatomic,assign) CGRect toolbarF;


/* cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
