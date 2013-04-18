//
//  XDCalendarPickerCell.h
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDCalendarPickerCell : UITableViewCell
{
    NSDate *_beginDate;
}

@property (nonatomic, retain, setter = setBeginDate:) NSDate *beginDate;

@end
