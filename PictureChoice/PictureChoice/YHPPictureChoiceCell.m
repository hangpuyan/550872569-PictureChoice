//
//  YHPPictureChoiceCell.m
//  PictureChoice
//
//  Created by Yan on 16/5/1.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "YHPPictureChoiceCell.h"


@interface YHPPictureChoiceCell ()

@end


@implementation YHPPictureChoiceCell

- (void)setPicture:(UIImage *)picture {
    _picture = picture;
}
#pragma mark - 懒加载属性
/** 添加图片按钮 */
-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [self addSubview:_addBtn];
        _addBtn.frame = self.bounds;
    }
    return _addBtn;
}
/** 删除图片按钮 */
-(UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = [[UIButton alloc]init];
        [self addSubview:_removeBtn];
        _removeBtn.frame = CGRectMake(self.bounds.size.width*0.75, 0, self.bounds.size.width * 0.25, self.bounds.size.width * 0.25);
        [_removeBtn setImage:[UIImage imageNamed:@"compose_photo_close"] forState:UIControlStateNormal];
    }
    return _removeBtn;
}
/** collectionViewCell 的 frame 是根据之前的 layout 已经确定好的！*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /** 添加子控件 */
        [self setupUI];
    }
    return self;
}

/** 添加子控件 */
- (void)setupUI {
    /** 添加图片按钮 */
    [self.addBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    /** 删除图片按钮 */
      [self.removeBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}
/** 添加图片按钮 */
- (void)add {
    if ([self.delegate respondsToSelector:@selector(addPicture:)]) {
        [self.delegate addPicture:self];
    }
}
/** 删除图片按钮 */
- (void)remove {
    if ([self.delegate respondsToSelector:@selector(removePicture:)]) {
        [self.delegate removePicture:self];
    }
}
















@end
