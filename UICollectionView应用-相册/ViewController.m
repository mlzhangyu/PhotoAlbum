//
//  ViewController.m
//  UICollectionView应用-相册
//
//  Created by 大禹治水 on 2018/4/11.
//  Copyright © 2018年 大禹治水. All rights reserved.
//

#import "ViewController.h"
#import "ZYPhotoCollectionViewCell.h"
#import "ZYPhotoCollectionViewFlowLayout.h"

static NSString * const ID = @"cell";

@interface ViewController () <UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSMutableArray *arr = @[@"zhangsan", @"lisi"];
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:@[@"zhangsan", @"lisi"]];
    arr[1] = @"wangwu";
    NSLog(@"%@", arr[1]);
    
    ZYPhotoCollectionViewFlowLayout *flow = ({
        ZYPhotoCollectionViewFlowLayout *flow = [[ZYPhotoCollectionViewFlowLayout alloc] init];
        flow.itemSize = CGSizeMake(160, 160);
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.minimumLineSpacing = 50;
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 160) * 0.5;
        flow.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        flow;
    });
    
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) collectionViewLayout:flow];
        collectionView.center = self.view.center;
        collectionView.backgroundColor = [UIColor orangeColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        [self.view addSubview:collectionView];
        collectionView;
    });
    
    //[collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZYPhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZYPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", indexPath.item + 1]];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
