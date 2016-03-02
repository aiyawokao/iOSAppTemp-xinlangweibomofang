//
//  SJSearchBar.m
//  微博项目
//
//  Created by joe on 15/10/8.
//  Copyright © 2015年 joe. All rights reserved.
//

#import "SJSearchBar.h"

@implementation SJSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        // 设置左边放大镜图标
        UIImageView*searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc]init];
}
@end
