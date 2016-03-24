//
//  CoverView.m
//  BusyLife
//
//  Created by apple on 15/3/4.
//  Copyright (c) 2015年 qi. All rights reserved.
//

#import "CoverView.h"
#import "MacroDefineHeader.h"
#define oApla 0
#define oBackGround  YQ_Custom255Color(76, 76, 76)
@implementation CoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self=[super init];
    if (self) {
        [self initBg];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self initBg];
        
    }
    return self;
}


- (void)initBg{
    
//    self.backgroundColor=oBackGround;
    self.alpha=oApla;
}

+ (instancetype)cover{
    return [[self alloc]init];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (self.TouchBlock) {
//        self.TouchBlock();
//    }
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.TouchBlock) {
        self.TouchBlock();
    }
}

@end
