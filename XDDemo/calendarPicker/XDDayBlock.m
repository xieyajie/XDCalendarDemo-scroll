//
//  XDDayBlock.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "XDDayBlock.h"
#import "NSDate+Convenience.h"
#import "XDCalendarPickerDaysOwner.h"
#import "LocalDefine.h"

@interface XDDayBlock()
{
    NSDateFormatter *_dayFormatter;
    NSDate *_blockDate;
    
    UILabel *_movingLabel;
}

@property (nonatomic, retain) UILabel *movingLabel;

@end

@implementation XDDayBlock

@synthesize blockDate = _blockDate;
@synthesize blockState = _blockState;

@synthesize movingLabel = _movingLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _dayFormatter = [[NSDateFormatter alloc] init];
        _dayFormatter.dateFormat = @"d";
        
        self.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}

/*
 *size:要生成图片的区域
 *start：颜色开始的值
 *end：颜色结束的值
 *centre：要绘制区域的中心点
 *radius：CGGradientDrawingOptions
 */
- (UIImage *)radialGradientImage:(CGSize)size start:(float)start end:(float)end centre:(CGPoint)centre radius:(float)radius {
    // Initialise
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    
    // Create the gradient's colours
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { start,start,start, 1.0,  // Start color
        end,end,end, 1.0 }; // End color
    
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
    
    // Normalise the 0-1 ranged inputs to the width of the image
    CGPoint myCentrePoint = CGPointMake(centre.x * size.width, centre.y * size.height);
    float myRadius = MIN(size.width, size.height) * radius;
    
    // Draw
    CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                 0, myCentrePoint, myRadius,
                                 kCGGradientDrawsAfterEndLocation);
    
    // Grab it as an autoreleased image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Clean up
    CGColorSpaceRelease(myColorspace); 
    CGGradientRelease(myGradient); 
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - get methods

- (UILabel *)movingLabel
{
    if (_movingLabel == nil) {
        _movingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - 35) / 2, 0, 35, self.bounds.size.height)];
        _movingLabel.numberOfLines = 0;
        _movingLabel.backgroundColor = [UIColor clearColor];
        _movingLabel.textAlignment = KTextAlignmentCenter;
        _movingLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _movingLabel;
}

#pragma mark - set methods

- (void)setBlockDate:(NSDate *)aDate
{
    _blockDate = [aDate retain];
    [self setBlockInfo];
}

- (void)setBlockState:(XDDayBlockState)state
{
    _blockState = state;
    self.selected = NO;
    
    NSDate *selectedDate = nil;
    switch (_blockState) {
        case XDDayBlockStateNoraml:
            [self setBlocksStyleNormal];
            break;
        case XDDayBlockStateSelected:
            self.selected = YES;
            if ([XDCalendarPickerDaysOwner sharedDaysOwner].selectedBlock == nil) {
                selectedDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedDate];
                if ([_blockDate compareWithDate:selectedDate] == XDDateCompareEqual) {
                    [XDCalendarPickerDaysOwner sharedDaysOwner].selectedBlock = self;
                }
            }
            [self setBlocksStyleNormal];
            break;
        case XDDayBlockStateMoving:
            [self setBlockStyleMoving];
            break;
            
        default:
            break;
    }
}

#pragma mark - private: The block information

- (UIImage *)imageForNormal
{
    int weeks = [_blockDate countOfWeeksInMonth];
    int selfWeek = [_blockDate weekInMonth];
    CGFloat beginRGB = kColorBase - (kColorDValue / weeks) * (selfWeek - 1);
    CGFloat endRGB = kColorBase - (kColorDValue / weeks) * selfWeek;
    
    return [self radialGradientImage:self.bounds.size start:beginRGB / 255.0 end:endRGB / 255.0 centre:self.center radius:(kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation)];
}

- (void)setBlockInfoToday
{
    [self setBackgroundImage:[UIImage imageNamed:@"calendar_todayBg.png"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"calendar_todaySelectedBg.png"] forState:UIControlStateSelected];
}

- (void)setBlockInfo
{
    [self setTitle:[_dayFormatter stringFromDate:_blockDate] forState:UIControlStateNormal];
    
    if ([_blockDate isEqualToDate:[NSDate date]]) {
        [self setBlockInfoToday];
        return;
    }
    
    [self setBackgroundImage:[self imageForNormal] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"calendar_blockSelectedBg.png"] forState:UIControlStateSelected];
}

#pragma mark - private: The style of the block

- (void)setBlocksStyleNormal
{
    [self.movingLabel removeFromSuperview];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.titleLabel.alpha = 1.0;
}

- (void)setBlockStyleMoving
{
    [self.movingLabel removeFromSuperview];
    UIColor *color = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateSelected];
    self.titleLabel.alpha = 0.4;

    NSDate *selectedDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedDate];
    if ([_blockDate compareWithDate:selectedDate] == XDDateCompareEqual) {
        [XDCalendarPickerDaysOwner sharedDaysOwner].selectedBlock = self;
        self.selected = YES;
    }
    
    int row = [_blockDate countOfWeeksInMonth] / 2 + 1;
    if ([_blockDate weekInMonth] == row && [_blockDate week] == 5) {
        self.movingLabel.text = [NSString stringWithFormat:@"%i%i月", [_blockDate year], [_blockDate month]];
        [self addSubview: self.movingLabel];
    }
}

#pragma mark - block click

- (void)clickAction:(id)sender
{
    if (!self.selected) {
        self.selected = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationSelectedDay object:self userInfo:nil];
    }
}

@end
