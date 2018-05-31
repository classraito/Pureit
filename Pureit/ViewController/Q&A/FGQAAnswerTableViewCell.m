//
//  FGQAAnswerTableViewCell.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/21.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGQAAnswerTableViewCell.h"
#import "Global.h"
@implementation FGQAAnswerTableViewCell
@synthesize lb_answer;
@synthesize view_separator;
- (void)awakeFromNib {
    // Initialization code
    [commond useDefaultRatioToScaleView:lb_answer];
    
    CGRect _newFrame = view_separator.frame;
    _newFrame.origin.x = view_separator.frame.origin.x * ratioW;
    _newFrame.origin.y = view_separator.frame.origin.y * ratioH;
    _newFrame.size.width = view_separator.frame.size.width * ratioW;
    view_separator.frame = _newFrame;
    
    lb_answer.font = font(FONT_NORMAL, 18);
    lb_answer.textColor = [UIColor darkGrayColor];
    lb_answer.textAlignment = NSTextAlignmentLeft;
    lb_answer.numberOfLines = 0;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat paddingLR = 15;
    CGRect _frame = lb_answer.frame;
    _frame.size.width = self.frame.size.width - paddingLR * 4;
    lb_answer.frame = _frame;
    [lb_answer sizeToFit];
    lb_answer.center = CGPointMake(lb_answer.center.x, self.frame.size.height / 2);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
