
//  FGBaseViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "Global.h"
CGFloat currentKeyboardHeight;
#define DEFAULT_KEYBOARDHEIGHT_IPHONE5 253
#define DEFAULT_KEYBOARDHEIGHT_IPHONE6 258
#define DEFAULT_KEYBOARDHEIGHT_IPHONE6PLUS 271
@interface FGBaseViewController ()
{
    
}
@end

@implementation FGBaseViewController
@synthesize view_topPanel;
@synthesize iv_bg;
@synthesize view_contentView;
@synthesize view_statusBarBg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        if(appDelegate.slideViewController)
            appDelegate.slideViewController.rightViewShowWidth =208*ratioW;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        //注册网络请求通知事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedDataFromNetwork:) name:Notification_UpdateData object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFailedFromNetwork:) name:Notification_UpdateFailed object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@":::::>(%f,%f)",W,H);
    /*
     在首页的最上方放置一个 scrollview（包括状态栏）。当程序运行，显示界面的时候，scrollview 会向下偏移20个像素。
     这是由于iOS7的UIViewController有个新特性
     @property(nonatomic,assign) BOOL automaticallyAdjustsScrollViewInsets NS_AVAILABLE_IOS(7_0); // Defaults to YES
     scrollview会自动偏移,要手动关掉
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
   self.view.backgroundColor = [UIColor whiteColor];
    
    view_statusBarBg = [[UIView alloc] initWithFrame:CGRectMake(0, LAYOUT_STATUSBAR_HEIGHT, W, LAYOUT_STATUSBAR_HEIGHT)];
    view_statusBarBg.backgroundColor = [UIColor whiteColor];
    view_statusBarBg.hidden = YES;
    [self.view addSubview:view_statusBarBg];
    [self.view sendSubviewToBack:view_statusBarBg];
    
    //初始化导航栏
    view_topPanel = (FGTopPanelView *)[[[NSBundle mainBundle] loadNibNamed:@"FGTopPanelView" owner:nil options:nil] objectAtIndex:0];
    view_topPanel.frame = CGRectMake(0, LAYOUT_STATUSBAR_HEIGHT, W, LAYOUT_TOPVIEW_HEIGHT);
    [self.view addSubview:view_topPanel];
    [self.view bringSubviewToFront:view_topPanel];
    iv_bg = [[UIImageView alloc] init];
    [self.view addSubview:iv_bg];
    [self.view sendSubviewToBack:iv_bg];
    
    //注册导航栏按钮事件
    [view_topPanel.btn_back addTarget:self action:@selector(buttonAction_back:) forControlEvents:UIControlEventTouchUpInside];
    [view_topPanel.btn_settings addTarget:self action:@selector(buttonAction_settings:) forControlEvents:UIControlEventTouchUpInside];
   
     view_contentView.backgroundColor = [UIColor clearColor];
    
    currentKeyboardHeight = [self normalKeyboardHeight];
     isViewDidLayoutSubviewsShouldBeCall = YES;//默认是YES,当设为NO时 视图的位置发生变化时父类不会在-(void)viewDidLayoutSubviews中调用manullyFixSize 而是在-(void)viewWillAppear:(BOOL)animated中调用
    
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getsture_cancelKeyboard:)];
    _tap.cancelsTouchesInView = YES;
    _tap.delegate = self;
    [self.view addGestureRecognizer:_tap];
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    return YES;
}

-(void)getsture_cancelKeyboard:(id)_sender
{
    [appDelegate dismissKeyboard:appDelegate.window];
}

#pragma mark - 控制keyboard展现后的行为
-(CGFloat)normalKeyboardHeight
{
    if(H<=568)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE5;
    }
    else if(H<=667)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE6;
    }
    else if(H<=960)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE6PLUS;
    }
    return DEFAULT_KEYBOARDHEIGHT_IPHONE5;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!isViewDidLayoutSubviewsShouldBeCall)
        [self manullyFixSize];
}

/*所有屏幕适配代码在子类的这个手工适配方法中实现*/
-(void)manullyFixSize
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    view_statusBarBg.frame = CGRectMake(0, 0, W, LAYOUT_STATUSBAR_HEIGHT);
    view_topPanel.frame = CGRectMake(0, LAYOUT_STATUSBAR_HEIGHT, W, LAYOUT_TOPVIEW_HEIGHT);
    view_contentView.frame = CGRectMake(0, 0,
                                        W, H);
    iv_bg.frame = self.view.frame;
}

/*autolayout 会在viewWillAppear和viewDidAppear之间的那段时间为你分析约束、设置frame,所以不能在这两个方法中操作frame,因为你会在这viewDidAppear中得到不同结果，而且我发现他们会被调用多次
 而需要在viewDidLayoutSubviews中操作，因为这个方法是在autolayout布局完成之后执行
 在iOS5.0以后就有这个生命周期函数ViewDidLayoutSubViews这个方法基本可以代替ViewDidload使用，只不过差别在于前者是约束(autolayout)后，后者是约束前*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if(isViewDidLayoutSubviewsShouldBeCall)
    {
        //    [self.view layoutSubviews];//IOS7中必须用这个方法
        [self manullyFixSize];
    }
    
}

//设置按钮
-(void)buttonAction_settings:(id)_sender;
{
    if(!appDelegate.slideViewController)
        return;
    [nav_settingsMenu popToRootViewControllerAnimated:NO];
    [appDelegate.slideViewController showRightViewController:YES];
}

//返回按钮
-(void)buttonAction_back:(id)_sender;
{
    [nav_main popViewControllerAnimated:NO];
    
    if(currentAppStatus < AppStatus_logged) //TODO::<peng> 2016_4_13 修复已登录的情况下返回按钮跳转到注册界面
    {
        NSString *className = @"FGRegisterStepViewController";//如果未注册过 进入注册页
        FGControllerManager *manager = [FGControllerManager sharedManager];
        [manager pushControllerByName:className inNavigation:nav_main withAnimtae:NO];
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_UpdateData object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_UpdateFailed object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    view_contentView = nil;
    view_topPanel = nil;
    iv_bg = nil;
    view_statusBarBg = nil;
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    currentKeyboardHeight = kbSize.height;
    
    if(currentKeyboardHeight < [self normalKeyboardHeight])
    {
        currentKeyboardHeight = [self normalKeyboardHeight];
    }
    
    [appDelegate viewMoveUp:heightNeedMoveWhenKeybaordShow];
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    [self keyboardWillShow:notification];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    
    [appDelegate viewMoveDown];
    
}

-(void)go2HomeScreen
{
    [self go2HomeScreenWithAnimate:YES];
}

-(void)go2HomeScreenWithAnimate:(BOOL)_animated
{
    
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGHomePageViewController" inNavigation:nav_main withAnimtae:_animated];
}

#pragma mark - 网络通知
/*获得任何网络数据时会通知此方法 以便基类将数据分发给子类的updateData方法*/
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    NSLog(@":::::>%s %d obj = %@",__FUNCTION__,__LINE__,_notification.object);
   
}

/*请求网络失败后的通知*/
-(void)requestFailedFromNetwork:(NSNotification *)_notification
{
   NSLog(@"::::::>%s  %d requestFailedFromNetwork obj = %@",__FUNCTION__,__LINE__,_notification.object);
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    
        if([[_dic_requestInfo allKeys] containsObject:@"result"])
        {
            NSMutableDictionary *_dic_result = [_dic_requestInfo objectForKey:@"result"];
            if([[_dic_result allKeys] containsObject:@"Code"])
            {
                int code = [[_dic_result objectForKey:@"Code"] intValue];
                if(code == -101)//登录信息已过期，请重新登录！未找到对应设备，请先绑定设备！
                {
                    NSString *str_codeMsg = [_dic_result objectForKey:@"CodeMsg"];
                    [commond alert:multiLanguage(@"警告") message:str_codeMsg callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
                        [commond removeLoading];
                        FGControllerManager *manager = [FGControllerManager sharedManager];
                        if(manager.vc_homepgae)
                        {
                            [manager.vc_homepgae cancelRefreshHomepageData];
                            
                        }
                        currentAppStatus = AppStatus_agreementReaded;
                        [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
                        [nav_main popToRootViewControllerAnimated:NO];
                        nav_main = nil;
                        manager.vc_homepgae = nil;
                        [appDelegate go2Loading];
                    }];
                   
                }
            }
          
        }
}

@end
