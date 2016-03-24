//
//  YFLoginViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFLoginViewController.h"
#import "YFLibraryTableViewController.h"
#import "MBProgressHUD+MJ.h"
#import "YFRegistViewController.h"
#import "YFVIP.h"
#import "YFUserManage.h"

@interface YFLoginViewController ()
@property (nonatomic, strong) NSMutableArray *VIP;
@property (nonatomic, strong) YFVIP *vip;

@end

@implementation YFLoginViewController

@synthesize names;

- (NSMutableArray *)VIP
{
    if (_VIP == nil) {
        YFUserManage *userManage = [YFUserManage sharedObject];
        _VIP = [userManage getAllUser];
    }
    return _VIP;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loginClick:(id)sender {
    BOOL right = NO;
    NSString *user = [self.username text];
    NSString *pwd = [self.password text];
    
    YFUserManage *userManage = [YFUserManage sharedObject];
    _VIP = [userManage getAllUser];
    
    for (int i = 0; i < self.VIP.count; i++) {
        self.vip = self.VIP[i];
        if ([user isEqualToString:self.vip.name] && [pwd isEqualToString:self.vip.pwd]) {
            [self performSegueWithIdentifier:@"toLib" sender:nil];
            right = YES;
        }
    }
    
    if (right == NO) {
        [MBProgressHUD showError:@"帐号或密码错误"];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[YFLibraryTableViewController class]]) {
        
        YFLibraryTableViewController *library = segue.destinationViewController;
        library.navigationItem.title = [NSString stringWithFormat:@"%@的图书馆", [self.username text]];

        library.vip = self.vip;
        
    } else if ([segue.destinationViewController isKindOfClass:[YFRegistViewController class]]) {
        YFRegistViewController *regist = segue.destinationViewController;
        regist.navigationItem.title = @"注册界面";
    }
    
}

- (IBAction)resetClick:(id)sender {
    [self.username setText:@""];
    [self.password setText:@""];
}




@end
