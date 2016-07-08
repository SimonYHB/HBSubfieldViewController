//
//  AppDelegate.m
//  HBSubfieldViewControllerDemo
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 yhb. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    MainViewController *controller = [[MainViewController alloc] init];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
