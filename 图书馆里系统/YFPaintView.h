//
//  YFPaintView.h
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFPaintView : UIView

@property (nonatomic, assign) CGFloat width;

@property (strong,nonatomic) UIColor *color;

@property (strong,nonatomic) UIImage *image;

- (void)clear;

- (void)undo;
@end
