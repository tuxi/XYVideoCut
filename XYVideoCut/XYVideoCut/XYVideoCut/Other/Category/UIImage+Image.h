//
//  UIImage+Image.h
//  BaDeJie
//
//  Created by xiaoyuan on 16/9/5.
//  Copyright © 2016年 sey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GradientType) {
    GradientTypeUpToDown = 0,  /*** 上下渐变 **/
    GradientTypeLeftToRight,   /*** 左右渐变 **/
    GradientTypeDiagonalOnBothSides, /*** 对角两侧渐变 **/
    GradientTypeDiagonalOnBothSidesOfTheGradient, /*** 对角两侧渐变 **/
    GradientTypeLinear /** 线性渐变 **/
};

@interface UIImage (Image)

// 根据一个图片的名字快速生成没有渲染的图片
+ (instancetype)xy_imageWithOrignalModeImageName:(NSString *)imageName;

// 处理图片为圆形图片
- (instancetype)xy_circleImage;

// 快速处理图片为圆形图片
+ (instancetype)xy_circleImageWithImageName:(NSString *)imageName;

// 根据颜色生成图片
+ (UIImage *)xy_imageWithColor:(UIColor *)color;

+ (UIImage *)xy_resizingWithImaName:(NSString *)iconName;
+ (UIImage *)xy_resizingWithIma:(UIImage *)ima;


/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param vidoURL 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)xy_imageWithMediaURL:(NSURL *)vidoURL;

//返回渐变的image
+ (UIImage*)xy_gradientImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType inSize:(CGSize)size;
@end
