//
//  FGOrderHistroyTableViewCell.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGOrderHistroyTableViewCell.h"
#import "Global.h"
@implementation FGOrderHistroyTableViewCell
@synthesize iv_thumbnail;
@synthesize view_separator;
@synthesize lb_gkk_name;
@synthesize lb_gkk_ordertime;
- (void)awakeFromNib {
    // Initialization code
    [commond useDefaultRatioToScaleView:iv_thumbnail];
    [commond useDefaultRatioToScaleView:view_separator];
    [commond useDefaultRatioToScaleView:lb_gkk_name];
    [commond useDefaultRatioToScaleView:lb_gkk_ordertime];
    lb_gkk_name.font = font(FONT_BOLD, 20);
    lb_gkk_ordertime.font = font(FONT_NORMAL, 14);
}



-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
