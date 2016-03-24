//
//  YFBookManage.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/9.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "YFBookInfo.h"

@interface YFBookManage : NSObject
{
    sqlite3 *db;
}
+ (YFBookManage *) sharedObject;
- (void) createDBIfNeeed;
- (NSString*) applicationDocumentsPath;
- (void) addBookInfo:(YFBookInfo *)bookinfo;
- (void) deleteBookInfo:(YFBookInfo *)bookInfo;
- (void)updateBookInfo:(YFBookInfo *)bookInfo;
- (NSMutableArray *) getAllBooks;
- (YFBookInfo *) selectBookInfo:(NSString *) bookName;
@end
