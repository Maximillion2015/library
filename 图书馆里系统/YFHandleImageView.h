//
//  YFHandleImageView.h
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YFHandleImageViewBlock)(UIImage *image);

@interface YFHandleImageView : UIView

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) UIImageView *imageView;

@property (nonatomic, copy) YFHandleImageViewBlock block;

@end
