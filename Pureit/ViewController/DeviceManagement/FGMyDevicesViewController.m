//
//  FGMyDevicesViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGMyDevicesViewController.h"
#import "Global.h"
#import "FGResetDevicePopupView.h"
#import "FGMyDevicesTableViewCell.h"
@interface FGMyDevicesViewController ()
{
    
    FGResetDevicePopupView *view_resetPopup;
    NSInteger currentDefaultDeviceIndex;
}
@end

@implementation FGMyDevicesViewController
@synthesize tb;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(228, 229, 230);
    
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.str_title  = multiLanguage(@"My Devices");
    
    // Do any additional setup after loading the view from its nib.
    [commond useDefaultRatioToScaleView:tb];
    arr_data = [[NSMutableArray alloc] init];
    tb.delegate = self;
    tb.dataSource = self;
    [[NetworkManager sharedManager] postRequest_getDevices:nil];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager.vc_homepgae cancelRefreshHomepageData];
}

-(void)buttonAction_back:(id)_sender;
{
    [appDelegate.slideViewController showRightViewController:YES];
    [nav_main popViewControllerAnimated:YES];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_data = nil;
}

-(void)bindDataToUI
{
    [arr_data removeAllObjects];
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [dataManager getDataByUrl:HOST(URL_GetDevices)];
    arr_data = [_dic_data objectForKey:@"List"];
    [tb reloadData];
}

-(void)internalInitalPopupView:(NSString *)_str_devicdId
{
    if(view_resetPopup)
        return;

    view_resetPopup = (FGResetDevicePopupView *)[[[NSBundle mainBundle] loadNibNamed:@"FGResetDevicePopupView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_resetPopup];
    view_resetPopup.str_deviceID = _str_devicdId;
    [view_resetPopup.cb_ok.button addTarget:self action:@selector(buttonAction_ok:) forControlEvents:UIControlEventTouchUpInside ];
//    [view_resetPopup showPopup];
    [self.view bringSubviewToFront:view_resetPopup];
}

-(void)internalLayoutResetPopupView
{
    if(!view_resetPopup)
        return;
    
     view_resetPopup.frame = CGRectMake(0, 0, W, H);
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    [self internalLayoutResetPopupView];
    
}

#pragma mark - UITableViewDelegate
/*table cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 310 * ratioH;
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
    NSString *CellIdentifier = @"FGMyDevicesTableViewCell1";
    FGMyDevicesTableViewCell *cell = (FGMyDevicesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FGMyDevicesTableViewCell" owner:self options:nil];
        cell = (FGMyDevicesTableViewCell *)[nib objectAtIndex:0];
    }
    NSMutableDictionary *_dic_singleData = [arr_data objectAtIndex:indexPath.row];
    cell.lb_value_deviceId.text = [_dic_singleData objectForKey:@"SN"];
    cell.iv_setDefault.highlighted = [[_dic_singleData objectForKey:@"Type"] intValue] == 2 ? YES:NO;
    cell.btn_setDefault.tag = indexPath.row + 1;
    cell.btn_delete.tag = indexPath.row + 1;
    cell.btn_reset.tag = indexPath.row + 1;
    [cell.btn_setDefault addTarget:self action:@selector(buttonAction_setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_delete addTarget:self action:@selector(buttonAction_delete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_reset addTarget:self action:@selector(buttonAction_reset:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)buttonAction_ok:(UIButton *)_btn
{
    if(!view_resetPopup)
        return;
    [view_resetPopup removeFromSuperview];
    view_resetPopup  = nil;
    
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGResetWifiViewController" inNavigation:nav_main];
}

-(void)buttonAction_reset:(UIButton *)_btn
{
    NSInteger index = _btn.tag - 1;
    NSMutableDictionary *_dic_singleData = [arr_data objectAtIndex:index];
    NSString *_str_deviceId = [_dic_singleData objectForKey:@"SN"];
    [self internalInitalPopupView:_str_deviceId];
}

-(void)buttonAction_delete:(UIButton *)_btn
{
     NSInteger index = _btn.tag - 1;
    NSMutableDictionary *_dic_singleData = [arr_data objectAtIndex:index];
    NSString *_str_deviceId = [_dic_singleData objectForKey:@"SN"];
    
    NSArray * buttons = @[multiLanguage(@"YES"),multiLanguage(@"NO")];
    [commond alertWithButtons:buttons title:multiLanguage(@"警告") message:[NSString stringWithFormat:multiLanguage(@"Are you sure you want to delete this device [%@] from the app?"),_str_deviceId] callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 0)
        {
            
            [[NetworkManager sharedManager] postRequest_deleteDevice:_str_deviceId userinfo:nil];
        }
        
    }];
}

-(void)buttonAction_setDefault:(UIButton *)_btn
{
    NSInteger index = _btn.tag - 1;
    
    
    NSMutableDictionary *_dic_singleData = [arr_data objectAtIndex:index];
    int defautType = [[_dic_singleData objectForKey:@"Type"] intValue];
    
    if(defautType == 2)
        return;
    
    NSString *_str_deviceId = [_dic_singleData objectForKey:@"SN"];
    currentDefaultDeviceIndex = index;
    NSArray * buttons = @[multiLanguage(@"YES"),multiLanguage(@"NO")];

    [commond alertWithButtons:buttons title:multiLanguage(@"警告") message:[NSString stringWithFormat:multiLanguage(@"Are you sure you want switch to device [%@]?"),_str_deviceId] callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex == 0)
        {
            [[NetworkManager sharedManager] postRequest_setDefaultDevice:_str_deviceId userinfo:nil];
        }
        
    }];
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetDevices) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
    if([HOST(URL_DeleteDevices) isEqualToString:_str_url])
    {
        
        if([arr_data count] == 1)
        {
            FGControllerManager *manager = [FGControllerManager sharedManager];
            [manager.vc_homepgae cancelRefreshHomepageData];
            currentAppStatus = AppStatus_agreementReaded;
            [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
            [nav_main popToRootViewControllerAnimated:NO];
            nav_main = nil;
            manager.vc_homepgae = nil;
            [appDelegate go2Loading];
        }
        else
        {
            [nav_main popViewControllerAnimated:YES];
            [[NetworkManager sharedManager] postRequest_getGraphData:nil];
            [NetworkManager sharedManager].refreshCode = 0;
            FGControllerManager *manager = [FGControllerManager sharedManager];
            [manager.vc_homepgae doRefreshHomepageData];
        }
       
    }
    if([HOST(URL_SetDefaultDevice) isEqualToString:_str_url])
    {
        [nav_main popViewControllerAnimated:YES];
        [[NetworkManager sharedManager] postRequest_getGraphData:nil];
        [NetworkManager sharedManager].refreshCode = 0;
        FGControllerManager *manager = [FGControllerManager sharedManager];
        [manager.vc_homepgae doRefreshHomepageData];
        
    }

}
@end
