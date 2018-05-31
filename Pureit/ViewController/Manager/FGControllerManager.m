//
//  FGControllerManager.m
//  Autotrader_Iphone
//
//  Created by rui.gong on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FGControllerManager.h"
#import "Global.h"
static FGControllerManager *manager;
UINavigationController *nav_main;
UINavigationController *nav_settingsMenu;
BOOL isSameClass(Class _class, Class  _class2)
{
    if([NSStringFromClass(_class)isEqualToString:NSStringFromClass(_class2)])
    {
        return YES;
    }
    else
        return NO;
}

BOOL isSubClassByClassName(Class _class,NSString *_className)
{
    if([_class isSubclassOfClass:NSClassFromString(_className)])
    {
        return YES;
    }
    else
    return NO;
}

extern void instanceXibClass(id * _obj,NSString *_str)
{
    *_obj = [[NSClassFromString(_str) alloc]initWithNibName:_str bundle:nil];
}



@implementation FGControllerManager
@synthesize vc_homepgae;
@synthesize vc_homeMenu;
@synthesize vc_registerStep;
@synthesize vc_loginUpdateProfile;
@synthesize vc_agreement;
@synthesize vc_intro;
@synthesize vc_settings;
@synthesize vc_settingsHome;
@synthesize vc_loading;
@synthesize vc_deviceManagement;
@synthesize vc_bookGkk;
@synthesize vc_submitComplaints;
@synthesize vc_myDevices;
@synthesize vc_about;
@synthesize vc_QA;
@synthesize vc_orderHistory;
@synthesize vc_pureitClub;
@synthesize vc_resetWifi;
-(UIViewController*) getCurrentViewControllerInNav:(UINavigationController *)_nav
{
    if(!_nav)
        return nil;
    
    return  _nav.topViewController;
}

-(void)initNavigationByControllerRootName:(NSString *)_rootControllerName navigationController:(__strong UINavigationController **)_navController
{
    if(!(*_navController))
    {
        
        NSLog(@":::::>-(void)addNavigationByControllerByRootName:(NSString *)=%@",_rootControllerName);
        UIViewController *_viewController = [self initializeViewControllerByName:_rootControllerName];
        *_navController =[ [UINavigationController alloc] initWithRootViewController:_viewController];
        (*_navController).delegate = self;
        (*_navController).navigationBarHidden=YES;
        [_viewController release];
        
//        [appDelegate.window addSubview:(*_navController).view];
        
    }
    else
    {
//        [appDelegate.window bringSubviewToFront:(*_navController).view];
    }
    
//    appDelegate.window.rootViewController = *_navController;
    NSLog(@"(*_navController).view] = %@",(*_navController).view);
    NSLog(@"window subviews=%@",[appDelegate.window subviews]);
    
}

-(void)initNavigationByControllerRootController:(UIViewController *)_rootController navigationController:(__strong UINavigationController **)_navController
{
    NSLog(@":::::>-(void)initNavigationByControllerRootController:(NSString *)=%@",_rootController);
    NSLog(@"_rootController=%@",_rootController);
    if(!(*_navController))
    {
        *_navController =[ [UINavigationController alloc] initWithRootViewController:_rootController];
        (*_navController).delegate = self;
        (*_navController).navigationBarHidden=YES;
        [_rootController release];
        [appDelegate.window addSubview:(*_navController).view];
    }
    else
    {
        [appDelegate.window bringSubviewToFront:(*_navController).view];
    }
    
    NSLog(@"window subviews=%@",[appDelegate.window subviews]);
}

-(void)pushControllerByName:(NSString *)_controllerName navigationController:(UINavigationController *)_navController withAnimation:(BOOL)_animation
{
    NSLog(@":::::>-(void)pushControllerByName:(NSString *)=%@ navigationController:(UINavigationController *)=%@",_controllerName,_navController);
    assert(_controllerName);
    assert(_navController);
    for(id viewController in nav_main.viewControllers)
    {
        if([viewController isKindOfClass:NSClassFromString(_controllerName)])
        {
            NSLog(@"已经在navigationController中存在相同的类了");
            return;
        }
    }
    UIViewController *_viewController = [self initializeViewControllerByName:_controllerName];
    [_navController pushViewController:_viewController animated:_animation];
    [_viewController release];
}

-(void)popAllViewControllerByNavigation:(UINavigationController **)_nav
{
    NSLog(@"popAllViewControllerByNavigation:%@",*_nav);
    if(*_nav!=nil)
    {
        NSLog(@"*_nav=%@",(*_nav));
        [(*_nav) popToRootViewControllerAnimated:NO];
        [(*_nav) release];
        (*_nav)=nil;
    }
}

-(NSArray *)getAllControllersByNaviion:(UINavigationController *)_nav
{
    assert(_nav);
    return  [_nav viewControllers];
}



+(FGControllerManager *)sharedManager
{
    @synchronized(self)     {
        if(!manager)
        {
            manager=[[FGControllerManager alloc]init];
            NSLog(@"init FGControllerManager");
            return manager;
        }
    }
    return manager;
}

+(id)alloc
{
    @synchronized(self)     {
        NSAssert(manager == nil, @"企圖創建一個singleton模式下的FGControllerManager");
        return [super alloc];
    }
    return nil;
}

-(void)addViewControllerToWindowByName:(NSString *)_controllerName
{
    UIViewController *_controllerView = [self initializeViewControllerByName:_controllerName];
    assert(_controllerView);
    [appDelegate.window addSubview:_controllerView.view];
}

-(void)popToFirstViewControlerInNavigation:(UINavigationController **)_nav animated:(BOOL)_animated
{
    if( (* _nav) )
    {
        [(*_nav) popToRootViewControllerAnimated:_animated];
    }
}

-(void)popToViewControllerInNavigation:(UINavigationController **)_nav controller:(UIViewController *)_controller animated:(BOOL)_animated
{
    NSLog(@":::::>-(void)popToViewControllerInNavigationByName");
    if( (* _nav) )
    {
        if([(* _nav).viewControllers count]==1)
        {
            NSLog(@"just have one controller in UINavigationController back to home");
            //(* _nav)=nil;
        }
        else
        {
            [(* _nav) popToViewController:_controller animated:_animated];
        }
    }
}

-(void)popViewControllerInNavigation:(UINavigationController **)_nav  animated:(BOOL)_animated
{
    NSLog(@":::::>-(void)popViewControllerInNavigation");
    assert( (* _nav) );
    if([(* _nav).viewControllers count]==1)
    {
        NSLog(@"just have one controller in UINavigationController back to home");
    }
    else
    {
        [(* _nav) popViewControllerAnimated:_animated];
    }
}

-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName create:(BOOL)_isCreate
{
    
    NSLog(@":::::>-(UIViewController *)initializeViewControllerByName:(NSString *)=%@",_controllerName);
    
    if(isSubClassByClassName([FGHomePageViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_homepgae, _controllerName);
        return vc_homepgae;
    }
    if(isSubClassByClassName([FGHomeMenuViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_homeMenu, _controllerName);
        return vc_homeMenu;
    }
    if(isSubClassByClassName([FGRegisterStepViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_registerStep, _controllerName);
        return vc_registerStep;
    }
    if(isSubClassByClassName([FGLoginUpdateProfileViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_loginUpdateProfile, _controllerName);
        return vc_loginUpdateProfile;
    }
    if(isSubClassByClassName([FGAgreementViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_agreement, _controllerName);
        return vc_agreement;
    }
    if(isSubClassByClassName([FGSettingMenuHomeViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_settingsHome, _controllerName);
        return vc_settingsHome;
    }
    if(isSubClassByClassName([FGSettingMenuSettingViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_settings, _controllerName);
        return vc_settings;
    }
    if(isSubClassByClassName([FGIntroViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_intro, _controllerName);
        return vc_intro;
    }
    if(isSubClassByClassName([FGLoadingViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_loading, _controllerName);
        return vc_loading;
    }
    if(isSubClassByClassName([FGDeviceManagementViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_deviceManagement, _controllerName);
        return vc_deviceManagement;
    }
    if(isSubClassByClassName([FGBookGkkViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_bookGkk, _controllerName);
        return vc_bookGkk;
    }
    if(isSubClassByClassName([FGSubmitComplaintsViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_submitComplaints, _controllerName);
        return vc_submitComplaints;
    }
    if(isSubClassByClassName([FGMyDevicesViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_myDevices, _controllerName);
        return vc_myDevices;
    }
    if(isSubClassByClassName([FGAboutViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_about, _controllerName);
        return vc_about;
    }
    if(isSubClassByClassName([FGQAViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_QA, _controllerName);
        return vc_QA;
    }
    if(isSubClassByClassName([FGOrderHistroryViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_orderHistory, _controllerName);
        return vc_orderHistory;
    }
    if(isSubClassByClassName([FGPureitClubViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_pureitClub, _controllerName);
        return vc_pureitClub;
    }
    if(isSubClassByClassName([FGResetWifiViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_resetWifi, _controllerName);
        return vc_resetWifi;
    }
    return nil;
}

-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName
{
    return [self initializeViewControllerByName:_controllerName create:YES];
}

-(void)initNavigation:(UINavigationController **)_nav rootControllerName:(NSString *)_rootControllerName
{
    [self initNavigationByControllerRootName:_rootControllerName navigationController:_nav];
    
}

-(void)initNavigation:(UINavigationController **)_nav rootController:(UIViewController *)_rootController
{
    
    [self initNavigationByControllerRootController:_rootController navigationController:_nav];
    
}

-(void)pushControllerByName:(NSString *)_controllerName  inNavigation:(UINavigationController *)_nav
{
    [self pushControllerByName:_controllerName navigationController:_nav withAnimation:YES];
}

-(void)pushControllerByName:(NSString *)_controllerName inNavigation:(UINavigationController *)_nav withAnimtae:(BOOL)_animate
{
    [self pushControllerByName:_controllerName navigationController:_nav withAnimation:_animate];
}

-(void)pushController:(UIViewController *)_controller navigationController:(UINavigationController *)_navController
{
    assert(_navController);
    for(id viewController in nav_main.viewControllers)
    {
        if([viewController isKindOfClass:[_controller class]])
        {
            NSLog(@"已经在navigationController中存在相同的类了");
            return;
        }
    }

    [_navController pushViewController:_controller animated:YES];
//    [_controller release];
}


-(void)purgeManager
{
    [manager release];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc FGControllerManager");
    
    [super dealloc];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"navigationController=%@  viewController=%@",navigationController,viewController);
}
@end


