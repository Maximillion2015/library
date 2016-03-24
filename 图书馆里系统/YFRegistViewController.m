//
//  YFRegistViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFRegistViewController.h"
#import "YFVIP.h"
#import "YFUserManage.h"
#import "MBProgressHUD+MJ.h"

@interface YFRegistViewController ()<UITextFieldDelegate>

@end

@implementation YFRegistViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.userPwd.delegate = self;
}

// 保存
- (IBAction)save:(id)sender {
    YFVIP* userInfo = [[YFVIP alloc]init];
    [userInfo setName:[self.userName text]];
    [userInfo setPwd:[self.userPwd text]];
    
    YFUserManage* userManage = [YFUserManage sharedObject];
    if (self.userName.text.length != 0 && self.userPwd.text.length != 0) {
        [userManage addUserInfo:userInfo];
    }else {
        [MBProgressHUD showError:@"请输入注册信息"];
    }
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
