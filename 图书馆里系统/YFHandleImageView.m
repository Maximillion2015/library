//
//  YFHandleImageView.m
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFHandleImageView.h"
#import "UIImage+Tool.h"

@interface YFHandleImageView () <UIGestureRecognizerDelegate>

@end

@implementation YFHandleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addImageView];
        
        [self addGestureRecognizers];
    }
    return self;
}

- (void)addGestureRecognizers
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];

    [self.imageView addGestureRecognizer:longPress];
    
    [self addPinch];
    [self addRotation];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5f animations:^{
            self.imageView.alpha = 0.3;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f animations:^{
                self.imageView.alpha = 1;
            } completion:^(BOOL finished) {
                UIImage *newImage = [UIImage imageWithCaptureView:self];
                
                self.block(newImage);
                
                [self removeFromSuperview];
                
            }];
        }];
    }
}

#pragma mark - 捏合
- (void)addPinch
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    // 设置代理的原因：想要同时支持多个手势
    pinch.delegate = self;
    [_imageView addGestureRecognizer:pinch];
    
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pinch.scale, pinch.scale);
    
    // 复位
    pinch.scale = 1;
}

// Simultaneous:同时
// 默认是不支持多个手势
// 当你使用一个手势的时候就会调用
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 旋转
- (void)addRotation
{
    // rotation
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [_imageView addGestureRecognizer:rotation];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation
{
    
    //    _imagView.transform = CGAffineTransformMakeRotation(rotation.rotation);
    _imageView.transform = CGAffineTransformRotate(_imageView.transform, rotation.rotation);
    
    // 复位
    rotation.rotation = 0;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

- (void)addImageView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    self.imageView = imageView;
    
    self.imageView.userInteractionEnabled = YES;
    
    [self addSubview:imageView];
}

@end
