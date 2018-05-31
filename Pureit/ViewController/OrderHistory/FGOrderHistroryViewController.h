//
//  FGOrderHistroryViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGOrderHistroryViewController : FGBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITableView *tb;
@end
