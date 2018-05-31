//
//  FGPureitClubViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/24.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGPureitClubViewController.h"
#import "Global.h"
#import "commond.h"
#import "FGIntroView.h"
@interface FGPureitClubViewController ()

@end

@implementation FGPureitClubViewController
@synthesize lb_tips;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Do any additional setup after loading the view from its nib.
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.str_title = multiLanguage(@"Club Pureit!");
    self.view_topPanel.lb_title.font = font(FONT_BOLD, 24);
    [self.cb_skip removeFromSuperview];
    self.cb_skip = nil;
    [self.iv_arr_left removeFromSuperview];
    self.iv_arr_left = nil;
    [self.iv_arr_right removeFromSuperview];
    self.iv_arr_right = nil;
    
    lb_tips.font = font(FONT_BOLD, 22);
    lb_tips.text = multiLanguage(@"Coming soon...");
    
    [commond useDefaultRatioToScaleView:lb_tips];
}


-(void)internalInitalDatas
{
    arr_titles = [[NSMutableArray alloc] initWithObjects:multiLanguage(@"EARN & REDEEM POINTS"), nil];
    arr_descriptions = [[NSMutableArray alloc] initWithObjects:multiLanguage(@"Be a part of the elite Club\nPureit and earn points\nwhich you can redeem for\n some amaazing offers."),nil];
}

-(void)internalInitalIntros
{
    FGIntroView *view_intro = (FGIntroView *)[[[NSBundle mainBundle] loadNibNamed:@"FGIntroView" owner:nil options:nil] objectAtIndex:0];
    view_intro.backgroundColor = [UIColor clearColor];
    view_intro.iv.image = [UIImage imageNamed:@"intro4.png"];
    view_intro.lb_description.text = [arr_descriptions objectAtIndex:0];
    [view_intro.lb_description setLineSpace:7 * ratioH alignment:NSTextAlignmentCenter];
    [view_intro setupVSLTitle:[arr_titles objectAtIndex:0]];
        
    view_intro.frame = CGRectMake( 0, 0, self.sv.frame.size.width, self.sv.frame.size.height);
    [self.sv addSubview:view_intro];
    
    self.sv.contentSize = CGSizeMake(self.sv.frame.size.width , self.sv.frame.size.height);
    self.sv.showsHorizontalScrollIndicator = NO;
    self.sv.showsVerticalScrollIndicator = NO;
    self.sv.pagingEnabled = YES;
    self.sv.delegate = self;
}


-(void)buttonAction_back:(id)_sender;
{
    [appDelegate.slideViewController showRightViewController:YES];
    [nav_main popViewControllerAnimated:YES];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
