//
//  FGCustomTextFieldView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomTextFieldView.h"
#import "Global.h"
#include <UIKit/UIKit.h>
@interface FGCustomTextFieldView()
{
    UIImageView *iv_rightThumbnail;
    CGFloat padding;
    UIButton *btn_rightButton;
}
@end

@implementation FGCustomTextFieldView
@synthesize tf;
@synthesize delegate;
@synthesize maxInputLength;
@synthesize minInputLength;
-(void)awakeFromNib
{
    [super awakeFromNib];
    tf.font = font(FONT_NORMAL, 16);
    tf.delegate = self;
    tf.returnKeyType = UIReturnKeyDone;
    iv_rightThumbnail = [[UIImageView alloc] init];
    iv_rightThumbnail.hidden = YES;
    
    btn_rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_rightButton.hidden = YES;
    [btn_rightButton addTarget:self action:@selector(buttonAction_rightButton:) forControlEvents:UIControlEventTouchUpInside];
    btn_rightButton.backgroundColor = [UIColor clearColor];
    btn_rightButton.showsTouchWhenHighlighted = YES;
    
    [self addSubview:btn_rightButton];
    [self addSubview:iv_rightThumbnail];
}

-(void)buttonAction_rightButton:(id)_sender
{
    if(delegate && [delegate respondsToSelector:@selector(didClickRightButton:customTF:)])
    {
        [delegate didClickRightButton:_sender customTF:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(iv_rightThumbnail.image)
    {
        CGRect _frame = iv_rightThumbnail.frame;
        
        _frame.size.width = iv_rightThumbnail.image.size.width/3;
        _frame.size.height = iv_rightThumbnail.image.size.height / 3;
        _frame.origin.x = self.frame.size.width - padding - _frame.size.width;
        iv_rightThumbnail.frame = _frame;
        iv_rightThumbnail.center = CGPointMake(iv_rightThumbnail.center.x, self.frame.size.height / 2);
        btn_rightButton.frame = CGRectMake(0, 0,iv_rightThumbnail.frame.size.width * 2, self.frame.size.height);
        btn_rightButton.center = CGPointMake(iv_rightThumbnail.center.x, self.frame.size.height / 2);
    }
}

-(void)setRightThumbnail:(UIImage *)img padding:(CGFloat)_padding
{
    if(img)
    {
        iv_rightThumbnail.image = img;
        padding = _padding;
        iv_rightThumbnail.hidden = NO;
        btn_rightButton.hidden = NO;
        [self setNeedsLayout];
    }
    else
    {
        iv_rightThumbnail.hidden = YES;
        btn_rightButton.hidden = YES;
    }
}

-(void)setRightThumbnail:(UIImage *)img
{
    [self setRightThumbnail:img padding:10];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    btn_rightButton = nil;
    iv_rightThumbnail = nil;
}

-(void)setupByMaxInputLength:(NSInteger)_maxInputLength
{
    maxInputLength = _maxInputLength;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    /*这断代码指定所有textfield成为焦点时向上移动的高度,向上移动的方法是baseViewController中的moveUp方法*/
    CGRect convertedFrame = [self.superview convertRect:self.frame toView:nav_main.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
    if(heightNeedMoveWhenKeybaordShow > currentKeyboardHeight )
    {
        heightNeedMoveWhenKeybaordShow =  currentKeyboardHeight;
    }
    if(delegate && [(NSObject *)delegate respondsToSelector:@selector(didBeginEditing:)])
    {
        [delegate didBeginEditing:textField];
    }
    
    if(delegate && [(NSObject *)delegate respondsToSelector:@selector(didBeginEditing: customTF:)])
    {
        [delegate didBeginEditing:textField customTF:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL isLimited = NO;
    if(newLength >= maxInputLength)
    {
        isLimited = YES;
    }
    else
    {
        isLimited = NO;
    }
    if(delegate && [delegate respondsToSelector:@selector(customTextField:shouldChangeCharactersInRange:replacementString:isLimited:)])
    {
        [delegate customTextField:textField shouldChangeCharactersInRange:range replacementString:string isLimited:isLimited];
    }
    if(newLength > maxInputLength || newLength < minInputLength)
        return NO;
    
    
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if(delegate && [(NSObject *)delegate respondsToSelector:@selector(didClickDoneOnTextField:)])
    {
        [delegate didClickDoneOnTextField:textField];
    }
    [textField resignFirstResponder];
//    [appDelegate viewMoveDown];
    return YES;
}
@end
