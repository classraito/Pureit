//
//  FGOrderHistroryViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGOrderHistroryViewController.h"
#import "Global.h"
#import "FGOrderHistroyTableViewCell.h"
#import "DataManager.h"
@interface FGOrderHistroryViewController ()
{
    NSMutableArray *arr_data;
}
@end

@implementation FGOrderHistroryViewController
@synthesize tb;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.str_title = multiLanguage(@"Order History");
    self.view_topPanel.lb_title.font = font(FONT_BOLD, 24);
    tb.delegate = self;
    tb.dataSource = self;
    tb.allowsSelection = YES;
    [commond useDefaultRatioToScaleView:tb];
    [self bindDataToUI];//TODO: fix it
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
}

-(void)bindDataToUI
{
    DataManager *manager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [manager getDataByUrl:HOST(URL_OrderHistory)];
    if(_dic_data && [_dic_data count]>0)
    {
        arr_data = [_dic_data objectForKey:@"Records"];
    
        [tb reloadData];
        [tb setNeedsDisplay];
    }
    NSLog(@"arr_data = %@",arr_data);
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_data = nil;
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_OrderHistory) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
}


#pragma mark - UITableViewDelegate
/*table cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 150;
}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [arr_data count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
        NSString *CellIdentifier = @"FGOrderHistroyTableViewCell1";
        FGOrderHistroyTableViewCell *cell = (FGOrderHistroyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FGOrderHistroyTableViewCell" owner:self options:nil];
            cell = (FGOrderHistroyTableViewCell *)[nib objectAtIndex:0];
        }
        NSMutableDictionary *_dic_singleData = [arr_data objectAtIndex:indexPath.row];
    
        cell.lb_gkk_name.text = [_dic_singleData objectForKey:@"Name"];
        cell.lb_gkk_ordertime.text = [_dic_singleData objectForKey:@"Time"];
//    cell.iv_thumbnail.image = [UIImage imageNamed:@"gkk.jpg"]; 
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
   
}
@end
