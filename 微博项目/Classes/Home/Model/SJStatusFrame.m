//
//  SJStatusFrame.m
//  微博项目
//
//  Created by joe on 15/11/11.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJStatusFrame.h"
#import "SJStatus.h"
#import "SJUser.h"
#import "NSString+Extension.h"
#import "SJStatusPhotosView.h"

@implementation SJStatusFrame

// 这个方法很不错 ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！

//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
//{
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = font;
//    CGSize maxSize = CGSizeMake(maxW,MAXFLOAT);
//    
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
//    
//}
//
//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
//{
//    return [self sizeWithText:text font:font maxW:MAXFLOAT];
//}

// 抽取 分类 NSString+Extension


- (void)setStatus:(SJStatus *)status
{
    _status = status;
    
    /* 原创微博设置frame */
    SJUser *user = status.user;
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 头像 */
    CGFloat iconWH = 50;
    CGFloat iconX = SJStatusCellBorderW;
    CGFloat iconY = SJStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /* 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + SJStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:SJStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};// 新写法！！！！！！！！
    
    /* 会员图标 */
    if (status.user.isVip){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + SJStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    /* 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + SJStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:SJStatusCellNameFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /* 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + SJStatusCellBorderW;
    CGFloat sourceY =  timeY;
    CGSize sourceSize = [status.source sizeWithFont:SJStatusCellSourceFont];
    self.sourceLabelF  = (CGRect){{sourceX,sourceY},sourceSize};

    /* 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY =  MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + SJStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:SJStatusCellContentFont maxW:maxW];
    self.contentLabelF  = (CGRect){{contentX,contentY},contentSize};
    
    /* 配图 */
    CGFloat originalH = 0;
    
    if (status.pic_urls.count) {// 有配图

        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + SJStatusCellBorderW;
        CGSize photosSize = [SJStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX, photosY},photosSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + SJStatusCellBorderW;
        
    }else {// 无配图
        originalH = CGRectGetMaxY(self.contentLabelF) + SJStatusCellBorderW;
    }
    
    /* 原创微博整体view */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /* 被转发微博设置frame */
    CGFloat toolbarY = 0;
    if (status.retweeted_status){
        
        SJStatus *retweeted_status = status.retweeted_status;
        SJUser *retweeted_status_user = status.retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = SJStatusCellBorderW;
        CGFloat retweetContentY = SJStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        CGSize retweetContentSize = [retweetContent sizeWithFont:SJStatusCellRetweetContentFont maxW:maxW];
        
        
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY},retweetContentSize};
        
        
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls){// 转发微博有配图

            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + SJStatusCellBorderW;
            CGSize retweetPhotosSize = [SJStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX, retweetPhotosY},retweetPhotosSize}
            ;

            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + SJStatusCellBorderW;
            
        } else {// 转发微博无配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + SJStatusCellBorderW;
        }
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 底部工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF) + SJStatusCellMargin;
    
    
}

@end
