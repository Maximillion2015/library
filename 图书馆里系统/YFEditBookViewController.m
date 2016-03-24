//
//  YFEditBookViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/9.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFEditBookViewController.h"
#import "YFBookInfo.h"
#import "YFBookManage.h"
#import "MBProgressHUD+MJ.h"

@interface YFEditBookViewController ()<UITextFieldDelegate>

@end

@implementation YFEditBookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.publishTime.enabled = NO;
    self.bookName.text = self.bookInfo.bookName;
    self.bookAuthor.text = self.bookInfo.authorName;
    self.phone.text = self.bookInfo.phone;
    self.authorDec.text = self.bookInfo.authorDec;
    self.publish.text = self.bookInfo.publish;
    self.email.text = self.bookInfo.email;
    self.publishTime.textColor = [UIColor blackColor];
    self.publishTime.text = self.bookInfo.publishTime;
//    [self.publishTime setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    self.publishTime.titleLabel.text = @"!!!!";
//    NSLog(@"%@", self.publishTime.titleLabel.text);
    self.imageView.image = [UIImage imageWithContentsOfFile:self.bookInfo.image];
    
    self.bookAuthor.delegate = self;
    self.phone.delegate = self;
}
- (IBAction)clean:(id)sender {
    UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"删除" message:@"您确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alertView.tag = 1;
    
    [alertView show];

}
- (IBAction)finish:(id)sender {
    UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"编辑" message:@"您确定编辑完成了吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alertView.tag = 2;
    
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* clickTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([clickTitle isEqualToString:@"确定"]) {
        YFBookManage *bookService = [YFBookManage sharedObject];
        if (alertView.tag == 1) {
            [bookService deleteBookInfo:self.bookInfo];
        }else if(alertView.tag == 2) {
            
            if ([self isPureInt:self.phone.text]) {

                self.bookInfo.bookName = self.bookName.text;
                self.bookInfo.authorName = self.bookAuthor.text;
                self.bookInfo.phone = self.phone.text;
                self.bookInfo.authorDec = self.authorDec.text;
                self.bookInfo.publish = self.publish.text;
                self.bookInfo.email = self.email.text;
                
                //            NSLog(@"%@", self.bookInfo.bookName);
                
                [bookService updateBookInfo:self.bookInfo];
                
            }else {
                [MBProgressHUD showError:@"请输入正确的电话号码"];
                return;
            }
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:nil];
    }
}

// 判断输入的是否是数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (IBAction)call:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", self.phone.text]]];
}

- (IBAction)message:(id)sender {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", self.phone.text]]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
