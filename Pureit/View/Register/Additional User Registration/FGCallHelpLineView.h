//
//  FGCallHelpLineView.h
//  Pureit
//
//  Created by PengLei on 16/4/13.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGCallHelpLineView : UIView

@property (assign, nonatomic) IBOutlet UIView *vi_maskview;

@property (assign, nonatomic) IBOutlet UIView *vi_contentview;
@property (assign, nonatomic) IBOutlet UIImageView *iv_close;
@property (assign, nonatomic) IBOutlet UIImageView *iv_phone_call;

@property (assign, nonatomic) IBOutlet UILabel *lb_call_helpline;
@property (assign, nonatomic) IBOutlet UILabel *lb_notice;
@property (assign, nonatomic) IBOutlet UIButton *btn_call_helpline;
@property (assign, nonatomic) IBOutlet UIButton *btn_close;

- (IBAction)action_buttonCallHelp:(id)sender;

- (IBAction)action_buttonClose:(id)sender;

@end
