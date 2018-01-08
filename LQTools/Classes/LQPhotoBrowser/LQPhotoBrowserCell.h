//
//  LQPhotoBrowserCell.h
//  测试我的pods
//
//  Created by 谢双艰 on 2018/1/8.
//  Copyright © 2018年 lowkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQPhotoBrowserCell : UICollectionViewCell
@property (nonatomic, copy)NSIndexPath *currentIndexPath;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, retain)id model;
@property (nonatomic, copy) void (^singleTapGestureBlock)(void);
@property (nonatomic, copy) void (^longPressGestureBlock)(LQPhotoBrowserCell *cell);
@end
