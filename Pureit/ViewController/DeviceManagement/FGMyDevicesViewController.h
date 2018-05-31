//
//  FGMyDevicesViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGMyDevicesViewController : FGBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arr_data;
}
@property(nonatomic,assign)IBOutlet UITableView *tb;

@end
