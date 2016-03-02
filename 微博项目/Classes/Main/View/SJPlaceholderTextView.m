//
//  SJPlaceholderTextView.m
//  微博项目
//
//  Created by joe on 15/11/20.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJPlaceholderTextView.h"

@implementation SJPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 要监听textView的输入，两种方法：
        // 1 代理
        // self.delegate = self; 不要设置自己的代理为自己
        // 2 通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


/**
 *  监听文字的改变
 */
- (void)textDidChange
{
    // 设置在恰当的时候重绘
    [self setNeedsDisplay]; 

    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    // 画上文字
//    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs]; 这种画法不会换行，所以要用下面的这种，给定一个rect，在这个区域内画 
    CGFloat x = 5;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat y = 8;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

@end
