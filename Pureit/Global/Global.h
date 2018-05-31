//
//  Global.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//


#pragma mark - 导入头
//字体
#import "Font.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
//工具
#import "commond.h"//一些实用的小工具 不归类了
#import "FGFont.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSMutableArray+Safty.h"
#import "NSMutableDictionary+Safty.h"
#import "Reachability.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "JSONKit.h"
#import "StringValidate.h"
#import "TAlertView.h"
#import "UIImageView+WebCache.h"
#import "UILabel+LineSpace.h"
#import "Flurry.h"
#import "NSString+MD5.h"
#import "ADTickerLabel.h"
#import <AVFoundation/AVFoundation.h>
#import "YRSideViewController.h"
#import "NetworkManager.h"
#import "FGLoginUpdateProfileViewController.h"
#import "SFHFKeychainUtils.h"
#import "Scan_VC.h"
#import "UIColor+helper.h"
#import "THObserversAndBinders.h"
#import "FGDialogView.h"
#import "FGCustomAlertView.h"
#import "FGLocationManagerWrapper.h"
//viewController
#import "FGControllerManager.h"//管理所有viewcontroller类的 1.初始化 2.销毁 3.导航 4.传递参数 .etc (这个类需要手动管理内存 non-arc)
#import "DatabaseManager.h"
#define FLURRY_CODE @""

#define W getScreenSize().width
#define H getScreenSize().height
#define ratioW W / 320.0f
#define ratioH H / 568.0f

#if defined (DEVELOPER)
    #define DEBUG_MODE//注释这里 禁用所有NSLog输出
#endif

#ifdef DEBUG_MODE
#    define NSLog(...) NSLog(__VA_ARGS__)
#else
#    define NSLog(...)
#endif

#define HOSTNAME @"http://brand.fugumobile.cn/unileverpureit"

//--------微信APPID--------------
#define WECHAT_APPID @"wx801ffbea3d5221a4"
#define WECHAT_APPSECRET @"323ce236a6ab46d0d9f5d2cff52cb0e4"

//#define WECHAT_APPID @"wx248badb435427c6f"
//#define WECHAT_APPSECRET @"2d44375ce9d7188bd63c6a577bc85e53"

#pragma mark -常用宏
#define multiLanguage(text) NSLocalizedStringFromTable(text,@"MyString", @"")

//============================企业版预编译=======================
#if defined (ENTERPRISE)
#define APP_BUNDLEID @"com.mobile-measure.Pureit"
#endif

//============================开发版预编译========================
#if defined (DEVELOPER)
#define APP_BUNDLEID @"com.fugumobile.Pureit"
#endif

//===========================发布版预编译========================
#if defined (DISTRIBUTION)
#define APP_BUNDLEID @"com.fugumobile.Pureit"
#endif
//============color===========
#define lightblue rgba(68, 189, 235, .7)
#define darkblue rgba(0, 15, 105, 1)
#define lightblue_transparent rgba(196, 234, 248, 1)
#define darkblue_transparent rgba(108, 164, 203, 1)
#define orangeColor rgb(245,130,31)
#define meihongColor rgb(226,40,130)
#define baolanColor rgb(45,129,159)
#define skyblueColor rgb(30,158,196)
#define deepblue rgb(28,42,120)
#define bgGray rgb(232, 233, 234)
#define lightgreen rgb(47, 242, 44)

#define rgb(r,g,b) [UIColor colorWithRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:1]
#define rgba(r,g,b,a) [UIColor colorWithRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:a]
#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate) //获得AppDelegate实例的宏 如果你的AppDelegate文件名与我不同 请在这里更改"AppDelegate"

#define LAYOUT_STATUSBAR_HEIGHT 0
#define LAYOUT_TOPVIEW_HEIGHT 60        //标题栏的高度

#define LAYOUT_BOTTOMVIEW_HEIGHT 0     //底部标签栏的高度,目前没有底部标签栏，这里作为冗余，如果以后要加入就方便布局了



