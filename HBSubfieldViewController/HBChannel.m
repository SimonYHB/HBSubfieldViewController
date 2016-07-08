//
//  HBChannel.m
//  连动导航栏
//
//  Created by apple on 7/5/16.
//  Copyright © 2016 yhb. All rights reserved.
//

#import "HBChannel.h"

@implementation HBChannel

//+ (instancetype)channelWithDict:(NSDictionary *)dict {
//    id obj = [[self alloc] init];
//    
//    [obj setValuesForKeysWithDictionary:dict];
//    
//    return obj;
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+(NSArray *)channelsWithTitleArray:(NSArray *)titleArray{
    NSMutableArray *channelsArray = [NSMutableArray arrayWithCapacity:titleArray.count];
    [titleArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        HBChannel *channel = [[self alloc]init];
        channel.name = title;
        [channelsArray addObject:channel];
    }];
    return channelsArray;
}

//+(NSArray *)channelsWithPlist:(NSString *)plist{
//
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:plist ofType:nil];
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    NSMutableArray *channelArr = [NSMutableArray arrayWithCapacity:dictArr.count];
//    for (NSDictionary *dict in dictArr) {
//        HBChannel *channel = [HBChannel channelWithDict:dict];
//        [channelArr addObject:channel];
//    }
//    return [channelArr copy];
//}
@end
