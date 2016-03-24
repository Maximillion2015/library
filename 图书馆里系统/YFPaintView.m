//
//  YFPaintView.m
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFPaintView.h"
#import "YFBezierPath.h"

@interface YFPaintView ()

@property (nonatomic, strong)UIBezierPath *path;

@property (nonatomic, strong)NSMutableArray *paths;

@end

@implementation YFPaintView

- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    
    return _paths;
}

- (UIBezierPath *)path
{
    if (_path == nil) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}

// 设置初始宽度
- (void)awakeFromNib
{
    _width = 2;
}

#pragma mark - 绘图
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    
    YFBezierPath *path = [YFBezierPath pathWithLineWidth:self.width color:self.color startP:pos];
    
    self.path = path;

//    // 在每次触摸的时候决定这条线的线宽
//    path.lineWidth = self.width;
    
    [self.paths addObject:path];
    
    
    [path moveToPoint:pos];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pos = [self pointWithTouches:touches];
    
    [self.path addLineToPoint:pos];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    for (YFBezierPath *path in self.paths) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
            
        }else {
        
            [path.color set];
            
            [path stroke];
        }
    }
}

#pragma mark - 上半部分按钮功能的实现
- (void)clear
{
    [self.paths removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)undo
{
    [self.paths removeLastObject];
    
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self.paths addObject:image];
    
    [self setNeedsDisplay];
}
@end
