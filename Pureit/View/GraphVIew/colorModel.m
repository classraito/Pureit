//
//  colorModel.m
//  Kline
//
//  Created by zhaomingxi on 14-2-9.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import "colorModel.h"
colorModel *rgb;
@implementation colorModel
+(colorModel *)sharedColorModel
{
    @synchronized(self)     {
        if(!rgb)
        {
            rgb=[[colorModel alloc]init];
            NSLog(@"init colorModel");
            return rgb;
        }
    }
    return rgb;
}

+(id)alloc
{
    @synchronized(self)     {
        NSAssert(rgb == nil, @"企圖創建一個singleton模式下的colorModel");
        return [super alloc];
    }
    return nil;
}
@end
