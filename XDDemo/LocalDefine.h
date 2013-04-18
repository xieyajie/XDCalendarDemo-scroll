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

#define KToolbarHeight 44
#define KScreenWidth 320
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height - 44 - 20
#define KTimerViewHeight 372

#define KCalendarViewTopbarHeight 60
#define KCurrentDateLabelX 100
#define KCurrentDateLabelHeight 35
#define KCalendarViewDayWidth 44
#define KCalendarViewDayHeight 44

#define KWeekSymbolViewHeight 25
#define KCalendarViewWeekSymbolFontName @"HelveticaNeue-Bold"
#define KCalendarViewWeekSymbolFontSize 12

#define KCalendarViewGridBackgroudColor @"0xf9f9f9"
#define KCalendarViewGridLineColor @"0xcfd4d8"
#define KCalendarViewOtherDayColor @"0xaaaaaa"
#define KCalendarViewSelectedColor @"0x4ec4ff"
#define KCalendarViewNormalTextColorHex @"0x383838"

#define KCalendarViewMonthFormatter @"yyyy - MM"
#define KShowViewDateFormatter @"yyyy年MM月dd日"
#define KPostViewDateFormatter @"yyyy-MM-dd"
#define KPostViewTimeFormatter @"HH:mm"

#define KDayBlockDateFontName @"HelveticaNeue-Bold"
#define KDayBlockDateFontSize 22
#define KDayBlockWidth 44
#define KDayBlockHeight 44

#define KEachRowCount 4
#define KContentLabelTag 99



#pragma mark - NSNotification name

#define kNotificationDeleteEvent @"deleteEvent"
#define kNotificationRefreshData @"refreshData"
#define kNotificationUpdateEvent @"updateEvent"


#pragma mark - 服务器接口字段名

//服务器返回
//获取“自己的”页面数据
//json字段
#define kCalendarData @"data"
#define kCalendarErrorCode @"s"
#define kCalendarNextFlag @"nextFlag"
#define kCalendarCount @"count"

//返回内容字段
#define kCalendarAccountId @"accountId"
#define kCalendarSpaceId @"spaceId"
#define kCalendarEventId @"id"
#define kCalendarHeadPortrait @"senderLogo"
#define kCalendarName @"senderName"
#define kCalendarTitle @"title"
#define kCalendarContent @"content"
#define kCalendarCommentCount @"commentCount"
#define kCalendarMemberCount @"partnerNum"
#define kCalendarCreateTime @"createTime"
#define kCalendarStartTime @"startTime"
#define kCalendarEndTime @"endTime"
#define kCalendarRemindTime @"remindTime"
#define kCalendarRemindMobile @"remindMobile"
#define kCalendarRemindType @"remindType"
#define kCalendarRemindFlag @"remindFlag"
#define kCalendarLat @"lat"
#define kCalendarLng @"lng"
#define kCalendarLocation @"location"
#define kCalendarJoinFlag @"joinFlag"

//评论
#define kCalendarCommentId @"id"
#define kCalendarCommentContent @"content"
#define kCalendarCommentSenderId @"senderAccid"
#define kCalendarCommentHeadPortrait @"senderLogo"
#define kCalendarCommentName @"senderName"
#define kCalendarCommentCreateTime @"createTime"

//获取“朋友的”页面数据
#define kCalendarFriendFlag @"atFlag"

//邀请的成员列表
#define kCalendarPartnerId @"aid"
#define kCalendarPartnerName @"name"
#define kCalendarPartnerLogo @"logo"
#define kCalendarPartnerFlag @"joinFlag"

//每天的事件数量
#define kCalendarEventCount @"count"
#define kCalendarEventDate @"date" //格式：20130410


#endif
