//
//  FGUpdateProfileVIew.m
//  Pureit
//
//  Created by Ryan Gong on 16/8/4.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGUpdateProfileVIew.h"
#import "Global.h"
@implementation FGUpdateProfileVIew
@synthesize ctf_customID;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    ctf_customID.tf.placeholder = multiLanguage(@"客户ID");
    [commond useDefaultRatioToScaleView:ctf_customID];
    ctf_customID.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_customID.layer.borderWidth = .5;
    
}

-(void)buttonAction_familyMember:(id)_sender
{
    [super buttonAction_familyMember:_sender];
    [ctf_customID.tf resignFirstResponder];
}

-(void)buttonAction_province:(id)_sender
{
    [super buttonAction_province:_sender];
    [ctf_customID.tf resignFirstResponder];
}

-(void)buttonAction_deviceType:(id)_sender
{
    [super buttonAction_deviceType:_sender];
    [ctf_customID.tf resignFirstResponder];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
