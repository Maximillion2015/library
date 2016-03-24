//
//  BreakfastTimeSelectModel.m
//  BusyLife
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 qi. All rights reserved.
//

#import "BreakfastTimeSelectModel.h"

@implementation BreakfastTimeSelectModel


- (BOOL)canSendOrder{

    BOOL canSend = NO;
    
    NSDate * newLate =[NSDate date];
    NSDateFormatter * format= [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    
    NSDateFormatter * format1= [[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"HH"];
    
    int judgesHour = (int)[[format1 stringFromDate:newLate] integerValue];
    
    if (judgesHour < 20 && judgesHour >= 9) {
        
        canSend = YES;
    }
    
    return canSend;
}

- (NSArray *)getBreakfastTimeSelectArray{

    NSMutableArray *array = [NSMutableArray array];
    
    
    NSDate * newLate =[NSDate date];
    NSDateFormatter * format= [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    
    NSDateFormatter * format1= [[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"HH"];
    
//    NSDateFormatter * format2 = [[NSDateFormatter alloc]init];
//    [format2 setDateFormat:@"mm"];
//    
//    int mintueNumber = (int)[[format2 stringFromDate:newLate] integerValue];
    
    int judgesHour = (int)[[format1 stringFromDate:newLate] integerValue];
    
    if (judgesHour >= 0) {
        
        [array addObject:@"次日8:30左右送达"];
        [array addObject:@"次日9:00左右送达"];
    }
    
    
    return array;
}

@end
