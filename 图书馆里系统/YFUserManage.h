//
//  YFUserManage.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/20.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "YFVIP.h"

@interface YFUserManage : NSObject
{
    sqlite3 *db;
}
+ (YFUserManage *) sharedObject;
- (void) createDBIfNeeed;
- (NSString*) applicationDocumentsPath;
- (void) addUserInfo:(YFVIP *)userInfo;
- (void) deleteUserInfo:(YFVIP *)userInfo;
- (void)updateUserInfo:(YFVIP *)userInfo;
- (NSMutableArray *) getAllUser;
@end
