//
//  FGDataBannerView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/11.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDataBannerView.h"
#import "HSCButton.h"
#import "Global.h"
@implementation FGDataBannerView
@synthesize iv_banner;
@synthesize iv_stick;
@synthesize lb_date;
@synthesize lb_value_left;
@synthesize lb_value_right;
@synthesize view_banner;

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    view_banner.backgroundColor = [UIColor clearColor];
    [commond useDefaultRatioToScaleView:iv_banner];
    [commond useDefaultRatioToScaleView:iv_stick];
    [commond useDefaultRatioToScaleView:lb_date];
    [commond useDefaultRatioToScaleView:lb_value_left];
    [commond useDefaultRatioToScaleView:lb_value_right];
    [commond useDefaultRatioToScaleView:view_banner];
    lb_value_left.font = font(FONT_NORMAL, 14);
    lb_value_right.font = font(FONT_NORMAL, 14);
    lb_date.font = font(FONT_NORMAL, 15);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

@end
