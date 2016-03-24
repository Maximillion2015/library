//
//  YFAddBookViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/15.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFAddBookViewController.h"
#import "YFBookInfo.h"
#import "YFBookManage.h"
#import "MBProgressHUD+MJ.h"
#import "CustomPickView.h"
#import "ViewController.h"

@interface YFAddBookViewController ()<UITextFieldDelegate>

@end

@implementation YFAddBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.phone.delegate = self;
}

- (IBAction)save:(id)sender {
    YFBookInfo* bookInfo = [[YFBookInfo alloc]init];
    [bookInfo setBookName:[self.booName text]];
    [bookInfo setAuthorName:[self.authorName text]];
    [bookInfo setPhone:[self.phone text]];
    [bookInfo setAuthorDec:self.authorDec.text];
    [bookInfo setPublish:self.publish.text];
    [bookInfo setEmail:self.email.text];
    [bookInfo setPublishTime:self.publishTime.titleLabel.text];
    
    NSArray *n_aryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask,
                                                              YES);
    
    NSString *n_strDocumentsPath = [n_aryPaths objectAtIndex:0];
//    NSLog(@"+++++%@",n_strDocumentsPath);

    NSString *string = [n_strDocumentsPath stringByAppendingPathComponent:[self SaveImage]];
//    NSLog(@"-------%@", string);

    
    [bookInfo setImage:string];
    
//    NSLog(@"%@", string);
//    NSScanner *scan = [NSScanner scannerWithString:bookInfo.phone];
    if ([self isPureInt:self.phone.text]) {
        
        [self SaveImage];
        
        YFBookManage* bookManager = [YFBookManage sharedObject];
        [bookManager addBookInfo:bookInfo];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
    }else {
        [MBProgressHUD showError:@"请输入正确的电话"];
    }

}

- (NSString *)SaveImage
{
    NSArray *n_aryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask,
                                                              YES);
    
    NSString *n_strDocumentsPath = [n_aryPaths objectAtIndex:0];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyyMMddHHmmss"];
    
    
    NSString *string = [n_strDocumentsPath stringByAppendingPathComponent:[formate stringFromDate:date]];
    
    if (self.bookInfo)
    {
        if (image != [self.addImage imageForState:UIControlStateNormal])
        {
            NSString *stringA = [n_strDocumentsPath stringByAppendingPathComponent:self.bookInfo.image];
            NSFileManager *defaultManager;
            defaultManager = [NSFileManager defaultManager];
            
            if ([defaultManager removeItemAtPath:stringA error:NULL])
            {
                NSLog(@"ccccc");
            }
        }
    }
    [UIImagePNGRepresentation(image) writeToFile:string atomically:YES];
    
    return [formate stringFromDate:date];
    
}


// 判断输入的是否是数字
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addImage:(id)sender {
    UIActionSheet *sheet;

    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
}

#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255)
    {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else
        {
            if (buttonIndex == 0) {
                
                return;
            } else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
        
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [info objectForKey:UIImagePickerControllerReferenceURL];
//    NSLog(@"%@",     [info objectForKey:UIImagePickerControllerReferenceURL]);
//    [self.addImage setImage:image forState:UIControlStateNormal];
    [self.addImage setBackgroundImage:image forState:UIControlStateNormal];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (IBAction)pulishTime:(id)sender {
   
//    [self.publishTime.contentTextField resignFirstResponder];
    
    
    CustomPickView *pickerView= [[CustomPickView alloc]initWithFrame:CGRectMake(0, 960-64, 640, 300)];
    
    pickerView.returnBlock =^(NSArray*ARRAY)
    {
        [self.publishTime setTitle:[NSString stringWithFormat:@"%@-%@-%@",ARRAY[0],ARRAY[1],ARRAY[2]] forState:UIControlStateNormal];
    };
    [pickerView showInView:self.view];

}

#pragma mark - draw a picture
- (IBAction)draw:(id)sender {
    UIStoryboard* storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* drawController = [storyBoard instantiateViewControllerWithIdentifier:@"draw"];
    drawController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:drawController animated:YES completion:nil];
}


@end
