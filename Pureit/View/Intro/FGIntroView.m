//
//  FGIntroView.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/3.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGIntroView.h"
#import "Global.h"
@interface FGIntroView()
{
    UILabel *lb_title;
}
@end

@implementation FGIntroView
@synthesize vsl_title;
@synthesize lb_description;
@synthesize iv;
-(void)awakeFromNib
{
    [super awakeFromNib];
    [commond useDefaultRatioToScaleView:vsl_title];
    [commond useDefaultRatioToScaleView:iv];
    [commond useDefaultRatioToScaleView:lb_description];
    
    lb_description.font = font(FONT_NORMAL, 18);
    lb_description.textColor = [UIColor darkGrayColor];
    
    lb_title = [[UILabel alloc] init];
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = [UIColor blackColor];
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = font(FONT_BOLD, 18);
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [vsl_title setupByMiddleView:lb_title padding:15 lineHeight:1 lineColor:[UIColor blackColor] limitedLineWidth:30];
}

-(void)setupVSLTitle:(NSString *)_str_title
{
    lb_title.text = _str_title;
    [lb_title sizeToFit];
    [self setNeedsLayout];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [lb_title removeFromSuperview];
    lb_title = nil;
}
@end
