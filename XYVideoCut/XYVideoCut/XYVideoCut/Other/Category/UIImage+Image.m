//
//  UIImage+Image.m
//  BaDeJie
//
//  Created by xiaoyuan on 16/9/5.
//  Copyright © 2016年 sey. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/message.h>
#import <AVFoundation/AVFoundation.h>



@implementation UIImage (Image)

+ (UIImage *)xy_imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 1.0);
    CGContextRef contexRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contexRef, [color CGColor]);
    CGContextFillRect(contexRef, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)xy_resizingWithImaName:(NSString *)iconName
{
    return [self xy_resizingWithIma: [UIImage imageNamed: iconName]];
}

+ (UIImage *)xy_resizingWithIma:(UIImage *)ima
{
    CGFloat w = ima.size.width * 0.499;
    CGFloat h = ima.size.height * 0.499;
    return [ima resizableImageWithCapInsets: UIEdgeInsetsMake(h, w, h, w)];
}



+ (UIImage *)xy_imageWithOrignalModeImageName:(NSString *)imageName {

    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


// 使用runtime交换方法
//+ (void)load {
//
//    // 获取需要交换的两个方法
//    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
//    Method imageWithOrignalModeImageNameMethod = class_getClassMethod(self, @selector(imageWithOrignalModeImageName:));
//    
//    // 交换两个方法的实现
//    method_exchangeImplementations(imageNamedMethod, imageWithOrignalModeImageNameMethod);
//
//}

- (instancetype)xy_circleImage {

    // 1.开启图形上下文,并且上下文的尺寸和图片的大小一样
    // 第三个参数:当前点与像素的比例，传0系统会自动适配
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    
    // 2.绘制圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    // 3.添加到裁剪
    [path addClip];
    
    // 4.画图
    [self drawAtPoint:CGPointZero];
    
    // 5.从图形上下文获取新的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;

}

+ (instancetype)xy_circleImageWithImageName:(NSString *)imageName {

    return [[self imageNamed:imageName] xy_circleImage];
}


/**
 *  通过视频的URL，获得视频缩略图
 *
 *  @param vidoURL 视频URL
 *
 *  @return首帧缩略图
 */
- (UIImage *)xy_imageWithMediaURL:(NSURL *)vidoURL {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    // 初始化媒体文件
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:vidoURL options:opts];
    // 根据asset构造一张图
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    // 设定缩略图的方向
    // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
    generator.appliesPreferredTrackTransform = YES;
    // 设置图片的最大size(分辨率)
    generator.maximumSize = CGSizeMake(600, 450);
    // 初始化error
    NSError *error = nil;
    // 根据时间，获得第N帧的图片
    CMTime time = CMTimeMake(0, 10000); // 获取0帧处的视频截图
    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
    CGImageRef img = [generator copyCGImageAtTime:time actualTime:NULL error:&error];
    // 构造图片
    UIImage *videoScreen;
    if ([self isRetina]){
        videoScreen = [[UIImage alloc] initWithCGImage:img scale:2.0 orientation:UIImageOrientationUp];
    } else {
        videoScreen = [[UIImage alloc] initWithCGImage:img];
    }
    
    CGImageRelease(img);
    
    return videoScreen;
}

/**
 *  通过音乐地址，读取音乐数据，获得图片
 *
 *  @param url 音乐地址
 *
 *  @return音乐图片
 */
- (UIImage *)musicImageWithMusicURL:(NSURL *)url {
    NSData *data = nil;
    // 初始化媒体文件
    AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:url options:nil];
    // 读取文件中的数据
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            //artwork这个key对应的value里面存的就是封面缩略图，其它key可以取出其它摘要信息，例如title - 标题
            if ([metadataItem.commonKey isEqualToString:@"artwork"]) {
                data = [(NSDictionary*)metadataItem.value objectForKey:@"data"];
                break;
            }
        }
    }
    if (!data) {
        // 如果音乐没有图片，就返回默认图片
        return [UIImage imageNamed:@"default"];
    }
    return [UIImage imageWithData:data];
}



//返回渐变的image
+ (UIImage*)xy_gradientImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType inSize:(CGSize)size {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
            //上下渐变
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case 1:
            //左右渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case 2:
            //对角两侧渐变
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case 3:
            //对角两侧渐变
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case 4:
            //线性渐变
            start = CGPointMake(size.width/2, size.height/2);
            end = CGPointMake(size.width/2, size.height/2);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    if (gradientType == 4) {
        CGContextDrawRadialGradient(context, gradient, start, 10, end, size.width/3, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - private
- (BOOL)isRetina
{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
            ([UIScreen mainScreen].scale > 1.0));
}



@end
