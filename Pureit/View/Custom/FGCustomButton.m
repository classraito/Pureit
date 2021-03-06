//
//  FGCustomButton.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomButton.h"
#import "Global.h"
@interface FGCustomButton()
{
    BOOL needTitleLeftAlighment;
    BOOL needIconBesideLabel;
}
@end

@implementation FGCustomButton
@synthesize iv_arr;
@synthesize lb_title;
@synthesize button;
@synthesize iv_thumbnail;
-(void)awakeFromNib
{
    [super awakeFromNib];
    lb_title.font = font(FONT_BOLD, 20);
    padding = 10;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
     CGRect _frame;
    
    lb_title.frame = self.bounds;
    lb_title.center = CGPointMake(self.frame.size.width / 2,self.frame.size.height / 2);
    
    if(needTitleLeftAlighment || !needIconBesideLabel)
    {
        if(iv_arr.image)
        {
            _frame = iv_arr.frame;
            _frame.size.width = iv_arr.image.size.width / 3;
            _frame.size.height = iv_arr.image.size.height / 3;
            _frame.origin.x = self.frame.size.width - _frame.size.width - padding;
            iv_arr.frame = _frame;
            iv_arr.center = CGPointMake(iv_arr.center.x, self.frame.size.height / 2);
        }
    }
    
    if(needIconBesideLabel)
    {
        [lb_title sizeToFit];
        lb_title.center = CGPointMake(self.frame.size.width / 2,self.frame.size.height / 2);
        if(iv_arr.image)
        {
            _frame = iv_arr.frame;
            _frame.size.width = iv_arr.image.size.width / 3;
            _frame.size.height = iv_arr.image.size.height / 3;
            _frame.origin.x = lb_title.frame.origin.x + lb_title.frame.size.width + padding;
            iv_arr.frame = _frame;
            iv_arr.center = CGPointMake(iv_arr.center.x, self.frame.size.height / 2);
            NSLog(@"iv_arr.frame = %@",NSStringFromCGRect(iv_arr.frame));
        }
        
        if(iv_thumbnail.image)
        {
            _frame = iv_thumbnail.frame;
            _frame.size.width = iv_thumbnail.image.size.width / 3;
            _frame.size.height = iv_thumbnail.image.size.height / 3;
            _frame.origin.x = lb_title.frame.origin.x - iv_thumbnail.frame.size.width - padding;
            iv_thumbnail.frame = _frame;
            iv_thumbnail.center = CGPointMake(iv_thumbnail.center.x, self.frame.size.height / 2);
            NSLog(@"iv_thumbnail.frame = %@",NSStringFromCGRect(iv_thumbnail.frame));
        }
    }
    else
    {
        if(iv_thumbnail.image)
        {
            _frame = iv_thumbnail.frame;
            _frame.size.width = iv_thumbnail.image.size.width / 3;
            _frame.size.height = iv_thumbnail.image.size.height / 3;
            _frame.origin.x = padding;
            iv_thumbnail.frame = _frame;
            iv_thumbnail.center = CGPointMake(iv_thumbnail.center.x, self.frame.size.height / 2);
        }
    }
    
   
    if(needTitleLeftAlighment)
    {
        //======调整自定义按钮显示==========
        lb_title.textAlignment = NSTextAlignmentLeft;
        lb_title.textAlignment = NSTextAlignmentLeft;
        CGRect _frame = lb_title.frame;
        _frame.origin.x = 20;
        lb_title.frame = _frame;
        
        _frame = lb_title.frame;
        _frame.origin.x = 20;
        lb_title.frame = _frame;
    }
    
    button.frame = self.bounds;
    button.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

/*设置自定义按钮*/
-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img thumb:(UIImage *)_thumb borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor padding:(CGFloat)_padding font:(UIFont *)_font needTitleLeftAligment:(BOOL)_needTitleLeftAligment needIconBesideLabel:(BOOL)_needIconBesideLabel
{
    self.frame = frame;
    lb_title.text = _str_title;
    lb_title.textColor = _textColor;
    if(_font)
        lb_title.font = _font;
    iv_arr.image = _img;
    
    iv_thumbnail.image = _thumb;
    padding = _padding;
    needTitleLeftAlighment = _needTitleLeftAligment;
    needIconBesideLabel = _needIconBesideLabel;
    self.backgroundColor = _bgColor;
    if(_borderColor)
    {
        self.layer.borderWidth = 1;
        self.layer.borderColor = _borderColor.CGColor;
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
    }
    [self setNeedsDisplay];
    
}

-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img thumb:(UIImage *)_thumb borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor padding:(CGFloat)_padding  needTitleLeftAligment:(BOOL)_needTitleLeftAligment needIconBesideLabel:(BOOL)_needIconBesideLabel;
{
    [self setFrame:frame title:_str_title arrimg:_img thumb:_thumb borderColor:_borderColor textColor:_textColor bgColor:_bgColor padding:_padding font:nil needTitleLeftAligment:_needTitleLeftAligment needIconBesideLabel:_needIconBesideLabel];
}

-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor
{
    [self setFrame:frame title:_str_title arrimg:_img thumb:nil borderColor:_borderColor textColor:_textColor bgColor:_bgColor padding:10 needTitleLeftAligment:NO needIconBesideLabel:NO];
}

-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor  needTitleLeftAligment:(BOOL)_needTitleLeftAligment
{
    [self setFrame:frame title:_str_title arrimg:_img thumb:nil borderColor:_borderColor textColor:_textColor bgColor:_bgColor padding:10 needTitleLeftAligment:_needTitleLeftAligment needIconBesideLabel:NO];
}

-(void)dealloc
{
    lb_title = nil;
    iv_arr = nil;
    button = nil;
    iv_thumbnail = nil;
    self.view_content = nil;
    NSLog(@"::::>dealloc %s %d",__FUNCTION__,__LINE__);
    
}

@end
