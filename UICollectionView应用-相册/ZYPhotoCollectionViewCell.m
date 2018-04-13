//
//  ZYPhotoCollectionViewCell.m
//  UICollectionView应用-相册
//
//  Created by 大禹治水 on 2018/4/12.
//  Copyright © 2018年 大禹治水. All rights reserved.
//

#import "ZYPhotoCollectionViewCell.h"

@interface ZYPhotoCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation ZYPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.photoView.image = image;
}

@end
