//
//  ViewController.m
//  PictureChoice
//
//  Created by Yan on 16/5/1.
//  Copyright © 2016年 baidu. All rights reserved.
//

#import "YHPPictureChoiceController.h"
#import "YHPPictrueChoicesFlowLayout.h"
#import "YHPPictureChoiceCell.h"
#import "UIImage+Extension.h"

#import <MobileCoreServices/MobileCoreServices.h>

/** 决定选择多少张图片 */
#define kArrayPictureMaxCount 4
/** 遵守代理协议 */
@interface YHPPictureChoiceController ()<YHPPictureChoiceCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 自定义流布局 */
@property (nonatomic, strong) YHPPictrueChoicesFlowLayout *layout;
/** picture数组 */
@property (nonatomic, strong) NSMutableArray *arrayPicture;
/** 已选照片索引 */
@property (nonatomic) NSInteger  selectedIndex;


@end

@implementation YHPPictureChoiceController
/** 注册cell重用标识 */
static NSString * YHPPICTURECHOICECELL = @"YHPPictureChoiceCell";
/** picture数组 */
-(NSMutableArray *)arrayPicture {
    if (!_arrayPicture) {
        _arrayPicture = [[NSMutableArray alloc]init];
//        [_arrayPicture addObject:[UIImage imageNamed:@"compose_pic_add"]];
    }
    return _arrayPicture;
}
/** 懒加载layout */
-(YHPPictrueChoicesFlowLayout *)layout {
    if(_layout == nil) {
        _layout = [[YHPPictrueChoicesFlowLayout alloc]init];
    }
    return _layout;
}
/** 重写init方法 */
- (instancetype)init
{
    self = [super initWithCollectionViewLayout:self.layout];
    if (self) {
        
    }
    return self;
}
/** viewDidLoad */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    /** 注册cell */
    [self.collectionView registerClass:[YHPPictureChoiceCell class] forCellWithReuseIdentifier:YHPPICTURECHOICECELL];
}
#pragma mark - 数据源方法
/** 组数 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
/** 每组多少个Item */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    /** 决定选择多少张图片 */
    if (self.arrayPicture.count >= kArrayPictureMaxCount) {
        return kArrayPictureMaxCount;
    }
    return self.arrayPicture.count + (self.arrayPicture.count == kArrayPictureMaxCount ? 0 : 1);
}
/** 返回某组某个cell */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YHPPictureChoiceCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:YHPPICTURECHOICECELL forIndexPath:indexPath];
    cell.selected = NO;
    /** 设置代理 */
    cell.delegate = self;
    /** 根据indexpath.item来判断 */
    if (indexPath.item == 0) {
        /** cell.addBtn设置图片为固定加号图片 removeBtn隐藏 */
        [cell.addBtn setImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
        cell.removeBtn.hidden = YES;
        [cell.addBtn setBackgroundColor:[UIColor redColor]];
//        cell.addBtn.userInteractionEnabled = YES;
    } else {
        if (self.arrayPicture.count > 0) {
            /** 如果不让removeBtn显示 由于cell 复用问题 第三个以后就会没有removeBtn */
            cell.removeBtn.hidden = NO;
//            cell.addBtn.userInteractionEnabled = NO;
            [cell.addBtn setImage:self.arrayPicture[indexPath.item - 1] forState:UIControlStateNormal];
        }
    }
    /** 设置addBtn用户交互 根据removeBtn是否隐藏 */
    cell.addBtn.userInteractionEnabled = cell.removeBtn.hidden;
    return cell;
}
/** 设置组间距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    /** 上 左 下 右 */
    return  UIEdgeInsetsMake(10, 10, 0, 10);
}
/** 隐藏状态栏 */
-(BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark 实现代理方法
/** 添加图片 */
- (void)addPicture:(YHPPictureChoiceCell *)cell {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"不允许打开相册");
        return;
    }
    /** 记录当前选中的cell */
    self.selectedIndex = (NSInteger)[self.collectionView indexPathForCell:cell];
    /** 创建图片选择控制器 */
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    /** 设置代理为自己 */
    picker.delegate = self;
    /** 允许编辑 */
    picker.allowsEditing = YES;
    /** modal出图片选择控制器 */
    [self presentViewController:picker animated:YES completion:nil];
}
/** 移除图片 */
- (void)removePicture:(YHPPictureChoiceCell *)cell {
//    NSLog(@"remove");
    // 1. 获取照片索引
    NSIndexPath * indexpath = [self.collectionView indexPathForCell:cell];
    // 2. 判断索引是否超出上限
    if (indexpath.item > self.arrayPicture.count + 1) {
        return;
    } else if (self.arrayPicture.count > 0) {
        /** 移除选中的cell */
        [self.arrayPicture removeObjectAtIndex:(indexpath.item - 1)];
    }
    /** 刷新数据 */
    [self.collectionView reloadData];
}

#pragma mark - UIImagePickerControllerDelegate
/** 选择完毕获取到图片的代理方法 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    /** 将图片存入数组 */
    UIImage * scaleimage = info[UIImagePickerControllerEditedImage];
    scaleimage = [scaleimage scaleImageWithWidth:600];
    /** 如果当前索引>数组总数 不添加 */
    if (self.selectedIndex  >= self.arrayPicture.count) {
        [self.arrayPicture addObject:scaleimage];
    } else {
    /** 否则添加 */
        self.arrayPicture[(NSInteger)_selectedIndex] = scaleimage;
    }
    /** 刷新数据 */
    [self.collectionView reloadData];
    /** dismiss控制器 */
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end


