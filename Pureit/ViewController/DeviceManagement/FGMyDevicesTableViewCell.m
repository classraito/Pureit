//
//  FGMyDevicesTableViewCell.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/2.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGMyDevicesTableViewCell.h"
#import "Global.h"
@implementation FGMyDevicesTableViewCell
@synthesize view_deviceBG;
@synthesize lb_key_deviceId;
@synthesize lb_value_deviceId;
@synthesize view_separatorLine;
@synthesize lb_key_reset;
@synthesize lb_key_delete;
@synthesize iv_resetIcon;
@synthesize iv_deleteIcon;
@synthesize iv_setDefault;
@synthesize lb_setDefault;
@synthesize btn_setDefault;
@synthesize btn_reset;
@synthesize btn_delete;
@synthesize iv_thumbnail;
@synthesize lb_deviceName;
- (void)awakeFromNib {
    [commond useDefaultRatioToScaleView:view_deviceBG];
    [commond useDefaultRatioToScaleView:lb_key_deviceId];
    [commond useDefaultRatioToScaleView:lb_value_deviceId];
    [commond useDefaultRatioToScaleView:view_separatorLine];
    [commond useDefaultRatioToScaleView:lb_key_reset];
    [commond useDefaultRatioToScaleView:lb_key_delete];
    [commond useDefaultRatioToScaleView:iv_resetIcon];
    [commond useDefaultRatioToScaleView:iv_deleteIcon];
    [commond useDefaultRatioToScaleView:btn_reset];
    [commond useDefaultRatioToScaleView:btn_delete];
    [commond useDefaultRatioToScaleView:iv_setDefault];
    [commond useDefaultRatioToScaleView:lb_setDefault];
    [commond useDefaultRatioToScaleView:btn_setDefault];
    [commond useDefaultRatioToScaleView:lb_deviceName];
    [commond useDefaultRatioToScaleView:iv_thumbnail];
    
    
    lb_key_deviceId.font = font(FONT_NORMAL, 14);
    lb_value_deviceId.font = font(FONT_NORMAL, 14);
    lb_value_deviceId.textAlignment = NSTextAlignmentLeft;
    lb_deviceName.font = font(FONT_BOLD, 16);
    lb_key_reset.font = font(FONT_NORMAL, 14);
    lb_key_delete.font = font(FONT_NORMAL, 14);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
