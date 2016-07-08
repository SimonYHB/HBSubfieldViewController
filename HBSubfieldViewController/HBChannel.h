//
//  HBChannel.h
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBChannel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *SBName;
+(NSArray *)channelsWithTitleArray:(NSArray *)titleArray;
//+(NSArray *)channelsWithPlist:(NSString *)plist;
@end
