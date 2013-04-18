//
//  NSDate+Convenience.h
//  XDCalendar
//
//  Created by xieyajie on 13-3-19.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    XDDateCompareSmaller = -1,
    XDDateCompareEqual = 0,
    XDDateComparePlurality
}XDDateCompare;


@interface NSDate (Convenience)

- (int)year;

- (int)month;

- (int)day;

- (int)week;

- (int)countOfDaysInMonth;

- (int)countOfWeeksInMonth;

- (int)firstWeekDayInMonth;

- (int)weekInMonth;

- (int)weekInYear;

- (NSDate *)offsetMonth:(int)numMonths;

- (NSDate *)offsetDay:(int)numDays;

- (BOOL)isEqualToDate: (NSDate *)aDate;

- (NSInteger)compareWithDate: (NSDate *)aDate;

- (NSDate *)firstDayOfMonth;

@end
