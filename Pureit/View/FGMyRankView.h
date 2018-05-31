//
//  FGMyRankView.h
//  ;
//
//  Created by Ryan Gong on 16/1/6.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphBaseView.h"
#import "ADTickerLabel.h"
#define rank_lightgreen rgb(47, 242, 44)
#define rank_green rgb(26, 191, 11)
#define rank_yellow rgb(238,140,56)
#define rank_red rgb(250,58,60)
@interface FGMyRankView : FGDrawGraphBaseView<UIGestureRecognizerDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_subtitle;
@property(nonatomic,assign)IBOutlet UIView *view_score;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UILabel *lb_rankDescription;
@property(nonatomic,assign)IBOutlet UILabel *lb_rankTitle;
@property(nonatomic,assign)IBOutlet UIButton *btn;
@property(nonatomic,assign)IBOutlet UILabel *lb_tips;
@property int LINE_LENGTH;
@property CGFloat percent;
@property int pageIndex;
-(void)playCircleAnimationWithPercent:(CGFloat)_percent;
-(void)stopCircleAnimtaion;
-(void)playCircleAnimationWithPercent:(CGFloat)_percent isEqualLineLength:(BOOL)_isEqualLineLength;
-(IBAction)buttonAction_switch:(id)_sender;
-(void)tipsFadeOut;
@end
