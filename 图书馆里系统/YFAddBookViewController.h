//
//  YFAddBookViewController.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/15.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBookInfo.h"

@interface YFAddBookViewController : UIViewController
{
    UIImage *image;
}

@property (strong,nonatomic) YFBookInfo *bookInfo;

@property (weak, nonatomic) IBOutlet UITextField *booName;
@property (weak, nonatomic) IBOutlet UITextField *authorName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *authorDec;
@property (weak, nonatomic) IBOutlet UITextField *publish;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *publishTime;
@property (weak, nonatomic) IBOutlet UIButton *addImage;

@end
