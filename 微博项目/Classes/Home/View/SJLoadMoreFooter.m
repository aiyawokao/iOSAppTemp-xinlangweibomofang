//
//  SJLoadMoreFooter.m
//  微博项目
//
//  Created by joe on 15/10/16.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJLoadMoreFooter.h"

@implementation SJLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SJLoadMoreFooter" owner:nil options:nil]lastObject];
    
}

@end
