//
//  YFBezierPath.m
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFBezierPath.h"

@implementation YFBezierPath

+ (instancetype)pathWithLineWidth:(CGFloat)width color:(UIColor *)color startP:(CGPoint)point
{
    YFBezierPath *path = [[self alloc] init];
    
    path.lineWidth = width;
    path.color = color;
    
    [path moveToPoint:point];
    
    return path;
}

@end
