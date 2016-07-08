//
//  HMChannelLabel.m
//  01-网易新闻
//
//  Created by hm04 on 16/6/14.
//  Copyright © 2016年 hm04. All rights reserved.
//

#import "HMChannelLabel.h"
#import "UIColor+Hex.h"
@interface HMChannelLabel ()
@property (nonatomic, strong) CIColor *selectedColor;
@property (nonatomic, strong) CIColor *normalColor;
@end
@implementation HMChannelLabel

#define HMNormalSize 16

-(void)setChannelSelectedColor:(NSString *)channelSelectedColor{
    if (channelSelectedColor == nil) {
        return;
    }
    _channelSelectedColor = channelSelectedColor;
    UIColor *color = [UIColor colorWithHexString:channelSelectedColor];
    self.selectedColor = [CIColor colorWithCGColor:color.CGColor];
}

-(void)setChannelNormalColor:(NSString *)channelNormalColor{
    if (channelNormalColor == nil) {
        return;
    }
    
    _channelNormalColor = channelNormalColor;
    UIColor *color = [UIColor colorWithHexString:channelNormalColor];
    self.textColor = color;
    self.normalColor = [CIColor colorWithCGColor:color.CGColor];
}

-(void)setChannelFontSize:(int)channelFontSize{
    if (channelFontSize == 0) {
        return;
    }
    _channelFontSize = channelFontSize;
//    [self setNeedsDisplay];
    self.font = [UIFont systemFontOfSize:channelFontSize];
    [self sizeToFit];
}



+ (instancetype)channelWithText:(NSString *)text {
    // 创建新闻频道标签
    HMChannelLabel *label = [[self alloc] init];
    // 设置可交互
    label.userInteractionEnabled = YES;
    label.selectedColor = [CIColor colorWithCGColor:[UIColor orangeColor].CGColor];
    label.normalColor = [CIColor colorWithCGColor:[UIColor blackColor].CGColor];
    label.channelFontSize = HMNormalSize;
    label.textAlignment = NSTextAlignmentCenter;
    // 设置字体大小
    label.font = [UIFont systemFontOfSize:label.channelFontSize];
    // 设置文字
    label.text = text;
    //    // 让尺寸跟随文字字体自适应
    [label sizeToFit];
    
    //    
    
    return label;
}
// scale:0 到 1
- (void)setScale:(CGFloat)scale {
    _scale = scale;

    self.textColor = [UIColor colorWithRed:(self.normalColor.red + (self.selectedColor.red - self.normalColor.red) * scale)
                                     green:(self.normalColor.green + (self.selectedColor.green - self.normalColor.green) * scale)
                                      blue:(self.normalColor.blue + (self.selectedColor.blue - self.normalColor.blue) * scale) alpha:1.0];

    
//    self.textColor = [UIColor colorWithRed:ABS(self.selectedColor.red - self.normalColor.red) * scale green:ABS(self.selectedColor.green - self.normalColor.green) * scale blue:ABS(self.selectedColor.blue - self.normalColor.blue) * scale alpha:1.0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.didSelectedLabel) {
        self.didSelectedLabel();
    }
}
@end
