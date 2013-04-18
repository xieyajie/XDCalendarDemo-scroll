//
//  XDCalendarPickerDaysOwner.h
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XDDayBlock.h"

@interface XDCalendarPickerDaysOwner : NSObject

@property (nonatomic, copy) NSDate *beginDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, copy) NSDate *selectedDate;

@property (nonatomic, retain) XDDayBlock *selectedBlock;

+ (XDCalendarPickerDaysOwner *)sharedDaysOwner;

- (void)workBeginDateBy:(NSDate *)aDate;

- (void)workEndDateBy:(NSDate *)aDate;

@end
