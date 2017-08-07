//
//  ViewController.m
//  CollectionViewLayout
//
//  Created by JiWuChao on 2017/8/7.
//  Copyright © 2017年 JiWuChao. All rights reserved.
//

#import "ViewController.h"

#import "JWCCustomLayout.h"

#import "headView.h"

#import "TestCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,JWCCustomLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        JWCCustomLayout *layout = [[JWCCustomLayout alloc] init];
        layout.delegate = self;
        
        _collectionView = [[UICollectionView alloc ]initWithFrame:self.view.bounds collectionViewLayout:layout] ;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[TestCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class])];
        
        [_collectionView registerClass:[headView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[headView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TestCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.lbl.text = [NSString stringWithFormat:@"第%ld区,第%ld 个",indexPath.section,indexPath.item];
    cell.lbl.textColor = [UIColor blackColor];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    return cell ;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    headView *head = nil;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        head.backgroundColor = [UIColor redColor];
        head.lbl.text = @"区头";
        return head;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        head.backgroundColor = [UIColor blueColor];
        head.lbl.text = @"区尾";
        return head;
    }
    return nil;
}


#pragma mark - PLUCustomLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout heightForRowAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    return (arc4random() % 2 + 1) * itemWidth;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout columnNumberAtSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1){
        return 4;
    } else {
        return 2;
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout lineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 10;
    }
    return 10;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout *)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(JWCCustomLayout*)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    if (section != 0) {
        return 10;
    }
    return 5;
}

@end
