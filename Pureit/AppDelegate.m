//
//  AppDelegate.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "AppDelegate.h"
#import "Global.h"
#import "YRSideViewController.h"
BOOL isNeedViewMoveUpWhenKeyboardShow;//是否允许键盘展现的时候将当前view上移
CGFloat heightNeedMoveWhenKeybaordShow;//当键盘展示时当前view上移多少个像素
AppStatus currentAppStatus;
void uncaughtExceptionHandler(NSException *exception) {
    [Flurry logError:@"Uncaught" message:@"Crash!" exception:exception];
}

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize slideViewController;
@synthesize deviceToken;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    //向微信注册
    [WXApi registerApp:WECHAT_APPID withDescription:@"demo 2.0"];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [pathArray objectAtIndex:0];
    NSLog(@"documentDirectory = %@",documentDirectory);
    
    // Override point for customization after application launch.
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [Flurry setSessionReportsOnCloseEnabled:YES];
    [Flurry setSessionReportsOnPauseEnabled:YES];
    
    [Flurry setEventLoggingEnabled:YES];
#ifdef DEBUG_MODE
    //    [Flurry setDebugLogEnabled:YES];
#endif
    [Flurry startSession:FLURRY_CODE];
    
    [FGFont loadMyFonts];
    [FGFont showSupportedFont];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSNumber *obj = (NSNumber *)[commond getUserDefaults:KEY_APPSTATUS];
    if(!obj)
    {
        [commond setUserDefaults:[NSNumber numberWithInt:AppStatus_Default] forKey:KEY_APPSTATUS];
    }
    
     NSNumber *obj1 = (NSNumber *)[commond getUserDefaults:KEY_TIPS_STATUS];
     if(!obj1)
     {
         [commond setUserDefaults:[NSNumber numberWithBool:NO] forKey:KEY_TIPS_STATUS];
     }//第一次默认初始化状态

    
    currentAppStatus = [obj intValue];
//    [self testUI];
    
  
    [self go2Loading];
    
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myReachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *hostReach = [Reachability reachabilityForInternetConnection];//可以以多种形式初始化
    [hostReach startNotifier]; //开始监听,会启动一个run loop
    
    [self registePush];
//  [commond getCurrentLanguage];//en-CN zh-Hans-CN
    return YES;
}

-(void)registePush
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                                             settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert )
                                                                             categories:nil]];
        
        NSLog(@"register device token bigger than ios8");
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    }
    else
    {
        //这里还是原来的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         ( UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

#pragma mark - PushNotification
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)_deviceToken
{[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    deviceToken = [[[[_deviceToken description]
                     stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]
                    stringByReplacingOccurrencesOfString:@" "
                    withString:@""] copy];
//    NSLog(@"1.deviceToken=%@",deviceToken);
    printf("deviceToken = %s \n",[deviceToken UTF8String]);
}


-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    deviceToken = @"";
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    NSLog(@":::>fetchCompletionHandler userInfo = %@",userInfo);
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@":::>didReceiveRemoteNotification userInfo = %@",userInfo);
    //    NSString *status = [NSString stringWithFormat:@"Notification received:\n%@",[userInfo description]];
    //    CFShow([userInfo description]);
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        return [WXApi handleOpenURL:url delegate:[WXApiWrapper sharedManager]];
    }
    
    return NO;
}


-(void)initalSlideViewControllerWithRoot:(UIViewController *)_rootController
{
    if(!slideViewController)
    {
        slideViewController=[[YRSideViewController alloc]initWithNibName:nil bundle:nil];
    }
    
    slideViewController.rootViewController=_rootController;
    slideViewController.showBoundsShadow = NO;
    slideViewController.view.backgroundColor = bgGray;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager initNavigation:&nav_settingsMenu rootControllerName:@"FGSettingMenuHomeViewController"];
    nav_main.view.backgroundColor = [UIColor whiteColor];
    slideViewController.rightViewController=nav_settingsMenu;
    
    //动画效果可以被自己自定义，具体请看api
    self.window.rootViewController=slideViewController;
    
    [slideViewController setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        //使用简单的平移动画
        rootView.frame=CGRectMake(xoffset, orginFrame.origin.y, orginFrame.size.width, orginFrame.size.height);
    }];
}

//------------------测试代码----------------------
-(void)testUI
{
//    FGDeviceManagementViewController *vc_home = [[FGDeviceManagementViewController alloc] initWithNibName:@"FGDeviceManagementViewController" bundle:nil];
    FGHomePageViewController *vc_home = [[FGHomePageViewController alloc] initWithNibName:@"FGHomePageViewController" bundle:nil];
    nav_main =[ [UINavigationController alloc] initWithRootViewController:vc_home];
    nav_main.navigationBarHidden=YES;
    
    FGAboutViewController *vc = [[FGAboutViewController alloc] initWithNibName:@"FGAboutViewController" bundle:nil];
    [nav_main pushViewController:vc animated:YES];
    self.window.rootViewController = nav_main;
}



-(void)go2Loading
{
    appDelegate.window.rootViewController = nil;
    appDelegate.window.rootViewController = [[FGLoadingViewController alloc] initWithNibName:@"FGLoadingViewController" bundle:nil];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)dismissKeyboard:(UIView*)view
{
    
    if ([view isKindOfClass:[UITextField class]])
    {
        [view resignFirstResponder];
    }
    else
    {
        for (UIView* subView in view.subviews)
        {
            [self dismissKeyboard:subView];
        }
    }
}

-(void)viewMoveUp:(CGFloat)_height
{
    if(!isNeedViewMoveUpWhenKeyboardShow)
        return;
    if(nav_main.view.frame.origin.y==-_height)
        return;
    //   [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [UIView beginAnimations:nil context:nil];
    CGRect _frame = nav_main.view.frame;
    _frame.origin.y = -_height;
    nav_main.view.frame = _frame;
    [UIView commitAnimations];
}

-(void)viewMoveDown
{
    if(!isNeedViewMoveUpWhenKeyboardShow)
        return;
    if(nav_main.view.frame.origin.y>=0)
        return;
    //   [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView beginAnimations:nil context:nil];
    CGRect _frame = nav_main.view.frame;
    _frame.origin.y = 0;
    nav_main.view.frame = _frame;
    [UIView commitAnimations];
    
}

#pragma kReachabilityChangedNotification

-(void)myReachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    BOOL isReachable = [[Reachability reachabilityForInternetConnection] isReachable];
    NSLog(@"isReachable = %d",isReachable);
    if(!isReachable)
    {
        [commond removeLoading];
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
    }
}

@end
