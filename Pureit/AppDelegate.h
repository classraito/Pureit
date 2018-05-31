//
//  AppDelegate.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    AppStatus_Default = 0,
    AppStatus_agreementReaded = 1,
    AppStatus_introReaded = 2,
    AppStatus_registed = 3,
    AppStatus_userinfoSetted = 4,
    AppStatus_logged = 5
}AppStatus;

extern BOOL isNeedViewMoveUpWhenKeyboardShow;//是否允许键盘展现的时候将当前view上移
extern CGFloat heightNeedMoveWhenKeybaordShow;//当键盘展示时当前view上移多少个像素

extern AppStatus currentAppStatus;
@class YRSideViewController;

#define KEY_APPSTATUS @"KEY_APPSTATUS"
#define KEYCHAIN_KEY_USERINFO @"KEYCHAIN_KEY_USERINFO"
#define KEY_TIPS_STATUS @"KEY_TIPS_STATUS"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
}
@property (strong,nonatomic)YRSideViewController *slideViewController;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *deviceToken;
-(void)initalSlideViewControllerWithRoot:(UIViewController *)_rootController;
-(void)viewMoveUp:(CGFloat)_height;
-(void)viewMoveDown;
- (void)dismissKeyboard:(UIView*)view;
-(void)go2Loading;
@end

