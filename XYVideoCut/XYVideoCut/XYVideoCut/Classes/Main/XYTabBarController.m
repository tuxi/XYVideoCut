//
//  XYTabBarController.m
//  XYVideoCut
//
//  Created by mofeini on 16/11/14.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import "XYTabBarController.h"
#import "XYCreateVideoController.h"
#import "XYMyMovieViewController.h"
#import "XYNavigationController.h"

@interface XYTabBarController ()

@end

@implementation XYTabBarController

+ (void)initialize
{
    if (self == [XYTabBarController class]) {
        UITabBar *tabBar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]];
        tabBar.tintColor = [UIColor darkTextColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYNavigationController *createNav = [[XYNavigationController alloc] initWithRootViewController:[XYCreateVideoController new]];
    createNav.tabBarItem.image = [UIImage xy_imageWithOrignalModeImageName:@"Menu_Feed"];
    createNav.tabBarItem.selectedImage = [UIImage xy_imageWithOrignalModeImageName:@"Menu_Feed_selected"];
    createNav.tabBarItem.title = @"Home";
    [self addChildViewController:createNav];
    
    XYNavigationController *myMovieNav = [[XYNavigationController alloc] initWithRootViewController:[XYMyMovieViewController new]];
    myMovieNav.tabBarItem.image = [UIImage xy_imageWithOrignalModeImageName:@"Menu_MyAlbums"];
    myMovieNav.tabBarItem.selectedImage = [UIImage xy_imageWithOrignalModeImageName:@"Menu_MyAlbums_selected"];
    myMovieNav.tabBarItem.title = @"My Movie";
    [self addChildViewController:myMovieNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
