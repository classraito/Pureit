//
//  FGPureitClubViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/24.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGIntroViewController.h"
@interface FGPureitClubViewController : FGIntroViewController<UIWebViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_tips;
@end
