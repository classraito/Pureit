//
//  Scan_VC.h
//  仿支付宝
//
//  Created by 张国兵 on 15/12/9.
//  Copyright © 2015年 zhangguobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ScanVCDelegate<NSObject>
-(void)didScanQRCode:(NSString *)_str_qrCode;
@end


@interface Scan_VC : UIViewController
{
    
}
@property(nonatomic,assign)id<ScanVCDelegate> delegate;
@end
