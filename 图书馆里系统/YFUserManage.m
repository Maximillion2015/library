//
//  YFUserManage.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/20.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFUserManage.h"

@implementation YFUserManage

static YFUserManage *userServie;

+ (YFUserManage *)sharedObject{
    static dispatch_once_t predict;
    dispatch_once(&predict,^{
        userServie = [[YFUserManage alloc]init];
        [userServie createDBIfNeeed];
    });
    return userServie;
}

- (NSString *) applicationDocumentsPath {
    NSString * applicationPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [applicationPath stringByAppendingString:@"/VIPs.sqlite"];
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
        NSString *createSql =[NSString stringWithFormat:@"create table if not exists userTable(userId integer primary key autoincrement,userName text,userPwd text)"];
        if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)!=SQLITE_OK) {
            NSAssert(NO, @"创建表失败");
            
        }
        sqlite3_close(db);
    }
}

- (void) addUserInfo:(YFVIP *) userInfo {
    NSString* path= [self applicationDocumentsPath];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        NSAssert(NO, @"打开数据库失败");
        sqlite3_close(db);
    } else {
        sqlite3_stmt *statement;
        NSString *insertSql = @"insert into userTable(userName,userPwd) values(?,?)";
        if (sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [userInfo.name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [userInfo.pwd UTF8String], -1, NULL);
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"插入数据库失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
}

- (NSMutableArray *)getAllUser{
    NSString* path = [self applicationDocumentsPath];
    NSMutableArray* users = [[NSMutableArray alloc]init];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        NSAssert(NO, @"打开数据库失败");
        sqlite3_close(db);
    }else{
        sqlite3_stmt* statement;
        NSString* selectSql = @"select* from userTable";
        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                YFVIP* userInfo = [[YFVIP alloc] init];
                NSUInteger userId = sqlite3_column_int64(statement, 0);
                [userInfo setUserId:userId];
                
                char* userName = (char*)sqlite3_column_text(statement, 1);
                [userInfo setName:[[NSString alloc]initWithUTF8String:userName]];
                
                char* userPwd = (char*)sqlite3_column_text(statement, 2);
                [userInfo setPwd:[[NSString alloc]initWithUTF8String:userPwd]];
                
                
                [users addObject:userInfo];
            }
        }
    }
    return users;
}

- (void)updateUserInfo:(YFVIP *) userInfo {
    NSString* path = [self applicationDocumentsPath];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        NSAssert(NO, @"打开数据库失败");
        sqlite3_close(db);
    }else{
        sqlite3_stmt* statement;
        NSString* selectSql = @"update userTable set userName=?,userPwd=? where userId=?";
        
        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            sqlite3_bind_text(statement, 1, [userInfo.name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [userInfo.pwd UTF8String], -1, NULL);
            sqlite3_bind_int64(statement, 3, [userInfo userId]);
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"插入数据库失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
}

- (void) deleteUserInfo:(YFVIP *) userInfo {
    NSString* path = [self applicationDocumentsPath];
    if (sqlite3_open([path UTF8String], &db)!=SQLITE_OK) {
        NSAssert(NO, @"打开数据库失败");
        sqlite3_close(db);
    }else{
        sqlite3_stmt* statement;
        NSString* selectSql = @"delete from userTable where userId=?";
        
        if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil)==SQLITE_OK) {
            sqlite3_bind_int64(statement, 1, [userInfo userId]);
            if (sqlite3_step(statement)!=SQLITE_DONE) {
                NSAssert(NO, @"插入数据库失败");
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
}

@end
