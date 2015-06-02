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


实现两个代理方法：
pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView；
 
pragma mark - DMPageControlSelectedTabbarItem
- (void)selectedIndex:(NSInteger)index；
