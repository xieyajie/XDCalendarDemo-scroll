//
//  UIColor+Category.m
//  XDCalendar
//
//  Created by xieyajie on 13-3-19.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (UIColor_Category)

/*
  objective-C不支持16进制的颜色表示，需要转换成rgb表示法
 */
+ (UIColor *)colorWithHexInt: (unsigned)hexInt
{
    int r = (hexInt >> 16) & 0xFF;
	int g = (hexInt >> 8) & 0xFF;
	int b = (hexInt) & 0xFF;
	
	return [UIColor colorWithRed:r / 255.0f
						   green:g / 255.0f
							blue:b / 255.0f
						   alpha:1.0f];
}

//将16进制的表示颜色的字符串转换为rgb
+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSScanner *scanner = [NSScanner scannerWithString: hexString];
    
    unsigned convertNum;
    //scanHexInt:扫描16进制到int
    if (![scanner scanHexInt: &convertNum])
    {
        return nil;
    }
    return [UIColor colorWithHexInt: convertNum];
}


@end
