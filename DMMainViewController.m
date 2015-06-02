//
//  DMMainViewController.m
//  左右切换控制器
//
//  Created by liming on 15/4/6.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import "DMMainViewController.h"
#import "DMPageControl.h"

#define viewCount 4

@interface DMMainViewController ()<UIScrollViewDelegate,DMPageControlSelectedTabbarItem>


@property (nonatomic,weak)UIScrollView *mainScrollView;

@property (nonatomic,weak)DMPageControl *pageControl;

@end

@implementation DMMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  初始化scrollView
     */
    [self setupScrollView];
    /**
     *  初始化CustomPageControl
     */
    [self setupCustomPageControl];
    
}

- (void)setupScrollView
{
    UIScrollView *mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.mainScrollView = mainScrollView;
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor redColor];
    
    CGFloat viewW = self.view.bounds.size.width;
    CGFloat viewH = self.view.bounds.size.height;
    mainScrollView.contentSize = CGSizeMake(viewW *viewCount, viewH);
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.pagingEnabled = YES ;
    mainScrollView.bounces = NO;
    [self.view addSubview:mainScrollView];
    
    for (int index = 0; index <viewCount; index ++) {
        UIView *view = [[UIView alloc]init];
        CGFloat viewX = index *viewW;
        view.frame = CGRectMake(viewX, 0, viewW, viewH);
        double arcColor = arc4random_uniform(255.0)/255.0;
        view.backgroundColor = [UIColor colorWithRed:arcColor green:arcColor blue:arcColor alpha:1];
        [mainScrollView addSubview:view];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(0, 0, 120, 40);
        label.center = self.view.center;
        label.textColor = [UIColor whiteColor];
        label.text = [NSString stringWithFormat:@"这是第%d个view",index+1];
        [view addSubview:label];
    }
}

- (void)setupCustomPageControl
{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *selectedArray = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"tabBar_normal_item%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
        NSString *selectedImageName = [NSString stringWithFormat:@"tabBar_item%d",i];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        [selectedArray addObject:selectedImage];
    }

    
    /**
     *  实现控件方法
     */
    CGFloat tabbarY = [UIScreen mainScreen].bounds.size.height - 44;
    CGFloat tabbarW = [UIScreen mainScreen].bounds.size.width ;
    DMPageControl *pageControl = [[DMPageControl alloc]initWithFrame:CGRectMake(0, tabbarY, tabbarW, 44) NumberOfPages:4 ImageArray:imageArray SelectedArray:selectedArray];
    [self.view addSubview:pageControl];
    pageControl.backgroundColor = [UIColor whiteColor];
    pageControl.delegate = self;
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.pageControl pageOfScrollView:scrollView];
}

#pragma mark - DMPageControlSelectedTabbarItem
- (void)selectedIndex:(NSInteger)index
{
    [self.mainScrollView setContentOffset:CGPointMake(self.view.bounds.size.width *index, 0) animated:YES];
}







@end
