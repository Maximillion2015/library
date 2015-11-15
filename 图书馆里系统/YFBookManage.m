//
//  YFBookManage.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/9.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFBookManage.h"

@implementation YFBookManage

static YFBookManage *bookServie;

+ (YFBookManage *)sharedObject{
    static dispatch_once_t predict;
    dispatch_once(&predict,^{
        bookServie = [[YFBookManage alloc]init];
        [bookServie createDBIfNeeed];
    });
    return bookServie;
}

- (NSString *) applicationDocumentsPath {
    NSString * applicationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [applicationPath stringByAppendingString:@"books.sqlite"];
    return path;
}

- (void) createDBIfNeeed {
    NSString *path = [self applicationDocumentsPath];
//    sqlite3_open([path UTF8String], &db);
    
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"打开数据库失败");
    }else{
        char* error;
        NSString *createSql =[NSString stringWithFormat:@"create table if not exists bookTable(bookId integer primary key autoincrement,bookName text,authorName text,phone text)"];
        if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)!=SQLITE_OK) {
            NSAssert(NO, @"创建表失败");
            
        }
        sqlite3_close(db);
    }
}

//- (void) addBookInfo:(YFBookInfo *) bookinfo {
//    NSString* path= [self applicationDocumentsPath];
//    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
//        NSAssert(NO, @"打开数据库失败");
//        sqlite3_close(db);
//    } else {
//        sqlite3_stmt *statement;
//        NSString *insertSql = @"insert into bookTable(bookName,authorName,phone) values(?,?,?)";
//        if (sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
//            sqlite3_bind_text(statement, 1, [bookinfo.bookName UTF8String], -1, NULL);
//            sqlite3_bind_text(statement, 2, [bookinfo.authorName UTF8String], -1, NULL);
//            sqlite3_bind_text(statement, 3, [bookinfo.phone UTF8String] , -1, NULL);
//            if (sqlite3_step(statement)!=SQLITE_DONE) {
//                NSAssert(NO, @"插入数据库失败");
//            }
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(db);
//    }
//}

//- (NSMutableArray *)getAllBooks{
//    NSString* path = [self applicationDocumentsPath];
//    NSMutableArray* books = [[NSMutableArray alloc]init];
//    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
//        NSAssert(NO, @"打开数据库失败");
//        sqlite3_close(db);
//    }else{
//        sqlite3_stmt* statement;
//        NSString* selectSql = @"select* from bookTable";
//        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
//            while (sqlite3_step(statement)==SQLITE_ROW) {
//                YFBookInfo* bookInfo = [[YFBookInfo alloc] init];
//                NSUInteger bookId =sqlite3_column_int64(statement, 0);
//                [bookInfo setBookId:bookId];
//                
//                char* bookName = (char*)sqlite3_column_text(statement, 1);
//                [bookInfo setBookName:[[NSString alloc]initWithUTF8String:bookName]];
//                
//                char* authorName = (char*)sqlite3_column_text(statement, 2);
//                [bookInfo setAuthorName:[[NSString alloc]initWithUTF8String:authorName]];
//                
//                char* phone =(char*)sqlite3_column_text(statement, 3);
//                [bookInfo setPhone:[[NSString alloc]initWithUTF8String:phone]];
//                
//                [books addObject:bookInfo];
//            }
//        }
//    }
//    return books;
//}

- (void)updateBookInfo:(YFBookInfo *) bookInfo {
    NSString* path = [self applicationDocumentsPath];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        NSAssert(NO, @"打开数据库失败");
        sqlite3_close(db);
    }else{
        sqlite3_stmt* statement;
        NSString* selectSql = @"update bookTable set bookName=?,authorName=?,phone=? where bookId=?";
        
        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [bookInfo.bookName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [bookInfo.authorName UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [bookInfo.phone UTF8String], -1, NULL);
            sqlite3_bind_int64(statement, 3, [bookInfo bookId]);
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"插入数据库失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
}

//- (void) deleteBookInfo:(YFBookInfo *) bookInfo {
//    NSString* path = [self applicationDocumentsPath];
//    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
//        NSAssert(NO, @"打开数据库失败");
//        sqlite3_close(db);
//    }else{
//        sqlite3_stmt* statement;
//        NSString* selectSql = @"delete from bookTable where bookId=?";
//        
//        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
//            sqlite3_bind_int64(statement, 1, [bookInfo bookId]);
//            if (sqlite3_step(statement)!=SQLITE_DONE) {
//                NSAssert(NO, @"插入数据库失败");
//            }
//        }
//        sqlite3_finalize(statement);
//        sqlite3_close(db);
//    }
//}

@end
