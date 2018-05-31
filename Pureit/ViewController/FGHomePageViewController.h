//
//  FGHomePageViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGHomeDetailView.h"
#import "FGHomeScreenView.h"
#import "FGMyRankView.h"
#define DEFAULT_VIDEOWIDTH 1137.0f      //videocontent: 375   2x: 750    3x:1125
#define DEFAULT_VIDEOHEIGHT 640.0f      //videocontent: 211   2x: 422    3x: 633
@interface FGHomePageViewController : FGBaseViewController<UIScrollViewDelegate>
{
    
}
@property(nonatomic,strong)FGHomeScreenView *view_home;
@property(nonatomic,strong)FGHomeDetailView *view_homeDetail;
@property(nonatomic,strong)UIView *view_videoContent;
@property(nonatomic,assign)IBOutlet UIScrollView *sv;
@property(nonatomic,strong)FGMyRankView *view_myRank;
-(void)bindDataToUI;
-(void)cancelRefreshHomepageData;
-(void)startRefreshHomepageData;
-(void)doRefreshHomepageData;
-(void)playVideo;
-(void)pauseVideo;
@end
