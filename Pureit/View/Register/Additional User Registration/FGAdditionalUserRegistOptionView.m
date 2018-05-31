//
//  FGAdditionalUserRegistOptionView.m
//  Pureit
//
//  Created by Ryan Gong on 16/5/12.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGAdditionalUserRegistOptionView.h"
#import "Global.h"
@interface FGAdditionalUserRegistOptionView()
{
    UILabel *lb_OR;
}
@end

@implementation FGAdditionalUserRegistOptionView
@synthesize view_bg;
@synthesize cb_mobile;
@synthesize cb_wecheat;
@synthesize vsl_OR;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [commond useDefaultRatioToScaleView:view_bg];
    [commond useDefaultRatioToScaleView:cb_mobile];
    [commond useDefaultRatioToScaleView:cb_wecheat];
    [commond useDefaultRatioToScaleView:vsl_OR];
    
    lb_OR = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_OR.textAlignment = NSTextAlignmentCenter;
    lb_OR.textColor = deepblue;
    lb_OR.text = multiLanguage(@"或者");
    lb_OR.font = font(FONT_NORMAL, 18);
    [lb_OR sizeToFit];
    lb_OR.userInteractionEnabled = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [cb_wecheat setFrame:cb_wecheat.frame title:multiLanguage(@"WECHAT") arrimg:nil
                         thumb:[UIImage imageNamed:@"icon-wechat.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20*ratioW font:font(FONT_BOLD, 22) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
    [cb_mobile setFrame:cb_mobile.frame title:multiLanguage(@"MOBILE") arrimg:nil
                   thumb:[UIImage imageNamed:@"icon-phone.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20*ratioW font:font(FONT_BOLD, 22) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
    [vsl_OR setupByMiddleView:lb_OR padding:30 lineHeight:1 lineColor:deepblue];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    lb_OR = nil;
}

@end
