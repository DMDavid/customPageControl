//
//  DMPageControl.m
//  左右切换控制器
//
//  Created by liming on 15/4/5.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import "DMPageControl.h"

@interface DMPageControl()

@property (nonatomic,strong)NSMutableArray *imageViewArray;
/**
 *  普通状态的图片数组
 */
@property (nonatomic,strong)NSMutableArray *imageArray;
/**
 *  选中状态的图片数组
 */
@property (nonatomic,strong)NSMutableArray *SelectedImageArray;
/**
 *  父类的frame
 */
@property (nonatomic,assign)CGRect superFrame;
/**
 *  记录原来的所在的页数
 */
@property (nonatomic,assign)NSInteger oldCurrentPage;
/**
 *  透明度
 */
@property (nonatomic,assign)double alphaPage;

@end

@implementation DMPageControl

- (void)drawRect:(CGRect)rect {
    
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    self.alphaPage =0;
    for (int i =0 ; i <numberOfPages; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = self.imageArray[i];
        if (i == 0) {
            imageView.image = self.SelectedImageArray[i];
        }else{
            imageView.image = self.imageArray[i];
        }
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTabbarItem:)]];
        CGFloat superViewW =  _superFrame.size.width;
        CGFloat tabbarW = superViewW/numberOfPages;
        imageView.frame = CGRectMake(tabbarW *i, 0, tabbarW, _superFrame.size.height);
        [self addSubview:imageView];
        [self.imageViewArray addObject:imageView];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    UIImageView *nowImageView = self.imageViewArray[currentPage];
    nowImageView.image = self.SelectedImageArray[currentPage];
    [self.imageViewArray replaceObjectAtIndex:currentPage withObject:nowImageView];
    if (self.oldCurrentPage != currentPage) {
        UIImageView *oldImageView = self.imageViewArray[self.oldCurrentPage];
        oldImageView.image = self.imageArray[self.oldCurrentPage];
        [self.imageViewArray replaceObjectAtIndex:self.oldCurrentPage withObject:oldImageView];
    }
    self.oldCurrentPage = currentPage;
}

- (void)pageOfScrollView:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    double pageDouble = offSetX/scrollView.frame.size.width;
    int pageInt = (int)(pageDouble +0.5);
    int alphaInt= (int)pageDouble ;
//    NSLog(@"%d", alphaInt);
    self.currentPage = pageInt;
    self.alphaPage = pageDouble -alphaInt ;
    if (self.alphaPage == 0) {
        self.alphaPage = 1;
    }
    
}

- (void)tapTabbarItem:(UIGestureRecognizer *)recognizer
{
    UIImageView *nowImageView = self.imageViewArray[recognizer.view.tag];
    nowImageView.image = self.SelectedImageArray[recognizer.view.tag];
    if (self.oldCurrentPage != (int)recognizer.view.tag) {
        UIImageView *oldImageView = self.imageViewArray[self.oldCurrentPage];
        oldImageView.image = self.imageArray[self.oldCurrentPage];
        [self.imageViewArray replaceObjectAtIndex:self.oldCurrentPage withObject:oldImageView];
    }
    self.oldCurrentPage = (int)recognizer.view.tag;
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:recognizer.view.tag];
    }
}

- (instancetype)initWithFrame:(CGRect)frame NumberOfPages:(NSInteger)numberOfPages ImageArray:(NSMutableArray *)imageArray SelectedArray:(NSMutableArray *)selectedArray

{
    if (self = [super initWithFrame:frame]) {
        self.imageViewArray = [NSMutableArray array];
        self.imageArray = imageArray;
        self.SelectedImageArray = selectedArray;
        _superFrame =frame;
        [self setNumberOfPages:numberOfPages];
    }
    return self;
}


@end
