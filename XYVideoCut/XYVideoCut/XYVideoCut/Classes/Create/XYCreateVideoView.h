//
//  XYCreateVideoView.h
//  XYVideoCut
//
//  Created by mofeini on 16/11/14.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface XYCreateVideoView : UIView


- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCreateButtun:(void(^)(UIButton *btn))createButton NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
