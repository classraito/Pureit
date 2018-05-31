//
//  FGSettingMenuHomeViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/9.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGSettingMenuHomeViewController.h"
#import "Global.h"
#import "FGSettingMenuSettingViewController.h"
@interface FGSettingMenuHomeViewController ()
{
    
}
@end

@implementation FGSettingMenuHomeViewController
@synthesize lb_home;
@synthesize iv_home;
@synthesize btn_home;
@synthesize lb_deviceManagement;
@synthesize iv_deviceManagement;
@synthesize btn_deviceManagement;
@synthesize lb_clubPureit;
@synthesize iv_clubPureit;
@synthesize btn_clubPureit;
@synthesize lb_myProfile;
@synthesize iv_myProfile;
@synthesize btn_myProfile;
@synthesize lb_FAQs;
@synthesize iv_FAQs;
@synthesize btn_FAQs;
@synthesize lb_AboutPureit;
@synthesize iv_AboutPureit;
@synthesize btn_AboutPureit;
@synthesize lb_Settings;
@synthesize iv_Settings;
@synthesize btn_Settings;
@synthesize view_line1;
@synthesize view_line2;
@synthesize view_line3;
@synthesize view_line4;
@synthesize view_line5;
@synthesize view_line6;
@synthesize view_line7;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    
    lb_home.font = font(FONT_NORMAL, 16);
    lb_deviceManagement.font = font(FONT_NORMAL, 16);
    lb_clubPureit.font = font(FONT_NORMAL, 16);
    lb_myProfile.font = font(FONT_NORMAL, 16);
    lb_FAQs.font = font(FONT_NORMAL, 16);
    lb_AboutPureit.font = font(FONT_NORMAL, 16);
    lb_Settings.font = font(FONT_NORMAL, 16);
    
    lb_home.text = multiLanguage(@"Pureit Consumption Rank");
    lb_deviceManagement.text = multiLanguage(@"Manage Pureit");
    lb_clubPureit.text = multiLanguage(@"Club Pureit!");
    lb_myProfile.text = multiLanguage(@"My Profile");
    lb_FAQs.text = multiLanguage(@"FAQ’s");
    lb_AboutPureit.text = multiLanguage(@"About Pureit");
    lb_Settings.text = multiLanguage(@"Settings");
    
    [commond useDefaultRatioToScaleView:lb_home];
    [commond useDefaultRatioToScaleView:lb_deviceManagement];
    [commond useDefaultRatioToScaleView:lb_clubPureit];
    [commond useDefaultRatioToScaleView:lb_myProfile];
    [commond useDefaultRatioToScaleView:lb_FAQs];
    [commond useDefaultRatioToScaleView:lb_AboutPureit];
    [commond useDefaultRatioToScaleView:lb_Settings];
    
    [commond useDefaultRatioToScaleView:iv_home];
    [commond useDefaultRatioToScaleView:iv_deviceManagement];
    [commond useDefaultRatioToScaleView:iv_clubPureit];
    [commond useDefaultRatioToScaleView:iv_myProfile];
    [commond useDefaultRatioToScaleView:iv_FAQs];
    [commond useDefaultRatioToScaleView:iv_AboutPureit];
    [commond useDefaultRatioToScaleView:iv_Settings];
    
    [commond useDefaultRatioToScaleView:btn_home];
    [commond useDefaultRatioToScaleView:btn_deviceManagement];
    [commond useDefaultRatioToScaleView:btn_clubPureit];
    [commond useDefaultRatioToScaleView:btn_myProfile];
    [commond useDefaultRatioToScaleView:btn_FAQs];
    [commond useDefaultRatioToScaleView:btn_AboutPureit];
    [commond useDefaultRatioToScaleView:btn_Settings];
    
    [commond useDefaultRatioToScaleView:view_line1];
    [commond useDefaultRatioToScaleView:view_line2];
    [commond useDefaultRatioToScaleView:view_line3];
    [commond useDefaultRatioToScaleView:view_line4];
    [commond useDefaultRatioToScaleView:view_line5];
    [commond useDefaultRatioToScaleView:view_line6];
    [commond useDefaultRatioToScaleView:view_line7];
    
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    self.view_contentView.frame = self.view.frame;

}

-(IBAction)buttonAction_home:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:YES];
}

-(IBAction)buttonAction_deviceManagement:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGDeviceManagementViewController" inNavigation:nav_main withAnimtae:YES];
   
}

-(IBAction)buttonAction_clubPureit:(id)_sender;
{
    
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGPureitClubViewController" inNavigation:nav_main withAnimtae:YES];
}

-(IBAction)buttonAction_myProfile:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGLoginUpdateProfileViewController" inNavigation:nav_main withAnimtae:YES];
}

-(IBAction)buttonAction_FAQs:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGQAViewController" inNavigation:nav_main withAnimtae:YES];
}

-(IBAction)buttonAction_aboutPureit:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGAboutViewController" inNavigation:nav_main withAnimtae:YES];
}

-(IBAction)buttonAction_settings:(id)_sender;
{
    FGSettingMenuSettingViewController *vc_menuSetting = [[FGSettingMenuSettingViewController alloc] initWithNibName:@"FGSettingMenuSettingViewController" bundle:nil];
    [nav_settingsMenu pushViewController:vc_menuSetting animated:YES];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
 
@end
