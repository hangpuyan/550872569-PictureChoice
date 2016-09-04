//
//  YHPPictureChoiceCell.h
//  PictureChoice
//
//  Created by Yan on 16/5/1.
//  Copyright © 2016年 baidu. All rights reserved.
/*
 @class CZContactModel,CZEditViewController;
 
 @protocol  CZEditViewControllerDelegate <NSObject>
 
 @optional
 - (void)sengVc:(CZEditViewController *)editVc withModel:(CZContactModel *)model;
 
 
 
 @end
 @interface CZEditViewController : UIViewController
 
 @property(nonatomic,weak)id <CZEditViewControllerDelegate>delegate;
 
 @property(nonatomic,strong)CZContactModel *model;
 
 @end
 */

#import <UIKit/UIKit.h>
/** 代理 */
@class YHPPictureChoiceCell;
/** 代理协议 */
@protocol YHPPictureChoiceCellDelegate <NSObject>
/** 代理方法 */
- (void)addPicture:(YHPPictureChoiceCell *)cell;
- (void)removePicture:(YHPPictureChoiceCell *)cell;
@end

@interface YHPPictureChoiceCell : UICollectionViewCell
/** 添加图片按钮 */
@property (nonatomic, strong) UIButton *addBtn;
/** 删除图片按钮 */
@property (nonatomic, strong) UIButton *removeBtn;
/** 图片 */
@property (nonatomic, strong) UIImage *picture;
@property (nonatomic, strong) NSIndexPath * indexpath;
/** 代理属性 */
@property (nonatomic, assign) id <YHPPictureChoiceCellDelegate> delegate;
@end









