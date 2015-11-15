//
//  YFLibraryTableViewController.m
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFLibraryTableViewController.h"
#import "YFEditBookViewController.h"
#import "YFBookManage.h"

@interface YFLibraryTableViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>

@end

@implementation YFLibraryTableViewController
NSMutableArray* searchResult;
bool isSearch = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(freshTableData) name:@"refreshData" object:nil];
    self.searchBar.delegate = self;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    if (isSearch) {
//        return searchResult.count;
//    }else{
//        YFBookManage* bookService = [YFBookManage sharedObject];
//        return [bookService.getAllBooks count];
//    }
//
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isSearch) {
        return searchResult.count;
    }else{
        YFBookManage* bookService = [YFBookManage sharedObject];
        return [bookService.getAllBooks count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    YFBookInfo* bookInfo =[[YFBookInfo alloc]init];
    if (isSearch) {
        bookInfo = [searchResult objectAtIndex:indexPath.row];
        if (searchResult.count == indexPath.row+1) {
            isSearch = false;
        }
    }else{
        YFBookManage* bookService = [YFBookManage sharedObject];
        NSMutableArray* books = [bookService getAllBooks];
        bookInfo =[books objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = bookInfo.bookName;
    cell.detailTextLabel.text = bookInfo.authorName;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard* storyBoard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YFEditBookViewController* editBook = [storyBoard instantiateViewControllerWithIdentifier:@"editBook"];
    editBook.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    YFBookManage* bookService = [YFBookManage sharedObject];
    NSMutableArray* books = [bookService getAllBooks];
    [editBook setBookInfo:[books objectAtIndex:indexPath.row]];
    [self presentViewController:editBook animated:YES completion:nil];


    editBook.bookName.text = @"张三";
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
