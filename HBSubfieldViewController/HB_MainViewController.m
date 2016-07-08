//
//  HB_QYQCollectionViewController.m
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import "HB_MainViewController.h"
#import "HBChannel.h"
#import "HMChannelLabel.h"
#import "HBChannelCell.h"
#import "UIColor+Hex.h"
#import <objc/runtime.h>
typedef enum {
    HBViewControllerTypeNormal,
    HBViewControllerTypeNaviTitle
}HBViewControllerType;
@interface HB_MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) HBViewControllerType type;
/**
 *  布局参数
 */
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
/**
 *  频道view
 */
@property (nonatomic, weak) UIScrollView *channelView;
/**
 *  主显示界面view
 */
@property (nonatomic, weak) UICollectionView *collectionView;
/**
 *  选中当前频道标签索引
 */
@property (nonatomic,assign) NSInteger currentIndex;
/**
 *  所有频道数据
 */
@property (nonatomic,strong) NSArray *channels;
/**
 *  控制器缓冲池
 */
@property (nonatomic, strong) NSMutableDictionary *channelVCCache;
/**
 *  控制器数组(未初始化)
 */
@property (nonatomic, strong) NSArray *channelVCArray;
@end

@implementation HB_MainViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)initNormalWithVCArray:(NSArray<UIViewController *> *)vcArray andTitleArray:(NSArray<NSString *> *)titleArray{
    self = [self init];
    self.channels = [HBChannel channelsWithTitleArray:titleArray];
    self.channelVCArray = vcArray;
    self.type = HBViewControllerTypeNormal;
    return self;
}

-(instancetype)initNaviTitleWithVCArray:(NSArray<UIViewController *> *)vcArray andTitleArray:(NSArray<NSString *> *)titleArray{
    self = [self init];
    self.channels = [HBChannel channelsWithTitleArray:titleArray];
    self.channelVCArray = vcArray;
    self.type = HBViewControllerTypeNaviTitle;
    return self;
}

//-(instancetype)initWithPlistName:(NSString *)plistName{
//    self = [self init];
//    self.channels = [HBChannel channelsWithPlist:plistName];
//    return self;
//}


//-(instancetype)init{
//    
//    return [super initWithCollectionViewLayout:layout];
//}

-(UICollectionViewFlowLayout *)layout{
    if (_layout == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.layout = layout;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
    }
    return _layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviCtl];
    [self configSomething];
    
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.layout.itemSize = CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height );
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//}
#pragma mark - private method
/**
 *  配置些其他参数
 */
- (void)configSomething{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerClass:[HBChannelCell class] forCellWithReuseIdentifier:reuseIdentifier];
}
/**
 *  配置导航条的参数
 */
- (void)configNaviCtl{
    [self configChannalView];
    
}
/**
 *  配置channalView
 */
- (void)configChannalView{
    
    
    
    //如果是navi,则如下
    if (self.type == HBViewControllerTypeNaviTitle) {
        CGFloat channalWidth = [UIScreen mainScreen].bounds.size.width;
        for (UIView *v in self.navigationController.navigationBar.subviews) {
#warning 更改处
            if ([v isKindOfClass:objc_getClass("UINavigationButton")] ||[v isKindOfClass:objc_getClass("UIButton")]) {
                channalWidth -= v.frame.size.width;
                
                //                if (barButtonView==nil) {
                //                    if (v.frame.origin.x > 0.0)
                //                        barButtonView = v;
                //                } else if (v.frame.origin.x < barButtonView.frame.origin.x && v.frame.origin.x>0.0) {
                //                    barButtonView = v;  // this view is further right
                //                }
            }
        }
        UIScrollView *channalView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, channalWidth - 50, 44)];
        NSLog(@"channalview-->%f",channalWidth);
        self.channelView = channalView;
        if (self.channelBackgroundColor != nil) {
            UIColor *backgroudColor = [UIColor colorWithHexString:self.channelBackgroundColor];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            
            UIImageView* naviBarImageView = [self.navigationController.navigationBar.subviews firstObject];
            naviBarImageView.backgroundColor = backgroudColor;
        }

        self.navigationItem.titleView = channalView;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        [self.view addSubview:collectionView];
    } else {
        UIScrollView *channalView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        self.channelView = channalView;
        if (self.channelBackgroundColor != nil) {
            UIColor *backgroudColor = [UIColor colorWithHexString:self.channelBackgroundColor];
            //设置外界传入的背景色
            self.channelView.backgroundColor = backgroudColor;
        }
        
        
        [self.view addSubview:channalView];
        CGRect frame = CGRectMake(0, self.channelView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.channelView.bounds.size.height);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:self.layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        [self.view addSubview:collectionView];
    }
    
    
    
    //-----------------------------------------------------
    NSInteger index = 0;
    __weak typeof(self) weakVc = self;
    CGFloat labelX = 0;
    CGFloat marginX = 20;
    CGFloat totalLabelWidth = 0;
    NSMutableArray *labelArray = [NSMutableArray arrayWithCapacity:self.channels.count];
    for (HBChannel *channel in self.channels) {
        HMChannelLabel *label = [HMChannelLabel channelWithText:channel.name];
        //设置外界传进来的参数
        label.channelSelectedColor = self.channelSelectedColor;
        label.channelNormalColor = self.channelNormalColor;
        label.channelFontSize = self.channelFontSize;
        
        
        totalLabelWidth += label.frame.size.width;
        label.tag = index++;
        __weak typeof(label) weakLabel = label;
        //设置点击
        [label setDidSelectedLabel:^{
            HMChannelLabel *currentLabel = weakVc.channelView.subviews[weakVc.currentIndex];
            if(currentLabel.tag == weakLabel.tag) return ;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:weakLabel.tag inSection:0];
            [weakVc.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
            weakLabel.scale = 1.0;
            currentLabel.scale = 0.0;
            weakVc.currentIndex = weakLabel.tag;
            [self setupSelectedLabelContentOffset];
        }];
        [labelArray addObject:label];
        
    }
    index = 0;
    for (HMChannelLabel *label in labelArray) {
        //设置frame
        index++;
        //需要选拿到总宽度才能算出最大margin
        CGFloat maxMarginX = (self.channelView.frame.size.width  - totalLabelWidth) / (self.channels.count - 1);
        NSLog(@"%f",self.channelView.frame.size.width);
        if (maxMarginX > marginX) {
            marginX = maxMarginX;
        }
#warning 此处frame有问题,跟整个NAVI的取值有关,扣除的button值不准确
        label.frame = CGRectMake(labelX , 0, label.frame.size.width, self.channelView.bounds.size.height);
        
        //        label.text = channel.name;
        [self.channelView addSubview:label];
        
        if (index == self.channelVCArray.count ) {
            weakVc.channelView.contentSize = CGSizeMake(CGRectGetMaxX(label.frame) , 0);
        } else {
            labelX += label.frame.size.width + marginX ;
        }
    }
    self.channelView.showsHorizontalScrollIndicator = NO;
    self.channelView.showsVerticalScrollIndicator = NO;
    // 设置滚动范围
    // 默认选择第一个频道标签
    HMChannelLabel *currentLabel =  self.channelView.subviews[self.currentIndex];
    currentLabel.scale = 1;
}

/**
 *  设置自动往中间缩进
 */
- (void)setupSelectedLabelContentOffset{
    self.currentIndex = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    HMChannelLabel *currentLabel = self.channelView.subviews[self.currentIndex];
    // 获得选中频道标签中心点的x值
    CGFloat offsetX = currentLabel.center.x - self.channelView.bounds.size.width * 0.5;
    // 计算最大偏移量
    CGFloat maxOffsetX = self.channelView.contentSize.width - self.channelView.bounds.size.width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    // 修改偏移量
    [self.channelView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}



#pragma mark - collectionView dateSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)
collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HBChannel *channel = self.channels[indexPath.item];
    UIViewController *channelVC;
    HBChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.channelVCCache[channel.name]) {
        channelVC = self.channelVCCache[channel.name];
    } else {
        //         channelVC = [UIStoryboard storyboardWithName:channel.SBName bundle:nil].instantiateInitialViewController;
        channelVC = self.channelVCArray[indexPath.item];
        [self.channelVCCache setObject:channelVC forKey:channel.name];
    }
    cell.channelVC = channelVC;
    
    return cell;
}

#pragma mark - scollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 根据当前索引获得频道标签
    HMChannelLabel *currentChannelLabel = self.channelView.subviews[self.currentIndex];
    
    // 获得可见的indexPath
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    // 声明下一个频道标签
    HMChannelLabel *nextChannelLabel = nil;
    // 遍历indexPaths
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.item != self.currentIndex) { // 找到下一标签
            nextChannelLabel = self.channelView.subviews[indexPath.item];
            break;
        }
    }
    if(nextChannelLabel == nil)return;
    
    // 计算缩放比例 0 - 1
    // 计算下一个频道标签的比例值
    CGFloat nextScale  = ABS(self.collectionView.contentOffset.x / self.collectionView.bounds.size.width - self.currentIndex);
    // 计算当前频道标签的比例值
    CGFloat currentScale = 1 - nextScale;
    
    // 设置缩放比例
    currentChannelLabel.scale = currentScale;
    nextChannelLabel.scale = nextScale;
    
    [self setupSelectedLabelContentOffset];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setupSelectedLabelContentOffset];
    
}


#pragma mark - 懒加载
-(NSMutableDictionary *)channelVCCache{
    if (_channelVCCache == nil) {
        _channelVCCache = [NSMutableDictionary dictionary];
    }
    return _channelVCCache;
}




@end
