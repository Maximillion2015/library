//
//  ViewController.m
//  画板
//
//  Created by 张艺峰 on 15/10/22.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "ViewController.h"
#import "YFPaintView.h"
#import "YFHandleImageView.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet YFPaintView *paintView;


@end

@implementation ViewController

#pragma mark - 上半部分功能的实现

- (IBAction)clearScreen:(id)sender {
    [self.paintView clear];
}

- (IBAction)undo:(id)sender {
    [self.paintView undo];
}

- (IBAction)eraser:(id)sender {
    self.paintView.color = [UIColor whiteColor];
}

- (IBAction)camera:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)photo:(id)sender {
    // 去用户相册
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    YFHandleImageView *handleView = [[YFHandleImageView alloc] initWithFrame:self.paintView.frame];
    
    handleView.block= ^(UIImage *image){
        self.paintView.image = image;
    };
    
    NSLog(@"%f", self.paintView.bounds.origin.y);
    handleView.image = image;
    
    [self.view addSubview:handleView];
    
//    self.paintView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    // 1.把画板截屏
    UIGraphicsBeginImageContextWithOptions(self.paintView.bounds.size, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.paintView.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 2/保存到用户的相册里面，这个方法不能随便写，必须写下面这个
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    }else {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

#pragma mark - 下部分View功能的实现
- (IBAction)valueChange:(UISlider *)sender {
    self.paintView.width = sender.value;
}

- (IBAction)colorChange:(UIButton *)sender {
    self.paintView.color = sender.backgroundColor;
    [UIView animateWithDuration:0.5f animations:^{
        sender.alpha = 0.3;
    } completion:^(BOOL finished) {
        sender.alpha = 1;
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
