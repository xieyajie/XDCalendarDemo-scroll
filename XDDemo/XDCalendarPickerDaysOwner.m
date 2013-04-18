//
//  XDCalendarPickerDaysOwner.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "XDCalendarPickerDaysOwner.h"
#import "NSDate+Convenience.h"

static XDCalendarPickerDaysOwner *daysOwner = nil;

@interface XDCalendarPickerDaysOwner()
{
    NSDate *_beginDate;
    NSDate *_endDate;
    NSDate *_selectedDate;
    XDDayBlock *_selectedBlock;
}

@end

@implementation XDCalendarPickerDaysOwner

@synthesize selectedBlock = _selectedBlock;

- (id)init
{
    self = [super init];
    if (self)
    {
        _selectedDate = [[NSDate date] copy];
        [self workBeginDateBy:nil];
        [self workEndDateBy:nil];
    }
    return self;
}

+ (XDCalendarPickerDaysOwner *)sharedDaysOwner
{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        daysOwner = [[XDCalendarPickerDaysOwner alloc] init];
    });
    return daysOwner;
}

#pragma mark - set methods

- (void)setBeginDate:(NSDate *)beginDate
{
    if (_beginDate != nil) {
        [_beginDate release];
    }
    
    _beginDate = [beginDate copy];
}

- (void)setEndDate:(NSDate *)endDate
{
    if (_endDate != nil) {
        [_endDate release];
    }
    
    _endDate = [endDate copy];
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    if (_selectedDate != nil) {
        [_selectedDate release];
    }
    
    _selectedDate = [selectedDate copy];
}

#pragma mark - public

- (void)workBeginDateBy:(NSDate *)aDate
{
    if (aDate == nil) {
        aDate = [NSDate date];
    }
    
    int month = [aDate month];
    NSDate *tmpDate = [[aDate offsetMonth:(1 - month)] firstDayOfMonth];
    int dayWeek = [tmpDate firstWeekDayInMonth];
    if (dayWeek > 1) {
        self.beginDate = [tmpDate offsetDay:-(dayWeek - 1)];
    }
    else{
        self.beginDate = tmpDate;
    }
}

- (void)workEndDateBy:(NSDate *)aDate
{
    if (aDate == nil) {
        aDate = [NSDate date];
    }
    
    int month = [aDate month];
    self.endDate = [[[aDate offsetMonth:(13 - month)] firstDayOfMonth] offsetDay:-1];
}

@end
