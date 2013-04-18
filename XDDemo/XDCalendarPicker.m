//
//  XDCalendarPicker.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "XDCalendarPicker.h"
#import "XDCalendarPickerDaysOwner.h"
#import "XDCalendarPickerProvider.h"
#import "LocalDefine.h"

#define kSignViewHeight 25
#define kCalendarDayBlockWidth 46
#define kCalendarDayBlockHeight 46

@interface XDCalendarPicker ()
{
    UIView *_signView;
    UITableView *_tableView;
    XDCalendarPickerProvider *_calendarProvider;
}

@property (nonatomic, retain) UIView *signView;

@property (nonatomic, retain) XDCalendarPickerProvider *calendarProvider;

@end

@implementation XDCalendarPicker

@synthesize signView = _signView;
@synthesize tableView = _tableView;
@synthesize calendarProvider = _calendarProvider;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kSignViewHeight)];
        _signView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_signBg.png"]];
        NSArray *weekSymbol = [[NSArray alloc] initWithObjects: @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
        for (int i = 0; i < weekSymbol.count; i++)
        {
            NSString *daySymbol = (NSString *)[weekSymbol objectAtIndex: i];
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(kCalendarDayBlockWidth * i, 0, kCalendarDayBlockWidth, kSignViewHeight)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize: 12.0];;
            label.text = daySymbol;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = KTextAlignmentCenter;
            [_signView addSubview: label];
            [label release];
        }
        [weekSymbol release];
        [self addSubview:_signView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSignViewHeight, frame.size.width, frame.size.height - kSignViewHeight)];
        _tableView.rowHeight = kCalendarDayBlockHeight;
        _tableView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
        [self addSubview:_tableView];
        
        _calendarProvider = [[XDCalendarPickerProvider alloc] init];
        _tableView.delegate = _calendarProvider;
        _tableView.dataSource = _calendarProvider;
        _calendarProvider.tableView = _tableView;
        
        [XDCalendarPickerDaysOwner sharedDaysOwner];
        
        self.clipsToBounds = YES;
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.masksToBounds = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
