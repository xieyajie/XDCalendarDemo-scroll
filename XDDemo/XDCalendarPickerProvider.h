//
//  XDCalendarPickerProvider.h
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDCalendarPickerProvider : NSObject<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, retain) UITableView *tableView;


@end
