//
//  FGRegisterViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGBaseViewController.h"
#import "FGCustomButton.h"
@interface FGHomeMenuViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
//@property(nonatomic,assign)IBOutlet FGCustomButton *cb_signIn;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_setup;
-(void)buttonAction_go2Setup:(id)_sender;
@end
