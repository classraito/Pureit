//
//  FGRegisterQRCodeScanView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/22.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGRegisterQRCodeScanView.h"
#import "Global.h"
@interface FGRegisterQRCodeScanView()
{
    UILabel *lb_OR;
}
@end

@implementation FGRegisterQRCodeScanView
@synthesize iv_phone;
@synthesize vsl_separator;
@synthesize ctf_deviceID;
@synthesize view_bottomLine;
@synthesize cb_scanQR;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    
    lb_OR = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_OR.textAlignment = NSTextAlignmentCenter;
    lb_OR.textColor = deepblue;
    lb_OR.text = multiLanguage(@"或者");
    lb_OR.font = font(FONT_NORMAL, 18);
    [lb_OR sizeToFit];
    lb_OR.userInteractionEnabled = YES;

    ctf_deviceID.maxInputLength = 10;
    ctf_deviceID.tf.placeholder = multiLanguage(@"输入设备ID *");
    ctf_deviceID.tf.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    [commond useDefaultRatioToScaleView:cb_scanQR];
    [commond useDefaultRatioToScaleView:vsl_separator];
    [commond useDefaultRatioToScaleView:iv_phone];
    [commond useDefaultRatioToScaleView:ctf_deviceID];
    [commond useDefaultRatioToScaleView:view_bottomLine];
    
    view_bottomLine.hidden = YES;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [vsl_separator setupByMiddleView:lb_OR padding:30 lineHeight:1 lineColor:deepblue];
    vsl_separator.view_rightSepratorLine.hidden = YES;
    vsl_separator.view_leftSepratorLine.hidden = YES;
    [cb_scanQR setFrame:cb_scanQR.frame title:multiLanguage(@"扫描Pureit设备上的条形码") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    ctf_deviceID.tf.font = font(FONT_BOLD, 20);
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [ctf_deviceID removeFromSuperview];
    ctf_deviceID.delegate = nil;
}

@end
