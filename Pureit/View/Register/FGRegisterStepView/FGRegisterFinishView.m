//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterFinishView.h"
#import "Global.h"

@interface FGRegisterFinishView()
{
    UIImageView *iv_separator;
}
@end

@implementation FGRegisterFinishView
@synthesize cb_done;
@synthesize lb_title;
@synthesize lb_description;
@synthesize vsl_sepator;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    lb_title.font = font(FONT_BOLD, 25);
    lb_title.textColor = deepblue;
    lb_title.text = multiLanguage(@"恭喜你!");
    lb_description.font = font(FONT_BOLD, 24);
    lb_description.text = multiLanguage(@"我们非常高兴你得到纯净的第一滴水");
    lb_description.textColor = deepblue;
    [lb_description setLineSpace:8 alignment:NSTextAlignmentCenter];
    
    iv_separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"water.png"]];
    CGRect _frame = iv_separator.frame;
    _frame.size.width = iv_separator.image.size.width / 3;
    _frame.size.height = iv_separator.image.size.height / 3;
    iv_separator.frame = _frame;
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [vsl_sepator setupByMiddleView:iv_separator padding:40 lineHeight:1 lineColor:deepblue];
    [cb_done setFrame:cb_done.frame title:multiLanguage(@"START ENJOYING THE BENEFITS") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:10 font:font(FONT_BOLD, 18) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
