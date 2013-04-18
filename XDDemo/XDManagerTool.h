//
//  XDManagerTool.h
//  Lianxi
//
//  Created by xieyajie on 13-4-11.
//  Copyright (c) 2013年 TIXA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface XDManagerTool : NSObject

+ (XDManagerTool *)sharedTool;

/*
 *将aDate转为该天零点
 */
- (NSDate *)ConvertToZeroInMorning:(NSDate *)aDate;

/*
 *根据view生成图片
*/
+ (UIImage *)imageFromView:(UIView *)aView;

@end
