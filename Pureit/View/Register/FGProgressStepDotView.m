//
//  FGProgressStepDotView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGProgressStepDotView.h"
#import "Global.h"
@implementation FGProgressStepDotView
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize lb1;
@synthesize lb2;
@synthesize lb3;
@synthesize view_line1;
@synthesize view_line2;
@synthesize view_bottomLine;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    lb1.font = font(FONT_BOLD, 14);
    lb2.font = font(FONT_BOLD, 14);
    lb3.font = font(FONT_BOLD, 14);
    
    lb1.text = multiLanguage(@"连接设备");
    lb2.text = multiLanguage(@"获得OTP");
    lb3.text = multiLanguage(@"个人信息");
    
    lb1.textColor = deepblue;
    lb2.textColor = deepblue;
    lb3.textColor = deepblue;
    
    [self clearAllHighlight];
    [self highlightedByIndex:0];
    
    [commond useDefaultRatioToScaleView:lb1];
    [commond useDefaultRatioToScaleView:lb2];
    [commond useDefaultRatioToScaleView:lb3];
    [commond useDefaultRatioToScaleView:btn1];
    [commond useDefaultRatioToScaleView:btn2];
    [commond useDefaultRatioToScaleView:btn3];
    [commond useDefaultRatioToScaleView:view_bottomLine];
    [commond useDefaultRatioToScaleView:view_line1];
    [commond useDefaultRatioToScaleView:view_line2];
    self.view_bottomLine.hidden = YES;
}

-(void)clearAllHighlight
{
    [btn1 setBackgroundImage:[UIImage imageNamed:@"no1a.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"no2a.png"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"no3a.png"] forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)highlightedByIndex:(NSInteger)_index
{
    [self clearAllHighlight];
    UIButton *selectedButton;
    NSString *str_filename = nil;
    switch (_index) {
        case 0:
            selectedButton = btn1;
            str_filename = @"no1.png";
            break;
            
        case 1:
            selectedButton = btn2;
            str_filename = @"no2.png";
            break;
            
        case 2:
            selectedButton = btn3;
            str_filename = @"no3.png";
            break;
    }
    
    [selectedButton setBackgroundImage:[UIImage imageNamed:str_filename] forState:UIControlStateNormal];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
