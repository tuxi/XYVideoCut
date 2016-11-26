//
//  XYNavigationController.m
//  XYVideoCut
//
//  Created by mofeini on 16/11/14.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import "XYNavigationController.h"


@interface XYNavigationController ()

@end

@implementation XYNavigationController
+ (void)initialize {
    if (self == [XYNavigationController class]) {
        
        UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        [navBar setBackgroundImage:[UIImage xy_imageWithColor:[UIColor colorWithRed:56/255.0 green:55/255.0 blue:53/255.0 alpha:0.8]] forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:[UIImage new]];
        navBar.tintColor = [UIColor whiteColor];
        navBar.titleTextAttributes = @{
                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                       NSFontAttributeName: [UIFont monospacedDigitSystemFontOfSize:17 weight:0.8]
                                       };
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.childViewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - Private
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


@end
