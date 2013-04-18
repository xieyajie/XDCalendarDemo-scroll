//
//  LocalDefine.h
//  XDCalendar
//
//  Created by xieyajie on 13-3-21.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#ifndef XDCalendar_LocalDefine_h
#define XDCalendar_LocalDefine_h

#if !defined __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_5_0
# define KTextAlignmentLeft UITextAlignmentLeft
# define KTextAlignmentCenter UITextAlignmentCenter
# define KTextAlignmentRight UITextAlignmentRight

#define KLineBreakModeClip UILineBreakModeClip

#else
# define KTextAlignmentLeft NSTextAlignmentLeft
# define KTextAlignmentCenter NSTextAlignmentCenter
# define KTextAlignmentRight NSTextAlignmentRight

#define KLineBreakModeClip NSLineBreakByClipping
#endif


#define kSignViewHeight 25
#define kCalendarPickerWeeksHeight 71
#define kCalendarPickerDaysHeight 275
#define kCalendarDayBlockWidth 46
#define kCalendarDayBlockHeight 46

#define kColorDValue 20.0
#define kColorBase 255.0

#define kNotificationSelectedDay @"selectedDay"

#endif
