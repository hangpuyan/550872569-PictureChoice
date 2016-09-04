//
//  AppDelegate.m
//  PictureChoice
//
//  Created by Yan on 16/5/1.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "AppDelegate.h"
#import "YHPPictureChoiceController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YHPPictureChoiceController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
