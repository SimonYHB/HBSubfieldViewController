//
//  UIColor+Hex.h
//  testForMain
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 yhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
/**
 *  Create a new UIColor instance using a hex string input
 *
 *  @param hexString color hexString
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString:(id)hexString;
@end
