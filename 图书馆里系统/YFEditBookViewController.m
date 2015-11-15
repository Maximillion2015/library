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

@interface YFEditBookViewController ()

@end

@implementation YFEditBookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.bookName.text = self.bookInfo.bookName;
//    self.bookAuthor.text = self.bookInfo.authorName;
//    self.phone.text = self.bookInfo.phone;
}

- (IBAction)finishEdit:(UIButton *)sender {
    UIAlertView* alertView =[[UIAlertView alloc]initWithTitle:@"编辑" message:@"您确定编辑完成了吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSString* clickTitle = [alertView buttonTitleAtIndex:buttonIndex];
//    if ([clickTitle isEqualToString:@"确定"]) {
//        YFBookManage *bookService = [YFBookManage sharedObject];
//        [bookService updateBookInfo:bookInfo];
//        [self dismissViewControllerAnimated:YES completion:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshData" object:nil];
//    }
//}

@end
