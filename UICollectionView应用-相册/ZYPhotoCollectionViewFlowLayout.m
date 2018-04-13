//
//  ZYPhotoCollectionViewFlowLayout.m
//  UICollectionView应用-相册
//
//  Created by 大禹治水 on 2018/4/12.
//  Copyright © 2018年 大禹治水. All rights reserved.
//

#import "ZYPhotoCollectionViewFlowLayout.h"

@implementation ZYPhotoCollectionViewFlowLayout

/**
 *  rect: The rectangle (specified in the collection view’s coordinate system) containing the target views.
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //NSLog(@"----------%@", [[super layoutAttributesForElementsInRect:self.collectionView.bounds] class]);
    NSArray *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    NSArray *copyAttrs = [[NSArray alloc] initWithArray:attrs copyItems:YES];
    //NSLog(@"%@", attrs);
    //NSLog(@"%@", NSStringFromCGPoint(self.collectionView.contentOffset));
    
    for (UICollectionViewLayoutAttributes *attr in copyAttrs) {
        CGFloat delta = fabs((attr.center.x - self.collectionView.contentOffset.x) - self.collectionView.bounds.size.width * 0.5);
        CGFloat scale = 1 - delta / (self.collectionView.bounds.size.width * 0.5) * 0.25;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return copyAttrs;
}

// 什么时候调用:用户手指一松开就会调用
// 作用:确定最终偏移量
// 定位:距离中心点越近,这个cell最终展示到中心点
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint p = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    CGRect rect = CGRectMake(p.x, 0, self.collectionView.frame.size.width, self.collectionView.bounds.size.height);
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat min = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat differ = attr.center.x - p.x - self.collectionView.bounds.size.width * 0.5;
        if (fabs(differ) < fabs(min))
            min = differ;
    }
    
    p.x += min;
    p.x = p.x < 0 ? 0 : p.x;
    NSLog(@"%@", NSStringFromCGPoint(self.collectionView.contentOffset));
    NSLog(@"%@", NSStringFromCGPoint(p));
    return p;
}

/** 当滚动的时候是否允许刷新布局 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
