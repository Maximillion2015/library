//
//  YFBookInfo.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/9.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBookInfo : NSObject

@property (nonatomic, assign) NSInteger bookId;
@property (nonatomic,copy) NSString *bookName;
@property (nonatomic,copy) NSString *authorName;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *authorDec;
@property (nonatomic,copy) NSString *publish;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *publishTime;
@property (nonatomic,copy) NSString *image;



@end
