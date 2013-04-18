//
//  XDCalendarPickerProvider.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "XDCalendarPickerProvider.h"
#import "XDCalendarPickerDaysOwner.h"
#import "XDCalendarPickerCell.h"
#import "NSDate+Convenience.h"

#define kCalendarDayBlockHeight 46
#define kNotificationCalendarStyleDays @"changeCalendarToDaysStyle"

@interface XDCalendarPickerProvider()
{
    NSMutableArray *_dataSource;
    
    NSDate *_beginDate;
}

@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, copy) NSDate *beginDate;

@end

@implementation XDCalendarPickerProvider

@synthesize tableView = _tableView;

@synthesize dataSource = _dataSource;

@synthesize beginDate = _beginDate;

- (id)init{
    self = [super init];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setBeginDate:(NSDate *)beginDate
{
    if (_beginDate != nil) {
        [_beginDate release];
    }
    
    _beginDate = [beginDate copy];
}


#pragma mark - TableView Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleNone)
    {
    }
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.beginDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] beginDate];
    NSDate *endDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] endDate];
    NSTimeInterval interval = [endDate timeIntervalSinceDate: self.beginDate];
    int dayCount = interval / 86400;
    if(fmod(interval, 7) != 0)
    {
        return (dayCount / 7) + 1;
    }
    else{
        return dayCount / 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CalendarPickerCell";
    XDCalendarPickerCell *cell = (XDCalendarPickerCell *)[tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[XDCalendarPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    int row = indexPath.row;
    cell.tag = row;
    cell.beginDate = [self.beginDate offsetDay:(7 * row)];
    cell.editing = tableView.editing;
    
    return cell;
}

#pragma mark - Scroll Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"WillBeginDragging");
    
    if (_tableView.frame.size.height == kCalendarDayBlockHeight) {
        [[NSNotificationCenter defaultCenter] postNotificationName: kNotificationCalendarStyleDays object:nil userInfo:nil];
    }
    self.tableView.editing = YES;
    
    NSArray *visibles = [_tableView visibleCells];
    for (UITableViewCell *cell in visibles) {
        cell.editing = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!_tableView.decelerating && !_tableView.dragging) {
        NSLog(@"EndDragging");
        self.tableView.editing = NO;
        
        NSArray *visibles = [_tableView visibleCells];
        for (UITableViewCell *cell in visibles) {
            cell.editing = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollViewSender 
{
    NSLog(@"DidEndDecelerating");
    self.tableView.editing = NO;
    
    NSArray *visibles = [_tableView visibleCells];
    for (UITableViewCell *cell in visibles) {
        cell.editing = NO;
    }
}


@end
