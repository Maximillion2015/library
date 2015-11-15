//
//  YFEditBookViewController.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/9.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YFBookInfo;
@interface YFEditBookViewController : UIViewController

@property (strong,nonatomic)  YFBookInfo *bookInfo;
@property (strong, nonatomic) IBOutlet UITextField *bookName;
@property (strong, nonatomic) IBOutlet UITextField *bookAuthor;
@property (strong, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@end
