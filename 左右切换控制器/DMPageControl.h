//
//  DMPageControl.h
//  左右切换控制器
//
//  Created by liming on 15/4/5.
//  Copyright (c) 2015年 杜蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMPageControlSelectedTabbarItem <NSObject>

- (void)selectedIndex:(NSInteger )index;

@end

@interface DMPageControl : UIView

@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;

- (void)pageOfScrollView:(UIScrollView *)scrollView;
/**
 *  初始化控件方法
 *
 *  @param frame         控件的frame
 *  @param numberOfPages page（页数）的个数
 *  @param imageArray    pageConrol上的图片
 *  @param selectedArray pageConrol上选中的图片
 *
 *  @return DMPageControl控件
 */
- (instancetype)initWithFrame:(CGRect)frame NumberOfPages:(NSInteger)numberOfPages ImageArray:(NSMutableArray *)imageArray SelectedArray:(NSMutableArray *)selectedArray;

@property (nonatomic,weak)id<DMPageControlSelectedTabbarItem>delegate;

@end
