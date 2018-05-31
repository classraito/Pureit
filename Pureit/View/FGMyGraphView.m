//
//  FGMyGraphView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/6.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGMyGraphView.h"
#import "Global.h"
#import "FGDrawGraphBGView.h"
#import "FGDrawGraphChartView.h"

@interface FGMyGraphView()
{
    int currentPage;
}
@end

@implementation FGMyGraphView
@synthesize sv;
@synthesize view_drawGraph_month;
@synthesize view_drawGraph_weeks;
@synthesize view_drawGraph_days;
-(void)awakeFromNib
{
    [super awakeFromNib];
    currentPage = 0;
    [self internalInitalDrawGraphByHours];
    [self internalInitalDrawGraphByDay];
    [self internalInitalDrawGraphByMonth];
    sv.scrollEnabled = NO;
    sv.clipsToBounds = NO;
    self.clipsToBounds = NO;
    self.view_content.clipsToBounds = NO;
    sv.backgroundColor = [UIColor clearColor];
}

-(void)internalInitalDrawGraphByHours
{
    view_drawGraph_days = [[FGDrawGraphBGView alloc] initWithFrame:self.bounds defaultDays:DEFAULTDATAS_DAY];
    [sv addSubview:view_drawGraph_days];
    
}

-(void)internalInitalDrawGraphByDay
{
    view_drawGraph_weeks = [[FGDrawGraphBGView alloc] initWithFrame:self.bounds defaultDays:DEFAULTDATAS_WEEK];
    [sv addSubview:view_drawGraph_weeks];
    
}


-(void)internalInitalDrawGraphByMonth
{
    view_drawGraph_month = [[FGDrawGraphBGView alloc] initWithFrame:self.bounds defaultDays:DEFAULTDATAS_MONTH];
    [sv addSubview:view_drawGraph_month];
}

-(void)bindDataToUI
{
    if(view_drawGraph_days)
    {
        [view_drawGraph_days bindDataToUI];
    }
    if(view_drawGraph_month)
    {
        [view_drawGraph_month bindDataToUI];
    }
    if(view_drawGraph_weeks)
    {
        [view_drawGraph_weeks bindDataToUI];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [view_drawGraph_days resetAnimtaion];
    [view_drawGraph_weeks resetAnimtaion];
    [view_drawGraph_month resetAnimtaion];
    currentPage = scrollView.contentOffset.x / scrollView.frame.size.width ;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    manager.vc_homepgae.view_homeDetail.upc.currentPage = currentPage;
    manager.vc_homepgae.view_homeDetail.sv.contentOffset =  scrollView.contentOffset;
}

-(void)playAnimation
{
    
    if(currentPage == 0)
    {
        [view_drawGraph_days startAnimtaion];
    }
    else if(currentPage == 1)
    {
        [view_drawGraph_weeks startAnimtaion];
    }
    else if(currentPage == 2)
    {
        [view_drawGraph_month startAnimtaion];
    }
}

-(void)resetAnimation
{
    [view_drawGraph_days resetAnimtaion];
    [view_drawGraph_weeks resetAnimtaion];
    [view_drawGraph_month resetAnimtaion];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    currentPage = scrollView.contentOffset.x / scrollView.frame.size.width ;
    [self playAnimation];
}

-(void)drawRect:(CGRect)rect
{
    if(view_drawGraph_days)
        [view_drawGraph_days setNeedsDisplay];
    if(view_drawGraph_weeks)
        [view_drawGraph_weeks setNeedsDisplay];
    if(view_drawGraph_month)
        [view_drawGraph_month setNeedsDisplay];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    sv.frame = self.bounds;
    sv.contentSize = CGSizeMake(sv.frame.size.width * 3, sv.frame.size.height);
    view_drawGraph_days.frame = sv.bounds;
    
    CGRect _frame = view_drawGraph_weeks.frame;
    _frame.origin.x = sv.bounds.size.width;
    view_drawGraph_weeks.frame = _frame;
    
    _frame = view_drawGraph_month.frame;
    _frame.origin.x = sv.bounds.size.width * 2;
    view_drawGraph_month.frame = _frame;
    [self setNeedsDisplay];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    sv.delegate = nil;
    [view_drawGraph_month removeFromSuperview];
    [view_drawGraph_weeks removeFromSuperview];
    [view_drawGraph_days removeFromSuperview];
    view_drawGraph_weeks = nil;
    view_drawGraph_month = nil;
    view_drawGraph_days = nil;
}
@end
