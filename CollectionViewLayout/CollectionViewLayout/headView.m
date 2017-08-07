//
//  headView.m
//  collectionView
//
//  Created by JiWuChao on 2017/6/30.
//  Copyright © 2017年 姬武超. All rights reserved.
//

#import "headView.h"

@implementation headView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (UILabel *)lbl {
    if (!_lbl) {
        _lbl = [[UILabel alloc] initWithFrame:self.bounds];
        _lbl.font = [UIFont systemFontOfSize:15];
        _lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbl];
    }
    return _lbl;
}

@end
