//
//  FGControllerManager.h
//  Autotrader_Iphone
//
//  Created by rui.gong on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGHomePageViewController.h"
#import "FGHomeMenuViewController.h"
#import "FGRegisterStepViewController.h"
#import "FGLoginUpdateProfileViewController.h"
#import "FGAgreementViewController.h"
#import "FGIntroViewController.h"
#import "FGSettingMenuSettingViewController.h"
#import "FGSettingMenuHomeViewController.h"
#import "FGLoadingViewController.h"
#import "FGDeviceManagementViewController.h"
#import "FGBookGkkViewController.h"
#import "FGSubmitComplaintsViewController.h"
#import "FGMyDevicesViewController.h"
#import "FGAboutViewController.h"
#import "FGQAViewController.h"
#import "FGOrderHistroryViewController.h"
#import "FGPureitClubViewController.h"
#import "FGResetWifiViewController.h"
extern UINavigationController *nav_main;
extern UINavigationController *nav_settingsMenu;
BOOL isSameClass(Class _class, Class  _class2);
BOOL isSubClassByClassName(Class _class,NSString *_className);


@interface FGControllerManager : NSObject<UINavigationControllerDelegate> {
    FGHomePageViewController *vc_homepgae;
    FGHomeMenuViewController *vc_homeMenu;
    FGRegisterStepViewController *vc_registerStep;
    FGLoginUpdateProfileViewController *vc_loginUpdateProfile;
    FGAgreementViewController *vc_agree;
    FGAgreementViewController *vc_agreement;
    FGIntroViewController *vc_intro;
    FGSettingMenuHomeViewController *vc_settingsHome;
    FGSettingMenuSettingViewController *vc_settings;
    FGLoadingViewController *vc_loading;
    FGDeviceManagementViewController *vc_deviceManagement;
    FGBookGkkViewController *vc_bookGkk;
    FGSubmitComplaintsViewController *vc_submitComplaints;
    FGMyDevicesViewController *vc_myDevices;
    FGAboutViewController *vc_about;
    FGQAViewController *vc_QA;
    FGOrderHistroryViewController *vc_orderHistory;
    FGPureitClubViewController *vc_pureitClub;
    FGResetWifiViewController *vc_resetWifi;
}
@property(nonatomic,assign)FGHomePageViewController *vc_homepgae;
@property(nonatomic,assign)FGHomeMenuViewController *vc_homeMenu;
@property(nonatomic,assign)FGRegisterStepViewController *vc_registerStep;
@property(nonatomic,assign)FGLoginUpdateProfileViewController *vc_loginUpdateProfile;
@property(nonatomic,assign)FGAgreementViewController *vc_agreement;
@property(nonatomic,assign)FGIntroViewController *vc_intro;
@property(nonatomic,assign)FGSettingMenuSettingViewController *vc_settings;
@property(nonatomic,assign)FGSettingMenuHomeViewController *vc_settingsHome;
@property(nonatomic,assign)FGLoadingViewController *vc_loading;
@property(nonatomic,assign)FGDeviceManagementViewController *vc_deviceManagement;
@property(nonatomic,assign)FGBookGkkViewController *vc_bookGkk;
@property(nonatomic,assign)FGSubmitComplaintsViewController *vc_submitComplaints;
@property(nonatomic,assign)FGMyDevicesViewController *vc_myDevices;
@property(nonatomic,assign)FGAboutViewController *vc_about;
@property(nonatomic,assign)FGQAViewController *vc_QA;
@property(nonatomic,assign)FGOrderHistroryViewController *vc_orderHistory;
@property(nonatomic,assign)FGPureitClubViewController *vc_pureitClub;
@property(nonatomic,assign)FGResetWifiViewController *vc_resetWifi;
-(UIViewController*) getCurrentViewControllerInNav:(UINavigationController *)_nav;
-(void)pushControllerByName:(NSString *)_controllerName navigationController:(UINavigationController *)_navController withAnimation:(BOOL)_animation;
-(void)popAllViewControllerByNavigation:(UINavigationController **)_nav;
-(NSArray *)getAllControllersByNaviion:(UINavigationController *)_nav;
+(FGControllerManager *)sharedManager;
-(void)addViewControllerToWindowByName:(NSString *)_controllerName;
-(void)popToViewControllerInNavigation:(UINavigationController **)_nav controller:(UIViewController *)_controller animated:(BOOL)_animated;
-(void)popViewControllerInNavigation:(UINavigationController **)_nav  animated:(BOOL)_animated;
-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName create:(BOOL)_isCreate;
-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName;
-(void)initNavigation:(__strong UINavigationController **)_nav rootControllerName:(NSString *)_rootControllerName;
-(void)initNavigation:(__strong UINavigationController **)_nav rootController:(UIViewController *)_rootController;
-(void)pushControllerByName:(NSString *)_controllerName  inNavigation:(UINavigationController *)_nav;
-(void)pushControllerByName:(NSString *)_controllerName inNavigation:(UINavigationController *)_nav withAnimtae:(BOOL)_animate;
-(void)popToFirstViewControlerInNavigation:(UINavigationController **)_nav animated:(BOOL)_animated;
-(void)pushController:(UIViewController *)_controller navigationController:(UINavigationController *)_navController;
-(void)purgeManager;
@end









