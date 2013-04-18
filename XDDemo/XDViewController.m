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
#import "XDCalendarPickerCell.h"
#import "NSDate+Convenience.h"
#import "UIColor+Category.h"
#import "XDManagerTool.h"
#import "LocalDefine.h"

#define kCalendarPickerHeight 275
#define kCalendarDayBlockWidth 46
#define kCalendarDayBlockHeight 46

#define kNotificationClickDay @"clickDay"
#define kNotificationCalendarStyleDays @"changeCalendarToDaysStyle"

@interface XDViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_dataSource;
    
    XDCalendarPicker *_calendarPicker;
    UITableView *_tableView;
}

@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) XDCalendarPicker *calendarPicker;
@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) UISwipeGestureRecognizer *leftRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *rightRecognizer;

@end

@implementation XDViewController

@synthesize dataSource = _dataSource;

@synthesize calendarPicker = _calendarPicker;
@synthesize tableView = _tableView;

@synthesize leftRecognizer = _leftRecognizer;
@synthesize rightRecognizer = _rightRecognizer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _calendarPicker = [[XDCalendarPicker alloc] initWithFrame:CGRectMake(0, 0, 320, kCalendarPickerHeight)];
    [self.view addSubview:_calendarPicker];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kCalendarPickerHeight, 320, self.view.frame.size.height - kCalendarPickerHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_tableView];
    
    [self.view bringSubviewToFront:_calendarPicker];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(clickDayAction:) name: kNotificationClickDay object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(changeCalendarToDaysStyle:) name: kNotificationCalendarStyleDays object: nil];
    
    _leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
    [_leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    _rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    [_rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
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
    if (_calendarPicker.frame.size.height == kCalendarPickerHeight) {
        [UIView animateWithDuration:0.35 animations:^{
            _calendarPicker.frame = CGRectMake(0, 0, 320, kCalendarDayBlockHeight + 25);
            _tableView.frame = CGRectMake(0, kCalendarDayBlockHeight, 320, self.view.frame.size.height - kCalendarDayBlockHeight - 25);
        }completion:^(BOOL finished){
            int row = [[XDCalendarPickerDaysOwner sharedDaysOwner].selectedDate weekInYear] - 1;
            [_calendarPicker.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [_calendarPicker addGestureRecognizer:_leftRecognizer];
            [_calendarPicker addGestureRecognizer:_rightRecognizer];
        }];
    }
}

#pragma mark - UIGestureRecognizer

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"left");
    CGPoint location = [gestureRecognizer locationInView:_calendarPicker];
    NSIndexPath *indexPath = [_calendarPicker.tableView indexPathForRowAtPoint:location];
    XDCalendarPickerCell *cell = (XDCalendarPickerCell *)[_calendarPicker.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *currentWeekImgView = [[UIImageView alloc] initWithImage: [XDManagerTool imageFromView:cell.contentView]];
    currentWeekImgView.frame = CGRectMake(0, 0, 320, kCalendarDayBlockHeight);
    [self.view addSubview: currentWeekImgView];
    
    _calendarPicker.frame = CGRectMake(323, 0, 320, kCalendarDayBlockHeight);
    [_calendarPicker.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration: .65
                     animations:^{
                         currentWeekImgView.frame = CGRectMake(-320, 0, 320, kCalendarDayBlockHeight);
                         _calendarPicker.frame = CGRectMake(0, 0, 320, kCalendarDayBlockHeight);
                     }
                     completion:^(BOOL finished){
                         [currentWeekImgView removeFromSuperview];
                         [currentWeekImgView release];
                     }
     ];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    NSLog(@"right");
    CGPoint location = [gestureRecognizer locationInView:self.calendarPicker];
    NSIndexPath *indexPath = [self.calendarPicker.tableView indexPathForRowAtPoint:location];
    XDCalendarPickerCell *cell = (XDCalendarPickerCell *)[_calendarPicker.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *currentWeekImgView = [[UIImageView alloc] initWithImage: [XDManagerTool imageFromView:cell.contentView]];
    currentWeekImgView.frame = CGRectMake(0, 0, 320, kCalendarDayBlockHeight);
    [self.view addSubview: currentWeekImgView];
    
    _calendarPicker.frame = CGRectMake(-320, 0, 320, kCalendarDayBlockHeight);
    [_calendarPicker.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration: .65
                     animations:^{
                         currentWeekImgView.frame = CGRectMake(323, 0, 320, kCalendarDayBlockHeight);
                         _calendarPicker.frame = CGRectMake(0, 0, 320, kCalendarDayBlockHeight);
                     }
                     completion:^(BOOL finished){
                         [currentWeekImgView removeFromSuperview];
                         [currentWeekImgView release];
                     }
     ];
}

#pragma mark - NSNotification

- (void)clickDayAction:(NSNotification *)aNotification
{
    NSDate *clickDate = nil;
    
    if (aNotification != nil) {
        XDDayBlock *dayBlock = aNotification.object;
        XDDayBlock *selectedBlock = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedBlock];
        if (selectedBlock != nil) {
            selectedBlock.blockState = XDDayBlockStateNoraml;
        }
        
        [XDCalendarPickerDaysOwner sharedDaysOwner].selectedBlock = dayBlock;
        clickDate = [[XDManagerTool sharedTool] ConvertToZeroInMorning:dayBlock.blockDate];
        [XDCalendarPickerDaysOwner sharedDaysOwner].selectedDate = clickDate;
    }
    else{
        clickDate = [NSDate date];
    }
}

- (void)changeCalendarToDaysStyle:(NSNotification *)aNotification
{
    [UIView animateWithDuration:0.35 animations:^{
        _calendarPicker.frame = CGRectMake(0, 0, 320, kCalendarPickerHeight);
        _tableView.frame = CGRectMake(0, 0 + kCalendarPickerHeight, 320, self.view.frame.size.height - kCalendarPickerHeight);
    }completion:^(BOOL finished){
        [_calendarPicker removeGestureRecognizer:_leftRecognizer];
        [_calendarPicker removeGestureRecognizer:_rightRecognizer];
    }];
}


@end
