//
//  UIImage+Extension.m
//  PictureChoice
//
//  Created by Yan on 16/5/2.
//  Copyright © 2016年 baidu. All rights reserved.
/*
 let height = size.height * width / size.width
 let rect = CGRect(x: 0, y: 0, width: width, height: height)
 
 // 3. 使用核心绘图绘制新的图像
 // 1> 开启上下文
 UIGraphicsBeginImageContext(rect.size)
 
 // 2> 绘图 - 在指定区域拉伸绘制
 self.drawInRect(rect)
 
 // 3> 取结果
 let result = UIGraphicsGetImageFromCurrentImageContext()
 
 // 4> 关闭上下文
 UIGraphicsEndImageContext()
 
 // 5> 返回结果
 return result
 */

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (instancetype)scaleImageWithWidth:(CGFloat)width {
    if (width > self.size.width) {
        return self;
    }
    CGFloat height = self.size.height * width / self.size.width;
    CGRect rect = CGRectMake(0, 0, width, height);
    /** 开启上下文 */
    UIGraphicsBeginImageContext(rect.size);
    /** 绘制 */
    [self drawInRect:rect];
    /** 取结果 */
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    /** 关闭上下文 */
    UIGraphicsEndPDFContext();
    return image;
}
@end
