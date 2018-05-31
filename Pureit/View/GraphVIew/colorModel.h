//
//  colorModel.h
//  Kline
//
//  Created by zhaomingxi on 14-2-9.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class colorModel;
@interface colorModel : NSObject
 @property (nonatomic,assign) CGFloat R;
 @property (nonatomic,assign) CGFloat G;
 @property (nonatomic,assign) CGFloat B;
 @property (nonatomic,assign) CGFloat alpha;
+(colorModel *)sharedColorModel;
 @end
