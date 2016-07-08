//
//  HMChannelLabel.h
//  01-网易新闻
//
//  Created by hm04 on 16/6/14.
//  Copyright © 2016年 hm04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMChannelLabel : UILabel

@property (nonatomic, copy) NSString *channelSelectedColor;
@property (nonatomic, copy) NSString *channelNormalColor;
@property (nonatomic, assign) int channelFontSize;


/**
 *  缩放比例
 */
@property (nonatomic, assign) CGFloat scale;

@property (nonatomic, copy) void (^didSelectedLabel)();


+ (instancetype)channelWithText:(NSString *)text;
@end
