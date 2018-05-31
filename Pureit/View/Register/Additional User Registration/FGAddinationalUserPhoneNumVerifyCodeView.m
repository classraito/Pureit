//
//  FGAddinationalUserPhoneNumVerifyCodeView.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/24.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGAddinationalUserPhoneNumVerifyCodeView.h"
#import "Global.h"
@implementation FGAddinationalUserPhoneNumVerifyCodeView
@synthesize ctf_name;
-(void)awakeFromNib
{
    [super awakeFromNib];
    ctf_name.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_name.layer.borderWidth = .5;
    ctf_name.maxInputLength = 50;
    self.ctf_mobile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ctf_mobile.layer.borderWidth = .5;
    ctf_name.tf.placeholder = multiLanguage(@"Name");
    
    [commond useDefaultRatioToScaleView:ctf_name];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@"::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
