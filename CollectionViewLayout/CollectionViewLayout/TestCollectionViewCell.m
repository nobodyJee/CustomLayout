//
//  TestCollectionViewCell.m
//  collectionView
//
//  Created by JiWuChao on 2017/6/30.
//  Copyright © 2017年 姬武超. All rights reserved.
//

#import "TestCollectionViewCell.h"

@interface TestCollectionViewCell ()

@end

@implementation TestCollectionViewCell

- (UILabel *)lbl {
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:self.bounds];
        _lbl.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbl];
    }
    return _lbl;
}

@end
