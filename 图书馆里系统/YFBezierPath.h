//
//  YFBezierPath.h
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFBezierPath : UIBezierPath

@property (strong,nonatomic) UIColor *color;

+ (instancetype)pathWithLineWidth:(CGFloat)width color:(UIColor *)color startP:(CGPoint)point;

@end
