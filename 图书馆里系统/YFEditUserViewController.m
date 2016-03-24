//
//  YFEditUserViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/20.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFEditUserViewController.h"
#import "YFVIP.h"
#import "YFUserManage.h"

@interface YFEditUserViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;

@end

@implementation YFEditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userPwd.delegate = self;
    
    self.userName.text = self.vip.name;
    self.userPwd.text = self.vip.pwd;
    
    NSLog(@"-------%ld", (long)self.vip.userId);
}

- (IBAction)save:(id)sender {
    
    YFUserManage *manage = [[YFUserManage alloc] init];
    
    NSArray *vips = [manage getAllUser];
    for (YFVIP *vip in vips) {
        if ([vip.name isEqualToString:self.vip.name] && [vip.pwd isEqualToString:self.vip.pwd]) {
            
            self.vip.name = self.userName.text;
            self.vip.pwd = self.userPwd.text;

            [manage updateUserInfo:self.vip];

        }
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)logout:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
