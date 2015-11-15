//
//  YFLoginViewController.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property(strong,nonatomic)NSArray* names;
- (IBAction)loginClick:(id)sender;
- (IBAction)resetClick:(id)sender;
@end
