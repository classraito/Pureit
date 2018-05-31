//
//  FGAddinationalUserUpdateMobileView.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/24.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGAddinationalUserUpdateMobileView.h"
#import "Global.h"
@implementation FGAddinationalUserUpdateMobileView
@synthesize ctf_currentMobile;
@synthesize ctf_newMobile;
-(void)awakeFromNib
{
    [super awakeFromNib];
    ctf_currentMobile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_currentMobile.layer.borderWidth = .5;
    ctf_currentMobile.maxInputLength = 11;
    ctf_newMobile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_newMobile.layer.borderWidth = .5;
    ctf_newMobile.maxInputLength = 11;
    
    ctf_currentMobile.tf.placeholder = multiLanguage(@"Current Mobile Number*");
    ctf_newMobile.tf.placeholder = multiLanguage(@"New Mobile Number*");
    
    [commond useDefaultRatioToScaleView:ctf_currentMobile];
    [commond useDefaultRatioToScaleView:ctf_newMobile];
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
