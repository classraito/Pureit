//
//  FGLoginUpdateProfileViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterStepViewController.h"
#import "FGUpdateProfileVIew.h"
typedef enum {
    UserInfoBy_WeChat,
    UserInfoBy_Weibo,
    UserInfoBy_AppRegisted,
    UserInfoBy_WebAPI
}UserInfoBy;

@interface FGLoginUpdateProfileViewController : FGRegisterStepViewController<FGRegisterProfileViewDelegate>
{
    FGUpdateProfileVIew *view_updateprofile;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoBy:(UserInfoBy)_userinfoBy;
@end
