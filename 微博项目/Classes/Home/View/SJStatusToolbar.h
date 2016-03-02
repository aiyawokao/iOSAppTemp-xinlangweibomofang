//
//  SJStatusToolbar.h
//  微博项目
//
//  Created by joe on 15/11/13.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJStatus;

@interface SJStatusToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic,strong) SJStatus *status;

@end