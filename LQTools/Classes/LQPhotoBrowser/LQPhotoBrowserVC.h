//
//  LQPhotoBrowserVC.h
//  测试我的pods
//
//  Created by 谢双艰 on 2018/1/8.
//  Copyright © 2018年 lowkey. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DeleteBlock)(NSMutableArray *photoSourceArr,NSUInteger currentIndex,UICollectionView *collectionView);
typedef void(^DownLoadBlock)(NSMutableArray *photoSourceArr,UIImage *image, NSError *error);


@interface LQPhotoBrowserVC : UIViewController

/**
 * 图片数组
 */
@property (nonatomic,strong)NSMutableArray *photoSourceArr;
/**
 * 图片的index
 */
@property (nonatomic,assign)NSInteger currentPhotoIndex;

/**
 * 是否需要下载
 */
@property (nonatomic,assign) BOOL downLoadNeeded;
/**
 *  是否需要删除
 */
@property (assign, nonatomic)   BOOL deleteNeeded;
/**
 *  下载回调
 */
@property (nonatomic, copy) DownLoadBlock    downLoadBlock;

/**
 *  删除回调
 */
@property (nonatomic, copy) DeleteBlock   deleteBlock;


















@end
