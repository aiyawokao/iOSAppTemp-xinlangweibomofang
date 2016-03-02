//
//  SJEmotionPopView.m
//  微博项目
//
//  Created by joe on 15/11/27.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJEmotionPopView.h"
#import "SJEmotion.h"
#import "SJEmotionButton.h"

@interface SJEmotionPopView()
@property (weak, nonatomic) IBOutlet SJEmotionButton *emotionButton;


@end
@implementation SJEmotionPopView

+(instancetype)popView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SJEmotionPopView" owner:nil options:nil]lastObject];
}

- (void)setEmotion:(SJEmotion *)emotion
{
    _emotion = emotion;
    self.emotionButton.emotion = emotion;
    
}

@end
