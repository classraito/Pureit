//
//  Font.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/11.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#define FONT_ULTRALIGHT @"HelveticaNeueLTStd-UltLt"
#define FONT_LIGHT @"SourceHanSansCN-Light"
#define FONT_NORMAL @"SourceHanSansCN-Regular"
#define FONT_BOLD @"SourceHanSansCN-Bold"
#define FONT_BUTTON @"SourceHanSansCN-Heavy"
#define font(fontname,fSize)        [UIFont fontWithName:fontname size: (int)((float)fSize * (W / 414.0f))]   //我这里字体大小是按照iphone 6 plus取的，这个宏可以按照屏幕宽度的变化而变化字体的尺寸
//fSize是磅值(pt) 像素磅值转换公式:px=pt*dpi/72   pt=px*72/dpi 美工如果给的是px(像素) 那么他必须给dpi 不然无法推算出 pt
