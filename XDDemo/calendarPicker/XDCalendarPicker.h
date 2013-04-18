//
//  XDCalendarPicker.h
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum
{
    XDCalendarPickerStyleDays = 0,
    XDCalendarPickerStyleWeeks
}XDCalendarPickerStyle;

@protocol XDCalendarPickerDelegate;
@interface XDCalendarPicker : UIView
{
    id<XDCalendarPickerDelegate> _delegate;
}

@property (nonatomic, assign) id<XDCalendarPickerDelegate> delegate;

@property (nonatomic, retain) UITableView *tableView;

@end


@protocol XDCalendarPickerDelegate <NSObject>

@required
-(void)calendarPicker:(XDCalendarPicker *)calendarPicker changeFromStyle:(XDCalendarPickerStyle)fromStyle toStyle:(XDCalendarPickerStyle)toStyle changeToHeight:(float)height animated:(BOOL)animated;

-(void)calendarPicker:(XDCalendarPicker *)calendarPicker dateSelected:(NSDate *)date;

@end
