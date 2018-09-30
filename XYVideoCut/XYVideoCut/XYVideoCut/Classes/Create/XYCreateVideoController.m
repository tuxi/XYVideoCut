//
//  XYCreateVideoController.m
//  XYVideoCut
//
//  Created by xiaoyuan on 16/11/14.
//  Copyright © 2016年 alpface. All rights reserved.
//

#import "XYCreateVideoController.h"
#import "XYCreateVideoView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "XYCutVideoController.h"

@interface XYCreateVideoController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation XYCreateVideoController

#pragma mark - View Controller View life
- (void)loadView {
    
    self.navigationItem.title = @"创建";
    
    self.view = [[XYCreateVideoView alloc] initWithCreateButtun:^(UIButton * _Nonnull btn) {
        [btn addTarget:self action:@selector(createVideoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}



#pragma mark - Actions
- (void)createVideoBtnClick {
    
    [self selectAsset];
}

- (void)selectAsset {

    UIImagePickerController *myImagePickerController = [UIImagePickerController new];
    [self setupImagePickerControllerNavBar:myImagePickerController.navigationBar];

    myImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    myImagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    myImagePickerController.delegate = self;
    myImagePickerController.editing = NO;
    if ([NSBundle mainBundle].infoDictionary[@"NSPhotoLibraryUsageDescription"]) {
        [self presentViewController:myImagePickerController animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 成功获取视频或相片时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        XYCutVideoController *cutVideoVc = [XYCutVideoController new];
        cutVideoVc.infoDict = info;
        [self.navigationController pushViewController:cutVideoVc animated:YES];
    }];
    
    
}

- (void)setupImagePickerControllerNavBar:(UINavigationBar *)navigationBar {
    [navigationBar setBackgroundImage:[UIImage xy_imageWithColor:[UIColor colorWithRed:56/255.0 green:55/255.0 blue:53/255.0 alpha:0.8]] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    navigationBar.tintColor = [UIColor whiteColor];
    navigationBar.titleTextAttributes = @{
                                                                  NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                  NSFontAttributeName: [UIFont monospacedDigitSystemFontOfSize:17 weight:0.8]
                                                                  };

}

@end
