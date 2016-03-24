//
//  CustomPickView.h
//  BusyLife
//
//  Created by apple on 15/4/3.
//  Copyright (c) 2015年 qi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BreakfastTimeSelectModel.h"

//自定制的时间选择器 控件  内部用了一个PickerView
@interface CustomPickView : UIView
{
    NSString *yearString;
    NSString *monthString;
    NSString *dayString;
}



- (instancetype)initWithFrame:(CGRect)frame;
//展示到某个视图上的方法
- (void)showInView:(UIView *)view;


//选择了 某个时间点的 回传
@property (strong,nonatomic) void (^returnBlock)(NSArray *);

@end
