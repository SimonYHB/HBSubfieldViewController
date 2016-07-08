//
//  HBChannelCell.m
//  qiushibaike
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 LouisHors. All rights reserved.
//

#import "HBChannelCell.h"
@interface HBChannelCell ()

@end
@implementation HBChannelCell
-(void)setChannelVC:(UIViewController *)channelVC{
    _channelVC = channelVC;
    [self.contentView addSubview:channelVC.view];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.channelVC.view.frame = self.bounds;
}
@end
