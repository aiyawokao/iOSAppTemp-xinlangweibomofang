//
//  SJEmotionButton.m
//  微博项目
//
//  Created by joe on 15/11/27.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionButton.h"
#import "SJEmotion.h"
#import "NSString+Emoji.h"


@implementation SJEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:32];
    }
    return self;
}

- (void)setEmotion:(SJEmotion *)emotion
{
    _emotion= emotion;
    if (emotion.png) { // 有图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) {// 是Emoji
        // 设置emoji
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }

}

@end
