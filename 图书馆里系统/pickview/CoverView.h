//
//  CoverView.h
//  BusyLife
//
//  Created by apple on 15/3/4.
//  Copyright (c) 2015年 qi. All rights reserved.
//
//盖板View
#import <UIKit/UIKit.h>
typedef void (^touchBlock) (void);
@interface CoverView : UIView
@property (copy,nonatomic)  touchBlock TouchBlock;

+ (instancetype)cover;
@end
