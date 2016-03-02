//
//  SJEmotionTextView.m
//  微博项目
//
//  Created by joe on 15/11/27.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionTextView.h"
#import "SJEmotion.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"

@implementation SJEmotionTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)insertEmotion:(SJEmotion *)emotion
 {
    if (emotion.code) {
        // insertText :将文字插入到光标所在的位置 ！！！！！！！！！！！！！！！！！
        [self insertText:emotion.code.emoji];
    } else if (emotion.png) {
        
        // 加载图片
        NSTextAttachment *attach = [[NSTextAttachment alloc]init];
        attach.image = [UIImage imageNamed:emotion.png];
        CGFloat attachWH = self.font.lineHeight;
        attach.bounds = CGRectMake(0, -4, attachWH, attachWH);
        
        // 根据附件创建一个 属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach]; 
        
        // 插入属性文字到光标位置
        [self insertAttributedText:imageStr];
        
        // 设置字体
        NSMutableAttributedString * text = (NSMutableAttributedString *)self.attributedText;
        [text addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
        
    }
}

/**
 selectedRange :
 1.本来是用来控制textView的文字选中范围
 2.如果selectedRange.length为0，selectedRange.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字（text），文字大小由textView.font控制
 2.如果是属性文字（attributedText），文字大小不受textView.font控制，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/


@end
