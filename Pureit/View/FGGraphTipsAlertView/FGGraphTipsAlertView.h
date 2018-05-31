//
//  FGGraphTipsAlertView.h
//  Pureit
//
//  Created by Ryan Gong on 16/5/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGGraphTipsAlertView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIView *view_bg;
@property(nonatomic,assign)IBOutlet UIView *view_alertBox;
@property(nonatomic,assign)IBOutlet UIImageView *iv_bg;
@property(nonatomic,assign)IBOutlet UILabel *lb_top;
@property(nonatomic,assign)IBOutlet UILabel *lb_bottom;
@property(nonatomic,assign)IBOutlet UIImageView *iv_checkBox;
@property(nonatomic,assign)IBOutlet UIImageView *iv_close;
@property(nonatomic,assign)IBOutlet UIButton *btn_close;
@property(nonatomic,assign)IBOutlet UIButton *btn_checkBox;
-(void)show;
-(void)setupWithTitle:(NSString*)title message:(NSString*)message andCallBack:(void (^)(FGGraphTipsAlertView *alertView, NSInteger buttonIndex))callBackBlock;
-(IBAction)buttonAction_checkBox:(UIButton *)_sender;
-(IBAction)buttonAction_close:(UIButton *)_sender;
@end
