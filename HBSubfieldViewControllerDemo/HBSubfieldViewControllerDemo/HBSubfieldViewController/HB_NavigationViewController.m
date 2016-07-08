//
//  HB_QYQNaviViewController.m
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import "HB_NavigationViewController.h"
#import "HB_MainViewController.h"
@interface HB_NavigationViewController ()
@property (nonatomic,weak) HB_MainViewController *vc;

@end

@implementation HB_NavigationViewController

+(instancetype)navigationViewControllerWithVCArray:(NSArray<UIViewController *> *)vcArray andTitleArray:(NSArray<NSString *> *)titleArray andStyle:(HBSubfieldStyle)style{
    HB_NavigationViewController *navi = [[HB_NavigationViewController alloc] init];
    HB_MainViewController *vc = nil;
    if (style == HBSubfieldStyleNormal) {
        vc = [[HB_MainViewController alloc] initNormalWithVCArray:vcArray andTitleArray:titleArray];
    } else if (style == HBSubfieldStyleNaviTitle){
        vc = [[HB_MainViewController alloc] initNaviTitleWithVCArray:vcArray andTitleArray:titleArray];
    } else {
        return nil;
    }

    [navi addChildViewController:vc];
    navi.vc = vc;
    return navi;
}

//-(instancetype)initWithPlistName:(NSString *)plistName{
//    if (self = [super init]) {
//        HB_QYQCollectionViewController *vc = [[HB_QYQCollectionViewController alloc]initWithPlistName:plistName];
//        [self addChildViewController:vc];
//        self.vc = vc;
//    }
//    return self;
//}

-(void)setChannelSelectedColor:(NSString *)channelSelectedColor{
    self.vc.channelSelectedColor = channelSelectedColor;
}

-(void)setChannelNormalColor:(NSString *)channelNormalColor{
    self.vc.channelNormalColor = channelNormalColor;
}

-(void)setChannelBackgroundColor:(NSString *)channelBackgroundColor{
    self.vc.channelBackgroundColor = channelBackgroundColor;
}

-(void)setChannelFontSize:(int)channelFontSize{
    self.vc.channelFontSize = channelFontSize;
}
@end
