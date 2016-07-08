//
//  MainViewController.m
//  HBSubfieldViewControllerDemo
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 yhb. All rights reserved.
//

#import "MainViewController.h"
#import "HB_NavigationViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"

@interface MainViewController ()
@property (nonatomic,strong) NSArray<UIViewController *> *vcArray;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@property (nonatomic, strong) NSArray<NSString *> *longTitleArray;
@property (nonatomic, weak) HB_NavigationViewController *navi;
@property (nonatomic,weak) UISegmentedControl *segment;
@property (nonatomic, weak) UITextField *titleColor;
@property (nonatomic, weak) UITextField *selectedColor;
@property (nonatomic, weak) UITextField *fontSize;
@property (nonatomic, weak) UITextField *channelBackgroundColor;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 事件

-(void)btnOneClick{
    HB_NavigationViewController *navi = [HB_NavigationViewController navigationViewControllerWithVCArray:self.vcArray andTitleArray:self.titleArray andStyle:HBSubfieldStyleNormal];
    navi.channelNormalColor = self.titleColor.text;
    navi.channelSelectedColor = self.selectedColor.text;
    navi.channelFontSize = self.fontSize.text.intValue;
    navi.channelBackgroundColor = self.channelBackgroundColor.text;
    //添加一个返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClick)];
    navi.visibleViewController.navigationItem.leftBarButtonItem = backItem;
    
    self.navi = navi;
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)btnTwoClick{
    HB_NavigationViewController *navi = [HB_NavigationViewController navigationViewControllerWithVCArray:self.vcArray andTitleArray:self.titleArray andStyle:HBSubfieldStyleNaviTitle];
    
    
    navi.channelNormalColor = self.titleColor.text;
    navi.channelSelectedColor = self.selectedColor.text;
    navi.channelFontSize = self.fontSize.text.intValue;
    navi.channelBackgroundColor = self.channelBackgroundColor.text;
    //添加一个返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClick)];
    navi.visibleViewController.navigationItem.leftBarButtonItem = backItem;
    
    self.navi = navi;
    [self presentViewController:navi animated:YES completion:nil];
}

-(void)cancelClick{
    [self.navi dismissViewControllerAnimated:YES completion:^{
        self.navi = nil;
    }];
}

-(void)segmentChange:(UISegmentedControl *)segment{
    self.titleArray = segment.selectedSegmentIndex == 0? @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5"]:@[@"小泽玛利亚",@"吉泽明步",@"仓井利亚",@"宇都宫紫苑",@"樱井莉亚"];
}
#pragma mark - 建立UI控件
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    btnOne.frame = CGRectMake(50, 50, 200, 50);
    btnOne.backgroundColor = [UIColor blackColor];
    [btnOne setTitle:@"styleNormal" forState:UIControlStateNormal];
    [btnOne addTarget:self action:@selector(btnOneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnOne];
    
    UIButton *btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTwo.frame = CGRectMake(50, 150, 200, 50);
    btnTwo.backgroundColor = [UIColor blackColor];
    [btnTwo setTitle:@"styleNavi" forState:UIControlStateNormal];
    [btnTwo addTarget:self action:@selector(btnTwoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTwo];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"短标题",@"长标题"]];
    self.segment = segment;
    segment.frame = CGRectMake(50, 250, 200, 50);
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    UITextField *titleColor = [[UITextField alloc] init];
    titleColor.backgroundColor = [UIColor lightGrayColor];
    titleColor.placeholder = @"请输入标题颜色(16进制)#000000";
    titleColor.frame = CGRectMake(10, 350, 300, 30);
    self.titleColor = titleColor;
    [self.view addSubview:titleColor];
    
    UITextField *selectedTitleColor = [[UITextField alloc] init];
    selectedTitleColor.backgroundColor = [UIColor lightGrayColor];
    selectedTitleColor.placeholder = @"请输入选中标题颜色(16进制)#000000";
    selectedTitleColor.frame = CGRectMake(10, 400, 300, 30);
    self.selectedColor = selectedTitleColor;
    [self.view addSubview:selectedTitleColor];
    
    UITextField *fontSize = [[UITextField alloc] init];
    fontSize.backgroundColor = [UIColor lightGrayColor];
    fontSize.placeholder = @"请输入文字大小,默认为16";
    fontSize.frame = CGRectMake(10, 450, 300, 30);
    self.fontSize = fontSize;
    [self.view addSubview:fontSize];
    
    UITextField *channelBackgroundColor = [[UITextField alloc] init];
    channelBackgroundColor.backgroundColor = [UIColor lightGrayColor];
    channelBackgroundColor.placeholder = @"请输入channel栏的背景颜色,默认为白色";
    channelBackgroundColor.frame = CGRectMake(10, 500, 300, 30);
    self.channelBackgroundColor = channelBackgroundColor;
    [self.view addSubview:channelBackgroundColor];
}

#pragma mark - 加载数据
-(NSArray<UIViewController *> *)vcArray{
    if (_vcArray == nil) {
        UIViewController *vc1 = [[OneViewController alloc] init];
        UIViewController *vc2 = [[TwoViewController alloc] init];
        UIViewController *vc3 = [[ThreeViewController alloc] init];
        UIViewController *vc4 = [[FourViewController alloc] init];
        UIViewController *vc5 = [[FiveViewController alloc] init];
        
        _vcArray = @[vc1,vc2,vc3,vc4,vc5];
    }
    return _vcArray;
}

-(NSArray<NSString *> *)titleArray{
    if (_titleArray == nil) {
        _titleArray = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5"];
    }
    return _titleArray;
}

@end
