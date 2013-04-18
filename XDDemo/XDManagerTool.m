//
//  XDManagerTool.m
//  Lianxi
//
//  Created by xieyajie on 13-4-11.
//  Copyright (c) 2013年 TIXA. All rights reserved.
//

#import "XDManagerTool.h"
//#import "Reachability.h"

static XDManagerTool *sharedTool = nil;

@interface XDManagerTool()
{
    NSDateFormatter *_dateFormatter1;
    NSDateFormatter *_dateFormatter2;
}

@end

@implementation XDManagerTool

- (id)init
{
    self = [super init];
    if (self)
    {
        _dateFormatter1 = [[NSDateFormatter alloc] init];
        _dateFormatter1.dateFormat = @"yyyy-MM-dd";
        
        _dateFormatter2 = [[NSDateFormatter alloc] init];
        _dateFormatter2.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    }
    
    return self;
}

#pragma mark - Class methods

+ (XDManagerTool *)sharedTool
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        sharedTool = [[XDManagerTool alloc] init];
    });
    return sharedTool;
}

#pragma mark - public

- (NSDate *)ConvertToZeroInMorning:(NSDate *)aDate
{
    NSString *timeStr = [NSString stringWithFormat:@"%@ %@", [_dateFormatter1 stringFromDate: aDate], @"00:00:00"];
    return [_dateFormatter2 dateFromString:timeStr];
}

+ (UIImage *)imageFromView:(UIView *)aView
{
//    CGSize size = CGSizeMake(aView.bo                                                                                                                                                                                                                                                                                                                                                         unds.size.width * [UIScreen mainScreen].scale, aView.bounds.size.height * [UIScreen mainScreen].scale);
    
//    UIGraphicsBeginImageContext(CGSizeMake(320, size.height));
//    CGContextRef c = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(c, 0, -aView.frame.origin.y);    //shift everything up by 40px when drawing.
//    [aView.layer renderInContext:c];
//    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
