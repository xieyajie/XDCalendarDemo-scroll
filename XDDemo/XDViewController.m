//
//  XDViewController.m
//  XDDemo
//
//  Created by xieyajie on 13-4-15.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "XDViewController.h"
#import "XDCalendarPickerDaysOwner.h"
#import "XDCalendarPicker.h"
#import "NSDate+Convenience.h"
#import "LocalDefine.h"

@interface XDViewController ()<UITableViewDelegate, UITableViewDataSource, XDCalendarPickerDelegate>
{
    NSMutableArray *_dataSource;
    
    XDCalendarPicker *_calendarPicker;
    UITableView *_tableView;
}

@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) XDCalendarPicker *calendarPicker;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation XDViewController

@synthesize dataSource = _dataSource;

@synthesize calendarPicker = _calendarPicker;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _calendarPicker = [[XDCalendarPicker alloc] initWithFrame:CGRectMake(0, 0, 320, kCalendarPickerDaysHeight)];
    _calendarPicker.delegate = self;
    [self.view addSubview:_calendarPicker];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCalendarPickerDaysHeight, 320, self.view.frame.size.height - kCalendarPickerDaysHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_tableView];
    
    [self.view bringSubviewToFront:_calendarPicker];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Scroll Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_calendarPicker.frame.size.height == kCalendarPickerDaysHeight) {
        [UIView animateWithDuration:0.35 animations:^{
            _calendarPicker.frame = CGRectMake(0, 0, 320, kCalendarPickerWeeksHeight);
            _tableView.frame = CGRectMake(0, kCalendarPickerWeeksHeight, 320, self.view.frame.size.height - kCalendarPickerWeeksHeight);
        }completion:^(BOOL finished){
            int row = [[XDCalendarPickerDaysOwner sharedDaysOwner].selectedDate weekInYear] - 1;
            [_calendarPicker.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }];
    }
}

#pragma mark - XDCalendarPicker Delegate

-(void)calendarPicker:(XDCalendarPicker *)calendarPicker changeFromStyle:(XDCalendarPickerStyle)fromStyle toStyle:(XDCalendarPickerStyle)toStyle changeToHeight:(float)height animated:(BOOL)animated
{
    if (toStyle == XDCalendarPickerStyleDays) {
        [UIView animateWithDuration:0.35 animations:^{
            _calendarPicker.frame = CGRectMake(0, 0, 320, height);
            _tableView.frame = CGRectMake(0, 0 + height, 320, self.view.frame.size.height - height);
        }completion:^(BOOL finished){
        }];
    }
}

-(void)calendarPicker:(XDCalendarPicker *)calendarPicker dateSelected:(NSDate *)date
{
    NSLog(@"date selected: %@", date);
}


@end
