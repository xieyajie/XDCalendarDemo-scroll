//
//  XDCalendarPickerCell.m
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import "XDCalendarPickerCell.h"
#import "XDCalendarPickerDaysOwner.h"
#import "XDDayBlock.h"
#import "NSDate+Convenience.h"

#define kCalendarDayBlockWidth 46
#define kCalendarDayBlockHeight 46

@interface XDCalendarPickerCell()
{
    NSMutableArray *_blocks;
}

@property (nonatomic, retain) NSMutableArray *blocks;

@end

@implementation XDCalendarPickerCell

@synthesize blocks = _blocks;
@synthesize beginDate = _beginDate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _blocks = [[NSMutableArray alloc] init];
        for (int i = 0; i < 7; i++) {
            XDDayBlock *block = [[XDDayBlock alloc] initWithFrame:CGRectMake(kCalendarDayBlockWidth * i, 0, kCalendarDayBlockWidth - 1, kCalendarDayBlockHeight)];
            block.tag = self.tag;
            [self.contentView addSubview:block];
            [_blocks addObject:block];
            [block release];
        }
    }
    return self;
}

#pragma mark - set methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEditing:(BOOL)editing
{
    [super setEditing:editing];
    if (editing) {
        [self setBlocksMoving];
    }
    else{
        [self setBlocksNormal];
    }
}

- (void)setBeginDate:(NSDate *)beginDate
{
    if (_beginDate != nil) {
        [_beginDate release];
    }
    _beginDate = [beginDate retain];
    
    NSDate *selectedDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedDate];
    for (int i = 0; i < 7; i++) {
        XDDayBlock *block = [_blocks objectAtIndex:i];
        NSDate *date = [_beginDate offsetDay:i];
        block.blockDate = date;
        if ([date compareWithDate:selectedDate] == XDDateCompareEqual) {
            block.blockState = XDDayBlockStateSelected;
        }
        else{
            block.blockState = XDDayBlockStateNoraml;
        }
    }
}

#pragma mark - private

- (void)setBlocksNormal
{
    NSDate *selectedDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedDate];
    for (int i = 0; i < 7; i++) {
        XDDayBlock *block = [_blocks objectAtIndex:i];
        NSDate *date = block.blockDate;
        if ([date compareWithDate:selectedDate] == XDDateCompareEqual) {
            block.blockState = XDDayBlockStateSelected;
        }
        else{
            block.blockState = XDDayBlockStateNoraml;
        }
    }
}

- (void)setBlocksMoving
{
//    NSDate *selectedDate = [[XDCalendarPickerDaysOwner sharedDaysOwner] selectedDate];
    for (int i = 0; i < 7; i++) {
        XDDayBlock *block = [_blocks objectAtIndex:i];
//        NSDate *date = block.blockDate;
//        if ([date compareWithDate:selectedDate] == XDDateCompareEqual) {
//            block.selected = YES;
//        }
        block.blockState = XDDayBlockStateMoving;
    }
}

@end
