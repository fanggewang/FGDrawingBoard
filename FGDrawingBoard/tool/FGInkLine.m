//
//  FGInkLine.m
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/12.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import "FGInkLine.h"

@implementation FGInkLine
- (instancetype)init
{
    self = [super init];
    if (self) {
        _lineArr = [NSMutableArray array];
    }
    return self;
}
@end
