//
//  CustomPickView.m
//  BusyLife
//
//  Created by apple on 15/4/3.
//  Copyright (c) 2015年 qi. All rights reserved.
//

#import "CustomPickView.h"
#import "CoverView.h"
#import "MacroDefineHeader.h"
@interface CustomPickView ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (unsafe_unretained,nonatomic) CoverView * cover;
@property (weak,nonatomic)  UIPickerView * pick;

@end
@implementation CustomPickView


- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self)
    {
        
        yearString = @"2015";
        monthString = @"1";
        dayString = @"1";
        [self initUI];
        
        
    }
    return self;
}

- (void)initUI{
    UIButton * btn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 0, 50, 30)];
    [btn addTarget:self action:@selector(onDetermine) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:YQ_RedColor forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    
    [self addSubview:btn];
    
    self.backgroundColor=[UIColor whiteColor];
    
    UIPickerView * pick =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 270)];
    [self addSubview:pick];
    //pick.backgroundColor=[UIColor whiteColor];
    pick.delegate=self;
    pick.dataSource=self;
    self.pick=pick;
    
    
}

//UIPickerDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    int a[3] = {40,12,31};
    return a[component];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0://年
            return [NSString stringWithFormat:@"%d年",2015-row];
            break;
            case 1: //月
              return [NSString stringWithFormat:@"%d月",row+1];
            break;
            case 2://日
             return [NSString stringWithFormat:@"%d日",row+1];
        default:
            return @"";
            break;
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0://年
           yearString = [NSString stringWithFormat:@"%d",2015-row];
            break;
        case 1: //月
            monthString = [NSString stringWithFormat:@"%d",row+1];
            break;
        case 2://日
             dayString = [NSString stringWithFormat:@"%d",row+1];
            break;
        default:
            break;
    }
}



- (void)onDetermine
{
    //确认
    
    if (self.returnBlock)
    {
        self.returnBlock([NSArray arrayWithObjects:yearString,monthString,dayString, nil]);
    }
    [self hidden];
}



#define DesFrame  CGRectMake(0, SCREEN_HEIGHT -300, SCREEN_WIDTH, 300)
- (void)showInView:(UIView *)view{
    
    [view addSubview:self];
    if (!self.cover) {
        CoverView * cover =[[CoverView alloc]initWithFrame:view.bounds];
        [view addSubview:cover];
        cover.TouchBlock=^{
            [self hidden];
        };
        
        self.cover=cover;
    }
    
    [view bringSubviewToFront:self.cover];
    [view bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.2f animations:^{
        self.cover.alpha=0.7;
        self.frame=DesFrame;
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)hidden{
    
    CGRect rect =self.frame;
    
    rect.origin.y+=300;
    [UIView animateWithDuration:0.2f animations:^{
        self.cover.alpha=0;
        
        self.frame=rect;
    } completion:^(BOOL finished) {
        
        [self.cover removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
