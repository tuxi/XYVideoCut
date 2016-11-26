//
//  XYMenuView.h
//  XYMenuView
//
//  Created by mofeini on 16/11/15.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface XYMenuView : UIView
/** 快速导出 **/
@property (nonatomic, weak) UIButton *fastExportBtn;
/** 高清导出 **/
@property (nonatomic, weak) UIButton *hdExportBtn;
/** 超清导出 **/
@property (nonatomic, weak) UIButton *superclearBtn;
/** 取消 **/
@property (nonatomic, weak) UIButton *cancelBtn;
/** 每个按钮的高度 **/
@property (nonatomic, assign) CGFloat itemHeight;
/** 分割符的颜色 **/
@property (nonatomic, strong) UIColor *separatorColor;

+ (instancetype)menuViewToSuperView:(UIView *)superView;
- (void)showMenuView;
- (void)dismissMenuView;
- (void)showMenuView:(nullable void(^)())block;
- (void)dismissMenuView:(nullable void(^)())block;

@end
NS_ASSUME_NONNULL_END
