//
//  FGAboutViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/26.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGAboutViewController.h"
#import "Global.h"
@interface FGAboutViewController ()
{
    
}
@end

@implementation FGAboutViewController
@synthesize sv;
@synthesize iv;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"About Pureit");
    [commond useDefaultRatioToScaleView:sv];
    [commond useDefaultRatioToScaleView:iv];
    sv.contentSize = CGSizeMake(sv.frame.size.width, iv.frame.size.height);
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
