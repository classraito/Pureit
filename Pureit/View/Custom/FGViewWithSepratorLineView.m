//
//  FGViewWithSepratorLineView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGViewWithSepratorLineView.h"
#import "Global.h"
@implementation FGViewWithSepratorLineView
@synthesize view_leftSepratorLine;
@synthesize view_rightSepratorLine;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.view_content.backgroundColor = [UIColor clearColor];
}

/*分割线根据中间显示的view的宽度动态变化*/
-(void)setupByMiddleView:(UIView *)_view padding:(CGFloat )_padding lineHeight:(CGFloat)_lineHeight lineColor:(UIColor *)_lineColor
{
    if(!_view)
        return;
    if(![self.subviews containsObject:_view])
    {
          [self addSubview:_view];
    }
    
    
    CGRect _frame;
    _frame = view_leftSepratorLine.frame;
    _frame.size.width = (self.frame.size.width - _padding * 2 - _view.frame.size.width) / 2;
    _frame.size.height = _lineHeight;
    _frame.origin.x = 0;
    view_leftSepratorLine.frame = _frame;
    view_leftSepratorLine.center = CGPointMake(view_leftSepratorLine.center.x,self.frame.size.height / 2);
    
    
    _frame = _view.frame;
    _frame.origin.x = view_leftSepratorLine.frame.origin.x + view_leftSepratorLine.frame.size.width + _padding;
    _view.frame = _frame;
    _view.center = CGPointMake(_view.center.x, self.frame.size.height / 2);
    
    _frame = view_rightSepratorLine.frame;
    _frame.origin.x = _view.frame.origin.x + _view.frame.size.width + _padding;
    _frame.size.width = view_leftSepratorLine.frame.size.width;
    _frame.size.height = _lineHeight;
    view_rightSepratorLine.frame = _frame;
    view_rightSepratorLine.center = CGPointMake(view_rightSepratorLine.center.x, self.frame.size.height / 2);
    if(_lineColor)
    {
        view_rightSepratorLine.backgroundColor = _lineColor;
        view_leftSepratorLine.backgroundColor  = _lineColor;
    }
}

/*分割线长度固定*/
-(void)setupByMiddleView:(UIView *)_view padding:(CGFloat)_padding lineHeight:(CGFloat)_lineHeight lineColor:(UIColor *)_lineColor limitedLineWidth:(CGFloat)_limitedLineWidth
{
    if(!_view)
        return;
    if(![self.subviews containsObject:_view])
    {
        [self addSubview:_view];
    }
    
    _view.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGRect _frame;
    _frame = view_leftSepratorLine.frame;
    _frame.size.width = _limitedLineWidth;
    _frame.size.height = _lineHeight;
    _frame.origin.x = _view.frame.origin.x - _padding - _frame.size.width;
    view_leftSepratorLine.frame = _frame;
    view_leftSepratorLine.center = CGPointMake(view_leftSepratorLine.center.x,self.frame.size.height / 2);
    
    _frame = view_rightSepratorLine.frame;
    _frame.origin.x = _view.frame.origin.x + _view.frame.size.width + _padding;
    _frame.size.width = _limitedLineWidth;
    _frame.size.height = _lineHeight;
    view_rightSepratorLine.frame = _frame;
    view_rightSepratorLine.center = CGPointMake(view_rightSepratorLine.center.x, self.frame.size.height / 2);
    
    if(_lineColor)
    {
        view_rightSepratorLine.backgroundColor = _lineColor;
        view_leftSepratorLine.backgroundColor  = _lineColor;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
