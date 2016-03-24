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
#import "YFBookInfo.h"
#import "YFVIP.h"
#import "YFEditUserViewController.h"



@interface YFLibraryTableViewController ()<UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *books;

@property (nonatomic, strong) NSMutableArray *arrayOfCharacters;

@end

@implementation YFLibraryTableViewController


NSArray *searchResult;
bool isSearch = false;

- (NSMutableArray *)books
{
    if (_books == nil) {
        _books = [NSMutableArray array];
    }
    return _books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initData];
//    NSLog(@"%@", self.vip.name);
    NSLog(@"@@@@Q@@@@");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(freshTableData) name:@"refreshData" object:nil];
    self.searchBar.delegate = self;
//    [self.navigationController.viewControllers objectAtIndex:2];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isSearch) {
        return searchResult.count;
    }else{
//        return [[self.sortedArrForArrays objectAtIndex:section] count];
        YFBookManage *manage = [YFBookManage sharedObject];
        NSArray *array = [manage getAllBooks];
//        NSLog(@"----%d", array.count);
        return array.count;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
        YFBookManage* bookService = [YFBookManage sharedObject];
        NSMutableArray* books = [bookService getAllBooks];
        bookInfo = [books objectAtIndex:indexPath.row];
        cell.textLabel.text = bookInfo.bookName;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"作者：%@\n出版社：%@\n简介：%@\n出版时间：%@",bookInfo.authorName, bookInfo.publish,bookInfo.authorDec, bookInfo.publishTime];

        cell.backgroundColor = self.view.backgroundColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        
//        NSArray *array = [self.sortedArrForArrays objectAtIndex:indexPath.section];
//        ChineseString *str = [array objectAtIndex:indexPath.row];
//        NSLog(@"str-----%@", str.string);
        YFBookManage* bookService = [YFBookManage sharedObject];
        NSMutableArray* books = [bookService getAllBooks];
        bookInfo = [books objectAtIndex:indexPath.row];
        cell.textLabel.text = bookInfo.bookName;
        
//        cell.detailTextLabel.text = info.authorName;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"作者：%@\n出版社：%@\n简介：%@\n出版时间：%@",bookInfo.authorName, bookInfo.publish,bookInfo.authorDec, bookInfo.publishTime];
        
//        NSLog(@"%@", bookInfo.image);
//        NSString *str = [bookInfo.image ]
        cell.imageView.image = [UIImage imageWithContentsOfFile:bookInfo.image];
        
        cell.backgroundColor = self.view.backgroundColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.textLabel.text = bookInfo.bookName;
//    cell.detailTextLabel.text = bookInfo.authorName;
//    cell.backgroundColor = self.view.backgroundColor;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.arrayOfCharacters addObject:cell.textLabel.text];
    
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

}


- (void)freshTableData{
//    [self initData];
    [self.tableView reloadData];
}




#pragma mark - searchBar DataSourse
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self filterSearchResult:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* searchText = searchBar.text;
    [self filterSearchResult:searchText];
}

- (void)filterSearchResult:(NSString*)searchText{
    if ([searchText isEqualToString:@""]) {
        [self.tableView reloadData];
        return;
    }
    isSearch = TRUE;
    YFBookManage *bookService = [YFBookManage sharedObject];
    NSMutableArray *books = [bookService getAllBooks];
    
    NSMutableArray *copy = [NSMutableArray array];
    
    for (YFBookInfo *info in books) {
        NSRange titleResule = [info.bookName rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (titleResule.length > 0) {
            [copy addObject:info];
        }
    }
    
//    NSPredicate *predict = [NSPredicate predicateWithFormat:@"bookName contains %@",searchText];
//    searchResult = [books filteredArrayUsingPredicate:predict];
    
    searchResult = copy;
    NSLog(@"%d", copy.count);
    
    [self.tableView reloadData];
}





#pragma mark - 个人信息
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[YFEditUserViewController class]]) {
        
        YFEditUserViewController *user = segue.destinationViewController;
//        user.navigationItem.title = [NSString stringWithFormat:@"%@的个人信息", self.vip.name];
        
        user.vip = self.vip;
    }
}

@end
