//
//  HB_QYQNaviViewController.h
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    HBSubfieldStyleNormal,
    HBSubfieldStyleNaviTitle
}HBSubfieldStyle;

@interface HB_NavigationViewController : UINavigationController

@property (nonatomic, copy) NSString *channelSelectedColor;
@property (nonatomic, copy) NSString *channelNormalColor;

@property (nonatomic, assign) int channelFontSize;
@property (nonatomic, copy) NSString *channelBackgroundColor;

+(instancetype)navigationViewControllerWithVCArray:(NSArray <UIViewController *>*)vcArray andTitleArray:(NSArray <NSString *> *)titleArray andStyle:(HBSubfieldStyle)style;

//-(instancetype)initWithPlistName:(NSString *)plistName;
@end
