//
//  SJdropdownMenu.h
//  微博项目
//
//  Created by joe on 15/10/9.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SJdropdownMenu;
@protocol SJDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(SJdropdownMenu *)menu;
- (void)dropdownMenuDidShow:(SJdropdownMenu *)menu;
@end


@interface SJdropdownMenu : UIView

@property (nonatomic,weak) id <SJDropdownMenuDelegate> delegate;

+ (instancetype)menu;

- (void)showFrom:(UIView *)from;
- (void)dismiss;

@property (nonatomic,strong)UIView *content;
@property (nonatomic,strong)UIViewController *contentController;

@end
