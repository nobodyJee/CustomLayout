//
//  CustomLayout.m
//  collectionView
//
//  Created by JiWuChao on 2017/6/29.
//  Copyright © 2017年 姬武超. All rights reserved.
//

#import "JWCCustomLayout.h"

static const NSInteger DefaultColumnCpunt = 3;

@interface JWCCustomLayout ()
//存放attribute的数组
@property (nonatomic, strong) NSMutableArray *attrsArray;
//存放每个区中各个列的最后一个高度
@property (nonatomic, strong) NSMutableArray *columnHeights;
//collectionView的Content的高度
@property (nonatomic, assign) CGFloat contentHeight;
//记录上个区最高的把一列的高度
@property (nonatomic, assign) CGFloat lastContentHeight;
//每个区的区头和上个区的区尾的距离
@property (nonatomic, assign) CGFloat spacingWithLastSection;


@end

@implementation JWCCustomLayout


// 1
- (void)prepareLayout {
    [super prepareLayout];
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    [self.attrsArray removeAllObjects];
    self.lastContentHeight = 0;
    self.spacingWithLastSection = 0;
    self.sectionInsets = UIEdgeInsetsZero;
    self.headerReferenceSize = CGSizeZero;
    self.footerReferenceSize = CGSizeZero;
    self.lineSpacing = 0;
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    // 一共有多少个区
    for (NSInteger i = 0; i < sectionCount; i ++) {

        NSIndexPath *indexPat = [NSIndexPath indexPathWithIndex:i];
        //每个区的初始化高度
        if ([_delegate respondsToSelector:@selector(collectionView:layout:columnNumberAtSection:)]) {
            self.columnCount = [_delegate collectionView:self.collectionView layout:self columnNumberAtSection:indexPat.section];
        }
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            self.sectionInsets = [_delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPat.section];
        }
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:spacingWithLastSectionForSectionAtIndex:)]) {
            self.spacingWithLastSection = [_delegate collectionView:self.collectionView layout:self spacingWithLastSectionForSectionAtIndex:indexPat.section];
        }
        
        
        NSInteger itemCountOfSection = [self.collectionView numberOfItemsInSection:i];
        
        //1 生成区头
        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *headerAttributs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        
        [self.attrsArray addObject:headerAttributs];
        [self.columnHeights removeAllObjects];
        
        self.lastContentHeight = self.contentHeight;
        
        //2 初始化区的 y 值
        for (NSInteger i = 0; i < self.columnCount; i ++) {
            [self.columnHeights addObject:@(self.contentHeight)];
        }
        
        //3 每个区中有多少 item
        for (NSInteger j = 0; j < itemCountOfSection; j ++) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attributes];
        }
        
        //4 初始化 footer
        UICollectionViewLayoutAttributes *footerAttributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexPath];
        
            [self.attrsArray addObject:footerAttributes];
 
    }
}


//3

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attrsArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(collectionView:layout:columnNumberAtSection:)]) {
        self.columnCount = [_delegate collectionView:self.collectionView layout:self columnNumberAtSection:indexPath.section];
    }
    
    if ([_delegate respondsToSelector:@selector(collectionView:layout:lineSpacingForSectionAtIndex:)]) {
        self.lineSpacing = [_delegate collectionView:self.collectionView layout:self lineSpacingForSectionAtIndex:indexPath.section];
    }
    
    if ([_delegate  respondsToSelector:@selector(collectionView:layout:interitemSpacingForSectionAtIndex:)]) {
        self.interitemSpacing = [_delegate collectionView:self.collectionView layout:self interitemSpacingForSectionAtIndex:indexPath.section];
    }
    
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat collectionViewWeight = self.collectionView.frame.size.width;
    CGFloat cellWeight = (collectionViewWeight - self.sectionInsets.left - self.sectionInsets.right - (self.columnCount - 1) * self.interitemSpacing) / self.columnCount;
    
    CGFloat cellHeight = [self.delegate collectionView:self.collectionView layout:self heightForRowAtIndexPath:indexPath itemWidth:cellWeight];
    
    NSInteger tempMinColumn = 0; //默认第 0 列最小
 
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue]; // 取出最小的那一列的高度
    for (NSInteger i = 0; i < self.columnCount; i ++) {
        CGFloat columnH = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnH) {
            minColumnHeight = columnH;
            tempMinColumn = i;
        } else {}
    }

    CGFloat cellX = self.sectionInsets.left + tempMinColumn * (cellWeight + self.interitemSpacing);
    
    CGFloat cellY = 0;
    
    cellY = minColumnHeight;
    //如果cell的y值不等于上个区的最高的高度 即不是此区的第一列 要加上此区的每个cell的上下间距
    if (cellY != self.lastContentHeight) {
        cellY += self.lineSpacing;
    } else {}
    
    if (self.contentHeight < minColumnHeight) {
        self.contentHeight = minColumnHeight;
    } else {}
    
    
    attributes.frame = CGRectMake(cellX, cellY, cellWeight, cellHeight);
    
    self.columnHeights[tempMinColumn] = @(CGRectGetMaxY(attributes.frame));
    // 取出最大的
    for (NSInteger i = 0; i < self.columnHeights.count; i++ ) {
        if (self.contentHeight < [self.columnHeights[i] doubleValue]) {
            self.contentHeight = [self.columnHeights[i] doubleValue];
        }
    }
    return attributes;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            self.headerReferenceSize = [_delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
        self.contentHeight += self.spacingWithLastSection;
        attributes.frame = CGRectMake(0,  self.contentHeight, self.headerReferenceSize.width, self.headerReferenceSize.height);
        ;
        self.contentHeight += self.headerReferenceSize.height;
        self.contentHeight += self.sectionInsets.top;
        
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter] ){
        if ([_delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            self.footerReferenceSize = [_delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
        
        self.contentHeight += self.sectionInsets.bottom;
        attributes.frame = CGRectMake(0, self.contentHeight, self.footerReferenceSize.width, self.footerReferenceSize.height);
 
        self.contentHeight += self.footerReferenceSize.height;
    }
 
    return attributes;
}



- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

#pragma mark -  getter

- (NSInteger)columnCount {
    if (_columnCount) {
        return _columnCount;
    }  else {}
    return DefaultColumnCpunt;
}


- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [[NSMutableArray alloc] init];
    }  else {}
    return _attrsArray;
}


-(NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray arrayWithCapacity:DefaultColumnCpunt];
        
    }  else {}
    return _columnHeights;
}

 


@end
