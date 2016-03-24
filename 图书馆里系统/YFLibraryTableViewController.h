//
//  YFLibraryTableViewController.h
//  图书馆里系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFBookInfo.h"

@class YFVIP;

@interface YFLibraryTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) YFVIP *vip;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic, retain) NSMutableArray *dataArr;
//@property (nonatomic, retain) NSMutableArray *sortedArrForArrays;
//@property (nonatomic, retain) NSMutableArray *sectionHeadsKeys;
@end
