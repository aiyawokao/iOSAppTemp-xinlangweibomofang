//
//  UITextView+Extension.m
//  微博项目
//
//  Created by joe on 15/11/27.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

-(void)insertAttributedText:(NSAttributedString *)text
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];

    // 拼接之前已经输入的字符（包括文字和图片）
    [attributedText appendAttributedString:self.attributedText];

    // 把传入的text插到光标的位置 loc
    NSUInteger loc = self.selectedRange.location;
    [attributedText insertAttributedString:text atIndex:loc];

    self.attributedText = attributedText;
    
    // 在文字中间插入表情后光标会自动挪到最后面，所以要把光标再挪到表情后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
    
}


@end
