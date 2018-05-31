//
//  FGQAQuestionTableViewCell.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/21.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGQAQuestionTableViewCell.h"
#import "Global.h"
@implementation FGQAQuestionTableViewCell
@synthesize lb_question;
@synthesize iv_arr_down;
@synthesize view_separator;
- (void)awakeFromNib {
    // Initialization code
    [commond useDefaultRatioToScaleView:lb_question];
    [commond useDefaultRatioToScaleView:iv_arr_down];
    
    CGRect _newFrame = view_separator.frame;
    _newFrame.origin.x = view_separator.frame.origin.x * ratioW;
    _newFrame.origin.y = view_separator.frame.origin.y * ratioH;
    _newFrame.size.width = view_separator.frame.size.width * ratioW;
    view_separator.frame = _newFrame;
    
    lb_question.font = font(FONT_NORMAL, 18);
    lb_question.textColor = [UIColor blackColor];
    lb_question.textAlignment = NSTextAlignmentLeft;
    lb_question.numberOfLines = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat paddingLR = 15;
    CGRect _frame = lb_question.frame;
    _frame.size.width = self.frame.size.width - paddingLR * 4;
    lb_question.frame = _frame;
    [lb_question sizeToFit];
    [lb_question setLineSpace:8 alignment:NSTextAlignmentLeft];
    lb_question.center = CGPointMake(lb_question.center.x, self.frame.size.height / 2);
    iv_arr_down.center = CGPointMake(iv_arr_down.center.x, self.frame.size.height / 2);
}

-(void)openAnimation
{
    [UIView beginAnimations:nil context:nil];
    iv_arr_down.transform = CGAffineTransformMakeRotation(RADIANS(180) );
    [UIView commitAnimations];
}

-(void)closeAnimation
{
    [UIView beginAnimations:nil context:nil];
    iv_arr_down.transform = CGAffineTransformMakeRotation(RADIANS(0) );
    [UIView commitAnimations];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
