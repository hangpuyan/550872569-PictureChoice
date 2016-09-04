//
//  YHPPictrueChoicesFlowLayout.m
//  PictureChoice
//
//  Created by Yan on 16/5/1.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "YHPPictrueChoicesFlowLayout.h"

@implementation YHPPictrueChoicesFlowLayout

/** 在 collectionView 第一次布局的时候调用，此时 collectionView 的 frame 已经设置完毕 */
- (void)prepareLayout {
    // 一定 super
    [super prepareLayout];
    /** item大小 */
    CGFloat H = (kSCREEN_WIDTH - 2*10 - 3*10) / 4;
    CGFloat W = H;
    self.itemSize = CGSizeMake(W, H);
    /** 列间距 */
    self.minimumInteritemSpacing = 10;
    /** 行间距 */
    self.minimumLineSpacing = 10;
    /** 滚动方向 */
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    /** 弹簧效果 */
    self.collectionView.bounces = NO;
    /** 分页 */
    self.collectionView.pagingEnabled = YES;
    /** 水平滚动指示条 */
    self.collectionView.showsHorizontalScrollIndicator = NO;
    /** 垂直滚动指示条 */
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end
