//
//  YFRootViewController.m
//  图书管理系统
//
//  Created by 张艺峰 on 15/11/8.
//  Copyright © 2015年 张艺峰. All rights reserved.
//

#import "YFRootViewController.h"

#import "YFLoginViewController.h"

@interface YFRootViewController ()<UIPageViewControllerDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YFRootViewController

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = 5;
        CGSize size = [_pageControl sizeForNumberOfPages:5];
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.view.center.x, self.scrollView.bounds.size.height - 100);
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor redColor];
        
        [self.view addSubview:_pageControl];
        
    }
    return _pageControl;
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _scrollView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(5 * _scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self scrollView];
    for (int i = 0; i < 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"root%d", i + 1];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    
    UIButton *start = [[UIButton alloc] initWithFrame:CGRectMake( 4 * self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height)];
    
    [self.scrollView addSubview:start];

    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self pageControl];
    
}

- (void)start
{
    NSLog(@"start");
    
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YFLoginViewController *login = [storyBoard instantiateViewControllerWithIdentifier:@"to"];
    login.modalTransitionStyle = UIPushBehaviorModeInstantaneous;
    [self presentViewController:login animated:YES completion:nil];

 
}


#pragma mark - scrollView代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
}


@end
