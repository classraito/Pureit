//
//  FGIntroViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomButton.h"
@interface FGIntroViewController : FGBaseViewController<UIScrollViewDelegate>
{
    NSMutableArray *arr_titles;
    NSMutableArray *arr_descriptions;
}
@property(nonatomic,strong)IBOutlet FGCustomButton *cb_skip;
@property(nonatomic,assign)IBOutlet UIScrollView *sv;
@property(nonatomic,assign)IBOutlet UIPageControl *pc;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr_left;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr_right;
-(void)go2NextLogicWithAnimate:(BOOL)_animate;
-(void)internalInitalDatas;
@end
