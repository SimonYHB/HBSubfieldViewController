//
//  HB_QYQCollectionViewController.h
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HB_MainViewController : UIViewController

@property (nonatomic, copy) NSString *channelSelectedColor;
@property (nonatomic, copy) NSString *channelNormalColor;
@property (nonatomic, assign) int channelFontSize;
@property (nonatomic, copy) NSString *channelBackgroundColor;

//-(instancetype)initWithPlistName:(NSString *)plistName;

-(instancetype)initNormalWithVCArray:(NSArray<UIViewController *> *)vcArray andTitleArray:(NSArray<NSString *> *)titleArray;
-(instancetype)initNaviTitleWithVCArray:(NSArray<UIViewController *> *)vcArray andTitleArray:(NSArray<NSString *> *)titleArray;


@end
