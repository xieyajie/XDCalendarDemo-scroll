//
//  XDDayBlock.h
//  XDDemo
//
//  Created by xieyajie on 13-4-16.
//  Copyright (c) 2013年 xieyajie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    XDDayBlockStateNoraml = 0,
    XDDayBlockStateSelected,
    XDDayBlockStateMoving
}XDDayBlockState;

@interface XDDayBlock : UIButton
{
    XDDayBlockState _blockState;
}

@property (nonatomic, assign, setter = setBlockState:) XDDayBlockState blockState;
@property (nonatomic, retain, setter = setBlockDate:) NSDate *blockDate;

@end
