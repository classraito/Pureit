//
//  FGLoadingViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/2.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGLoadingViewController.h"
#import "Global.h"
@interface FGLoadingViewController ()
{
    AVPlayerLayer *playerLayer;
    UIImageView *iv_videoMask;
}

@end

@implementation FGLoadingViewController
@synthesize iv_logo;
@synthesize view_videoContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
//    self.iv_bg.image = [UIImage imageNamed:@"splash.jpg"];
    appDelegate.slideViewController.needSwipeShowMenu=NO;
    
    [self internalInitalVideoMask];
    [self internalInitalVideoView];
    [self initVideo];
    
    [self logoFadeIn];
    
    if(currentAppStatus >= AppStatus_logged)
    {
        [NetworkManager sharedManager].refreshCode = 0;
        [[NetworkManager sharedManager] performSelector:@selector(postRequest_getHomePageData:) withObject:nil afterDelay:3];
    }
    else
        [self performSelector:@selector(go2NextPage) withObject:nil afterDelay:5];
    [commond useDefaultRatioToScaleView:iv_logo];
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    CGRect _frame;

    _frame = view_videoContent.frame;
    _frame.origin.x = 0;
    _frame.size.width = W;
    _frame.size.height = W / DEFAULT_VIDEOWIDTH * DEFAULT_VIDEOHEIGHT;
    _frame.origin.y = H - _frame.size.height;
    view_videoContent.frame = _frame;
    
    playerLayer.frame = view_videoContent.bounds;
    
    iv_videoMask.frame = CGRectMake(0, 0, W, H);
    
}

-(void)internalInitalVideoView
{
    if(view_videoContent)
        return;
    
    view_videoContent = [[UIView alloc] init];
    [self.view addSubview:view_videoContent];
    [self.view  sendSubviewToBack:view_videoContent];
}


-(void)internalInitalVideoMask
{
    if(iv_videoMask)
        return;
    UIImage *img = [UIImage imageNamed:@"mask.png"];
    iv_videoMask = [[UIImageView alloc] initWithImage:img];
    [self.view  addSubview:iv_videoMask];
    [self.view  sendSubviewToBack:iv_videoMask];
}

-(void)initVideo
{
    
    NSString *str_filepath = [[NSBundle mainBundle] pathForResource:@"stock-footage-water-waves-fps" ofType:@"mp4"];
    AVURLAsset *videoasset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:str_filepath] options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:videoasset];
    
    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:currentItem];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view_videoContent.layer addSublayer:playerLayer];
    [self playVideo];
}

-(void)playVideo
{
    if(!playerLayer)
        return;
    [playerLayer.player play];
}

-(void)pauseVideo
{
    if(!playerLayer)
        return;
    [playerLayer.player pause];
}


-(void)clearPlayer
{
    if(playerLayer)
        playerLayer = nil;
    [view_videoContent removeFromSuperview];
}


-(void)logoFadeIn
{
    iv_logo.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        
        iv_logo.alpha = 1.0;
    }];
}

//--------end



-(void)go2Agreement
{
    [self clearPlayer];
    
    appDelegate.window.rootViewController = nil;
    appDelegate.window.rootViewController = [[FGAgreementViewController alloc] initWithNibName:@"FGAgreementViewController" bundle:nil];//进入agreement页
    
}

-(void)go2NextPage
{
    [self clearPlayer];
    
    appDelegate.window.rootViewController = nil;
    
    NSNumber *obj = (NSNumber *)[commond getUserDefaults:KEY_APPSTATUS];
    currentAppStatus = [obj intValue];
    NSString *className = @"FGIntroViewController";//如果未注册过 进入注册页
    
    if(currentAppStatus == AppStatus_Default)//进入agreement页
    {
        [self go2Agreement];
        return;
    }
    else if(currentAppStatus >= AppStatus_logged)//如果用户没有读过intro，设置app状态为intro已读
    {
        className = @"FGHomePageViewController";
    }
    else if(currentAppStatus >= AppStatus_introReaded)//如果用户没有读过intro，设置app状态为intro已读
    {
        className = @"FGHomeMenuViewController";
    }
   
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager initNavigation:&nav_main rootControllerName:className];
    [appDelegate initalSlideViewControllerWithRoot:nav_main];
    
    if([className isEqualToString:@"FGHomeMenuViewController"])
    {
        [manager.vc_homeMenu buttonAction_go2Setup:nil ];
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [self clearPlayer];
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetRefreshData) isEqualToString:_str_url])
    {
        if(![[_dic_requestInfo allKeys] containsObject:@"STATUS"])
        {
            [[NetworkManager sharedManager] postRequest_getGraphData:nil];
        }
        
    }
    
    if([HOST(URL_GetData) isEqualToString:_str_url])
    {
        [self go2NextPage];
    }
}

-(void)requestFailedFromNetwork:(NSNotification *)_notification
{
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetRefreshData) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"result"])
        {
            int code = [[[_dic_requestInfo objectForKey:@"result"] objectForKey:@"Code"] intValue];
            if(code == -101)//登录信息已过期，请重新登录！未找到对应设备，请先绑定设备！
            {
                currentAppStatus = AppStatus_agreementReaded;
                [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
                [self performSelector:@selector(go2NextPage) withObject:nil afterDelay:5];
            }
        }
    }

}
@end
