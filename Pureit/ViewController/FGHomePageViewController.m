//
//  FGHomePageViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGHomePageViewController.h"
#import "Global.h"
#import "FGHomeScreenView.h"
#import "FGHomeDetailView.h"
#import "FGMyGraphView.h"
#import "FGDrawGraphBGView.h"
#import "FGDrawGraphChartView.h"

@interface FGHomePageViewController ()
{
    AVPlayerLayer *playerLayer;
    UIImageView *iv_videoMask;
    CGRect originalFrame_view_myRank;
    int currentPage;
    NSMutableArray *arr_rankDescriptions;
    NSMutableArray *arr_rankTitle;
    NSTimer *timer_updateHomePageData;
}
@end

@implementation FGHomePageViewController
@synthesize view_home;
@synthesize view_homeDetail;
@synthesize view_videoContent;
@synthesize sv;
@synthesize view_myRank;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        currentPage = 0;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseVideo)
                                                     name:UIApplicationWillResignActiveNotification object:nil];//监听是否触发home键挂起程序.
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo)
                                                     name:UIApplicationDidBecomeActiveNotification object:nil];//监听是否重新进入程序程序.
        currentAppStatus = AppStatus_logged;
        [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
        arr_rankTitle = [[NSMutableArray alloc] initWithObjects:
                         multiLanguage(@"Wow!"),
                         multiLanguage(@"Keep Going!"),
                         multiLanguage(@"Buck Up!"),
                         multiLanguage(@"Catch Up!"),nil];
        
        
        arr_rankDescriptions = [[NSMutableArray alloc] initWithObjects:
                                multiLanguage(@"Today your Family is in the top 25% for water consumption amongst all Pureit users."),
                                multiLanguage(@"Today your Family is in the middle 50% for water consumption amongst all Pureit users."),
                                multiLanguage(@"Today your Family is in the bottom 25% for water consumption amongst all Pureit users."),
                                nil];
        
        [[FGLocationManagerWrapper sharedManager] startUpdatingLocation:^(CLLocationDegrees lat, CLLocationDegrees lng) {
        }];
        
    }
    return self;
}

-(void)doRefreshHomepageData
{
    if([[Reachability reachabilityForInternetConnection] isReachable])
    {
        NSMutableDictionary *dic_info = [NSMutableDictionary dictionary];
        [dic_info setObject:@"REFRESH" forKey:@"STATUS"];
        [[NetworkManager sharedManager] postRequest_getHomePageData:dic_info];
    }
}

-(void)cancelRefreshHomepageData
{
    if(!timer_updateHomePageData)
        return;
    [timer_updateHomePageData invalidate];
    timer_updateHomePageData = nil;
}

-(void)startRefreshHomepageData
{
    if(timer_updateHomePageData)
        return;
    timer_updateHomePageData = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(doRefreshHomepageData) userInfo:nil repeats:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.backgroundColor = [UIColor clearColor];
    [self.view_topPanel.iv_back removeFromSuperview];
    self.view_topPanel.iv_back = nil;
    [self.view_topPanel.btn_back removeFromSuperview];
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.btn_settings.userInteractionEnabled = YES;
    
    appDelegate.slideViewController.needSwipeShowMenu=NO;//默认开启的可滑动展示
    // Do any additional setup after loading the view from its nib.
    
    [self internalInitalHomeScreenView];
    [self internalInitalMyRankView];
    [self internalInitalHomeDeatailView];
    
    [self internalInitalVideoMask];
    [self internalInitalVideoView];
    
    
    [self initVideo];
    [[NetworkManager sharedManager] postRequest_getGraphData:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startRefreshHomepageData]; //TODO:fix it
    if(view_myRank)
    {
        [view_myRank tipsFadeOut];
    }
    if(view_home)
    {
        [view_home appDidToBackground];
        [view_home appDidActive];
    }
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    [self setupScrollView];
    
    CGRect _frame = view_home.frame;
    _frame.size.width = W;
    _frame.size.height = H;
    view_home.frame = _frame;
    
    _frame = view_homeDetail.frame;
    _frame.origin.y = H;
    _frame.size.width = W;
    _frame.size.height = H;
    view_homeDetail.frame = _frame;
    
    _frame = view_videoContent.frame;
    _frame.origin.x = 0;
    _frame.size.width = W;
    _frame.size.height = W / DEFAULT_VIDEOWIDTH * DEFAULT_VIDEOHEIGHT;
    _frame.origin.y = H - _frame.size.height;
    view_videoContent.frame = _frame;
    NSLog(@"view_videoContent.bounds = %@",NSStringFromCGRect(view_videoContent.bounds));
    playerLayer.frame = view_videoContent.bounds;
    
    iv_videoMask.frame = CGRectMake(0, 0, W, H);
}

-(void)internalInitalHomeScreenView
{
    if(view_home)
        return;
    
    view_home = (FGHomeScreenView *)[[[NSBundle mainBundle] loadNibNamed:@"FGHomeScreenView" owner:nil options:nil] objectAtIndex:0];
    [sv addSubview:view_home];
}

-(void)internalInitalHomeDeatailView
{
    if(view_homeDetail)
        return;
    
    view_homeDetail = (FGHomeDetailView *)[[[NSBundle mainBundle] loadNibNamed:@"FGHomeDetailView" owner:nil options:nil] objectAtIndex:0];
    [sv addSubview:view_homeDetail];
    [sv bringSubviewToFront:view_myRank];
}

-(void)internalInitalVideoView
{
    if(view_videoContent)
        return;
    
    view_videoContent = [[UIView alloc] init];
    [view_home addSubview:view_videoContent];
    [view_home sendSubviewToBack:view_videoContent];
}

-(void)internalInitalVideoMask
{
    if(iv_videoMask)
        return;
    UIImage *img = [UIImage imageNamed:@"mask.png"];
    iv_videoMask = [[UIImageView alloc] initWithImage:img];
    [view_home addSubview:iv_videoMask];
    [view_home sendSubviewToBack:iv_videoMask];
}

-(void)internalInitalMyRankView
{
    if(view_myRank)
        return;
    view_myRank = (FGMyRankView *)[[[NSBundle mainBundle] loadNibNamed:@"FGMyRankView" owner:nil options:nil] objectAtIndex:0];
    view_myRank.LINE_LENGTH = 14;
    [sv addSubview:view_myRank];
    [self internalLayoutMyRankView];
    [self bindDataToUI];
    
    
}

-(void)internalLayoutMyRankView
{
    if(!view_myRank)
        return;
    CGFloat cellWidth = 250 * ratioW;
    view_myRank.frame = CGRectMake(0, 0, cellWidth , cellWidth );
    view_myRank.center = CGPointMake(W / 2, H/2 - 80 * ratioH);
    [view_myRank setNeedsLayout];
    view_myRank.layer.anchorPoint = CGPointMake(.5, .5);
    originalFrame_view_myRank = view_myRank.frame;
    
}

-(void)bindDataToUI
{
    if(!view_myRank)
        return;
    DataManager *datamanager = [DataManager sharedManager];
    NSMutableDictionary *dic_info = [datamanager getDataByUrl:HOST(URL_GetRefreshData)];
    NSLog(@"dic_info = %@",dic_info);
    CGFloat percent = [[dic_info objectForKey:@"Score"] floatValue];
    int rank = [[dic_info objectForKey:@"Rank"] intValue];
    int ranklevel = 0;
    if(rank >= 75)
        ranklevel = 0;
    else if(rank > 25)
        ranklevel = 1;
    else
        ranklevel = 2;
    view_myRank.lb_rankDescription.text = [arr_rankDescriptions objectAtIndex:ranklevel];
    [view_myRank.lb_rankDescription setLineSpace:4 alignment:NSTextAlignmentCenter];
    switch (ranklevel) {
        case 0:
            [view_myRank.lb_rankDescription setCustomColor:rank_green searchText:multiLanguage(@"top 25%") font:view_myRank.lb_rankDescription.font addToAttrText:view_myRank.lb_rankDescription.attributedText];
            break;
            
        case 1:
            [view_myRank.lb_rankDescription setCustomColor:rank_green searchText:multiLanguage(@"middle 50%") font:view_myRank.lb_rankDescription.font addToAttrText:view_myRank.lb_rankDescription.attributedText];
            break;
            
        case 2:
            [view_myRank.lb_rankDescription setCustomColor:rank_red searchText:multiLanguage(@"bottom 25%") font:view_myRank.lb_rankDescription.font addToAttrText:view_myRank.lb_rankDescription.attributedText];
            break;
    }
    
    
    
    view_myRank.lb_rankTitle.text = [arr_rankTitle objectAtIndex:ranklevel];
    
//    percent = 150;
    //TODO::<peng> fixed crash percent>100
    percent = percent < 100 ? percent : 100;
    
    [view_myRank playCircleAnimationWithPercent:percent / 100.0f];
}

-(void)setupScrollView
{
    sv.frame = CGRectMake(0, 0, W, H);
    sv.contentSize = CGSizeMake(W, H * 2);
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

-(void)playerItemDidReachEnd:(NSNotification *)notification {
    if(playerLayer)
    {
        if(playerLayer.player.status == AVPlayerItemStatusReadyToPlay)
        {
            [playerLayer.player.currentItem seekToTime: kCMTimeZero
                                       toleranceBefore: kCMTimeZero
                                        toleranceAfter: kCMTimeZero
                                     completionHandler: ^(BOOL finished)
             {
                 if(finished)
                 {
                     [playerLayer.player play];
                 }
             }];
        }
        return ;
    }
}

-(void)dealloc
{
    NSLog(@"::::>dealloc %s %d",__FUNCTION__,__LINE__);
    sv.delegate = nil;
    sv = nil;
    [self cancelRefreshHomepageData];
    if(view_home)
        view_home.iv_arrowDown = nil;
    if(view_myRank)
        view_myRank.lb_tips = nil;
    view_homeDetail = nil;
    view_home = nil;
    view_videoContent = nil;
    iv_videoMask = nil;
    arr_rankDescriptions = nil;
    arr_rankTitle = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY >= H)
    {
        return;
    }
    CGRect _frame = view_home.frame;
    _frame.origin.y = scrollView.contentOffset.y - scrollView.contentOffset.y * .5;
    view_home.frame = _frame;
    
    view_home.alpha = (1 - scrollView.contentOffset.y / view_home.frame.size.height);
    CGFloat scaleRange = 1 - offsetY / sv.frame.size.height * .4;
    
    view_myRank.transform = CGAffineTransformMakeScale(scaleRange, scaleRange);
    CGFloat dy = 55;
    if(H<=480)
    {
        dy = 35;
    }
    CGFloat origianlYRange = originalFrame_view_myRank.origin.y - (offsetY / sv.frame.size.height) * (originalFrame_view_myRank.origin.y - dy * ratioH);
    view_myRank.center = CGPointMake(W/2,origianlYRange + view_myRank.frame.size.height / 2 + offsetY - 30);//TODO::<peng> 2014_4_15 多 -30，以便向下接头能够显示
    
    view_homeDetail.iv_arrowDown.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int pageIndex = scrollView.contentOffset.y / scrollView.frame.size.height ;
    if(pageIndex == 1 )
    {
        view_homeDetail.iv_arrowDown.hidden = NO;
        if(currentPage != pageIndex)
        {
            view_myRank.pageIndex = pageIndex;
            [view_homeDetail.view_myGraph playAnimation];
            [self pauseVideo];
            currentPage = 1;
        }
        
    }
    else if(pageIndex == 0 && currentPage != pageIndex)
    {
        view_myRank.pageIndex = pageIndex;
        [view_homeDetail.view_myGraph resetAnimation];
        [self playVideo];
        currentPage = 0;
    }
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetRefreshData) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"STATUS"])
        {
            [self bindDataToUI];
            if(view_home)
            {
                [view_home bindDataToUI];
            }
        }
    }
    
    if([HOST(URL_GetData) isEqualToString:_str_url])
    {
        [view_homeDetail.view_myGraph bindDataToUI];
        if(currentPage==1)
        {
            [view_homeDetail.view_myGraph resetAnimation];
            [view_homeDetail.view_myGraph playAnimation];
        }
        
    }//获得首页图形数据
    
    
}

@end
