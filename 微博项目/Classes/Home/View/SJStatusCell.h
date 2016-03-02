//
//  SJStatusCell.h
//  微博项目
//
//  Created by joe on 15/11/10.
//  Copyright © 2015年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SJStatusFrame;

@interface SJStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong)SJStatusFrame *statusFrame;

@end
