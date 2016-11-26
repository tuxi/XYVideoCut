//
//  XYMyMovieViewController.m
//  XYVideoCut
//
//  Created by mofeini on 16/11/14.
//  Copyright © 2016年 com.test.demo. All rights reserved.
//

#import "XYMyMovieViewController.h"
#import "XYPlanItem.h"
#import "XYCollectionViewCell.h"
#import "UICollectionView+RollView.h"

@interface XYMyMovieViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *plans;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation XYMyMovieViewController
static NSString * const reuseIdentifier = @"Cell";

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        CGFloat itemW = [UIScreen mainScreen].bounds.size.width / 2 - 5;
        CGFloat itemW = [UIScreen mainScreen].bounds.size.width;
        CGFloat itemH = 230;
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        flowLayout.minimumLineSpacing = 5;
        
        _flowLayout = flowLayout;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionView *collectionView = [UICollectionView xy_collectionViewLayout:self.flowLayout originalDataBlock:^NSArray *{
            return self.plans;
        } callBlckNewDataBlock:^(NSArray *newData) {
            [self.plans removeAllObjects];
            [self.plans addObjectsFromArray:newData];
        }];
        
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (NSMutableArray *)plans {
    if (_plans == nil) {
        _plans = [NSMutableArray array];
    }
    return _plans;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"XYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = kColorWithRGB(230, 230, 230);
    self.collectionView.rollingColor = [UIColor blueColor];
    self.collectionView.autoRollCellSpeed = 8;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self setupPlans];
    self.navigationItem.title = @"我的影片";
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [self makeCollectionViewConstr];
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemH = 230;
    self.flowLayout.itemSize = CGSizeMake(itemW, itemH);
}


- (void)makeCollectionViewConstr {
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:0 views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:0 views:views]];
    [self.view layoutIfNeeded];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    // 判断是不是嵌套数组
    if ([collectionView xy_nestedArrayCheck:self.plans]) {
        return self.plans.count;
    }
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // 判断是不是嵌套数组
    if ([collectionView xy_nestedArrayCheck:self.plans]) {
        NSArray *array = self.plans[section];
        return array.count;
    }
    return self.plans.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    XYPlanItem *item = nil;
    
    // 检测是不是嵌套数组
    if ([collectionView xy_nestedArrayCheck:self.plans]) {
        item = self.plans[indexPath.section][indexPath.item];
    } else {
        item = self.plans[indexPath.row];
    }
    
    cell.planItem = item;
    cell.backgroundColor = kRandomColor;
    
    return cell;
}


#pragma mark - 非嵌套数组的数据
- (void)setupPlans {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                       pathForResource:@"plans.plist"
                                                       ofType:nil]];
    
    for (id obj in array) {
        XYPlanItem *item = [XYPlanItem planItemWithDict:obj];
        [self.plans addObject:item];
    }
    
}

@end
