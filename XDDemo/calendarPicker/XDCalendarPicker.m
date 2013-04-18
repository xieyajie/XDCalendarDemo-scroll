//
//  XDCalendarPicker.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "XDCalendarPicker.h"
#import "XDCalendarPickerDaysOwner.h"
#import "XDCalendarPickerCell.h"
#import "NSDate+Convenience.h"
#import "XDManagerTool.h"
#import "LocalDefine.h"

@interface XDCalendarPicker ()<UITableViewDataSource, UITableViewDelegate>
{
    UIView *_signView;
    UITableView *_tableView;
    
    NSMutableArray *_dataSource;
    NSDate *_beginDate;
}

@property (nonatomic, retain) UIView *signView;

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, copy) NSDate *beginDate;

@property (nonatomic, retain) UISwipeGestureRecognizer *leftRecognizer;
@property (nonatomic, retain) UISwipeGestureRecognizer *rightRecognizer;

@end

@implementation XDCalendarPicker

@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize beginDate = _beginDate;

@synthesize signView = _signView;
@synthesize tableView = _tableView;

@synthesize leftRecognizer = _leftRecognizer;
@synthesize rightRecognizer = _rightRecognizer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        self.layer.shadowColor = [[UIColor grayColor] CGColor];
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
        
        _dataSource = [[NSMutableArray alloc] init];
        
        _signView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, kSignViewHeight)];
        _signView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"calendar_signBg.png"]];
        NSArray *weekSymbol = [[NSArray alloc] initWithObjects: @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日", nil];
        for (int i = 0; i < weekSymbol.count; i++)
        {
            NSString *daySymbol = (NSString *)[weekSymbol objectAtIndex: i];
            UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(kCalendarDayBlockWidth * i, 0, kCalendarDayBlockWidth, kSignViewHeight)];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize: 12.0];;
            label.text = daySymbol;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = KTextAlignmentCenter;
            [_signView addSubview: label];
            [label release];
        }
        [weekSymbol release];
        [self addSubview:_signView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSignViewHeight, frame.size.width, frame.size.height - kSignViewHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = kCalendarDayBlockHeight;
        _tableView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
        [self addSubview:_tableView];
        
        [XDCalendarPickerDaysOwner sharedDaysOwner];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(selectedDayAction:) name: kNotificationSelectedDay object: nil];
        
        _leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft:)];
        [_leftRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        _rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
        [_rightRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

#pragma mark - set methods

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGRect rect = _tableView.frame;
    _tableView.frame = CGRectMake(0, rect.origin.y, rect.size.width, frame.size.height - kSignViewHeight);
    
    if (frame.size.height == kCalendarPickerWeeksHeight) {
        [_tableView addGestureRecognizer:_leftRecognizer];
        [_tableView addGestureRecognizer:_rightRecognizer];
    }
    else{
        [_tableView removeGestureRecognizer:_leftRecognizer];
        [_tableView removeGestureRecognizer:_rightRecognizer];
    }
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
        if ([_delegate respondsToSelector:@selector(calendarPicker:changeFromStyle:toStyle:changeToHeight:animated:)])
        {
            [_delegate calendarPicker:self changeFromStyle:XDCalendarPickerStyleWeeks toStyle:XDCalendarPickerStyleDays changeToHeight:kCalendarPickerDaysHeight animated:YES];
        }
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


#pragma mark - UIGestureRecognizer

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGRect rect = _tableView.frame;
    CGPoint location = [gestureRecognizer locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
    if (indexPath.row != [_tableView numberOfRowsInSection:0]) {
        XDCalendarPickerCell *cell = (XDCalendarPickerCell *)[_tableView cellForRowAtIndexPath:indexPath];
        UIImageView *currentWeekImgView = [[UIImageView alloc] initWithImage: [XDManagerTool imageFromView:cell.contentView]];
        currentWeekImgView.frame = CGRectMake(0, rect.origin.y, 320, rect.size.height);
        [self addSubview: currentWeekImgView];
        
        _tableView.frame = CGRectMake(323, rect.origin.y, 320, rect.size.height);
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row + 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        [UIView animateWithDuration: .65
                         animations:^{
                             currentWeekImgView.frame = CGRectMake(-320, rect.origin.y, 320, rect.size.height);
                             _tableView.frame = CGRectMake(0, rect.origin.y, 320, rect.size.height);
                         }
                         completion:^(BOOL finished){
                             [currentWeekImgView removeFromSuperview];
                             [currentWeekImgView release];
                         }
         ];
    }
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    CGRect rect = _tableView.frame;
    CGPoint location = [gestureRecognizer locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
    if (indexPath.row == 0) {
        return;
    }
    
    XDCalendarPickerCell *cell = (XDCalendarPickerCell *)[_tableView cellForRowAtIndexPath:indexPath];
    UIImageView *currentWeekImgView = [[UIImageView alloc] initWithImage: [XDManagerTool imageFromView:cell.contentView]];
    currentWeekImgView.frame = CGRectMake(0, rect.origin.y, 320, rect.size.height);
    [self addSubview: currentWeekImgView];
    
    _tableView.frame = CGRectMake(-320, rect.origin.y, 320, rect.size.height);
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(indexPath.row - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [UIView animateWithDuration: .65
                     animations:^{
                         currentWeekImgView.frame = CGRectMake(323, rect.origin.y, 320, rect.size.height);
                         _tableView.frame = CGRectMake(0, rect.origin.y, 320, rect.size.height);
                     }
                     completion:^(BOOL finished){
                         [currentWeekImgView removeFromSuperview];
                         [currentWeekImgView release];
                     }
     ];
}

#pragma mark - NSNotification

- (void)selectedDayAction:(NSNotification *)aNotification
{
    NSDate *selectedDate = nil;
    
    if (aNotification != nil) {
        XDDayBlock *dayBlock = aNotification.object;
        XDDayBlock *selectedBlock = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedBlock];
        if (selectedBlock != nil) {
            selectedBlock.blockState = XDDayBlockStateNoraml;
        }
        
        [XDCalendarPickerDaysOwner sharedDaysOwner].selectedBlock = dayBlock;
        selectedDate = [[XDManagerTool sharedTool] ConvertToZeroInMorning:dayBlock.blockDate];
        [XDCalendarPickerDaysOwner sharedDaysOwner].selectedDate = selectedDate;
    }
    else{
        selectedDate = [NSDate date];
    }
    
    if ([_delegate respondsToSelector:@selector(calendarPicker:dateSelected:)])
    {
        [_delegate calendarPicker:self dateSelected:selectedDate];
    }
}

@end
