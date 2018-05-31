//
//  FGSettingMenuSettingViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/9.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGSettingMenuSettingViewController.h"
#import "Global.h"
#import "ZJSwitch.h"
@interface FGSettingMenuSettingViewController ()
{
    ZJSwitch *switch2;
    ZJSwitch *switch1;
}
@end

@implementation FGSettingMenuSettingViewController
@synthesize lb_myDevices;
@synthesize btn_myDevices;
@synthesize lb_notifications;
@synthesize lb_termsConditions;
@synthesize btn_termsConditions;
@synthesize iv_back;
@synthesize btn_back;
@synthesize view_line2;
@synthesize view_line3;
@synthesize view_line4;
@synthesize view_switchButtonPlaceholder;
@synthesize lb_title;
@synthesize btn_locationServices;
@synthesize lb_locationServices;
@synthesize view_switchLocationsPlaceholder;
@synthesize view_line5;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    // Do any additional setup after loading the view from its nib.
    lb_myDevices.font = font(FONT_NORMAL, 16);
    lb_notifications.font = font(FONT_NORMAL, 16);
    lb_termsConditions.font = font(FONT_NORMAL, 16);
    lb_title.font = font(FONT_BOLD, 25);
    lb_myDevices.text = multiLanguage(@"My Devices");
    lb_notifications.text = multiLanguage(@"App Notifications");
    lb_termsConditions.text = multiLanguage(@"Terms and Conditions");
    lb_locationServices.text = multiLanguage(@"Location Service");
    lb_locationServices.font = font(FONT_NORMAL, 16);
    lb_title.text = multiLanguage(@"Settings");
    
    
    [commond useDefaultRatioToScaleView:lb_myDevices];
    [commond useDefaultRatioToScaleView:btn_myDevices];
    [commond useDefaultRatioToScaleView:lb_notifications];
    [commond useDefaultRatioToScaleView:lb_termsConditions];
    [commond useDefaultRatioToScaleView:btn_termsConditions];
    [commond useDefaultRatioToScaleView:iv_back];
    [commond useDefaultRatioToScaleView:btn_back];
    [commond useDefaultRatioToScaleView:view_line2];
    [commond useDefaultRatioToScaleView:view_line3];
    [commond useDefaultRatioToScaleView:view_line4];
    [commond useDefaultRatioToScaleView:view_switchButtonPlaceholder];
    [commond useDefaultRatioToScaleView:lb_title];
    [commond useDefaultRatioToScaleView:btn_locationServices];
    [commond useDefaultRatioToScaleView:lb_locationServices];
    [commond useDefaultRatioToScaleView:view_line5];
    [commond useDefaultRatioToScaleView:view_switchLocationsPlaceholder];
    
}

-(void)setupSwitchButton
{
    if(!switch2)
    {
        view_switchButtonPlaceholder.backgroundColor = [UIColor clearColor];
        switch2 = [[ZJSwitch alloc] initWithFrame:CGRectMake(0, 0, view_switchButtonPlaceholder.frame.size.width, view_switchButtonPlaceholder.frame.size.height)];
        [view_switchButtonPlaceholder addSubview:switch2];
        [switch2 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    }
    [switch2 setBounds:view_switchButtonPlaceholder.bounds];
    switch2.backgroundColor = [UIColor clearColor];
    
    switch2.onText = multiLanguage(@"ON") ;
    switch2.offText = multiLanguage(@"OFF");
    switch2.onLabel.font = font(FONT_NORMAL, 16);
    switch2.offLabel.font = font(FONT_NORMAL, 16);
    [switch2 setOffTextColor:deepblue];
    [switch2 setOnTextColor:[UIColor whiteColor]];
    
    switch2.thumbTintColor = [UIColor whiteColor];
    switch2.tintColor = [UIColor lightGrayColor];
    switch2.onTintColor = deepblue;
    
    switch2.on = YES;
}

-(void)setupLocationSwitchButton
{
    if(!switch1)
    {
        view_switchLocationsPlaceholder.backgroundColor = [UIColor clearColor];
        switch1 = [[ZJSwitch alloc] initWithFrame:CGRectMake(0, 0, view_switchLocationsPlaceholder.frame.size.width, view_switchLocationsPlaceholder.frame.size.height)];
        [view_switchLocationsPlaceholder addSubview:switch1];
        [switch1 addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
    }
    [switch1 setBounds:view_switchLocationsPlaceholder.bounds];
    switch1.backgroundColor = [UIColor clearColor];
    
    switch1.onText = multiLanguage(@"ON") ;
    switch1.offText = multiLanguage(@"OFF");
    switch1.onLabel.font = font(FONT_NORMAL, 16);
    switch1.offLabel.font = font(FONT_NORMAL, 16);
    [switch1 setOffTextColor:deepblue];
    [switch1 setOnTextColor:[UIColor whiteColor]];
    
    switch1.thumbTintColor = [UIColor whiteColor];
    switch1.tintColor = [UIColor lightGrayColor];
    switch1.onTintColor = deepblue;
    
    switch1.on = [[FGLocationManagerWrapper sharedManager] isLocationServiceOn];
}

-(void)handleSwitchEvent:(ZJSwitch *)_switch
{
    if([_switch isEqual:switch1])//Location services
    {
        
    }
    else if([_switch isEqual:switch2])//Push Notification
    {
        
    }
    NSLog(@"_switch.isOn = %d",_switch.isOn);
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    switch2.frame = view_switchButtonPlaceholder.bounds;
    switch1.frame = view_switchLocationsPlaceholder.bounds;
    [self setupSwitchButton];
    [self setupLocationSwitchButton];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - buttonAction
-(IBAction)buttonAction_settingsBack:(id)_sender;
{
    [nav_settingsMenu popToRootViewControllerAnimated:YES];
    
}

-(IBAction)buttonAction_myDevices:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    [manager pushControllerByName:@"FGMyDevicesViewController" inNavigation:nav_main withAnimtae:YES];
}

-(IBAction)buttonAction_termsCondition:(id)_sender;
{
    [appDelegate.slideViewController hideSideViewController:YES];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [nav_main popToViewController:manager.vc_homepgae animated:NO];
    
    FGAgreementViewController *vc_agreement = [[FGAgreementViewController alloc] initWithNibName:@"FGAgreementViewController" bundle:nil needdelete_logo:YES];
    [self presentViewController:vc_agreement animated:YES completion:^{}];
    [vc_agreement performSelector:@selector(prepareForSettingMenu) withObject:nil afterDelay:.1];
}

-(IBAction)buttonAction_switchLocations:(id)_sender;
{
    [[FGLocationManagerWrapper sharedManager]showAlert];
}
@end
