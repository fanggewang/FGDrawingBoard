//
//  FGInkLine.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/12.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FGInkLine : NSObject

@property (nonatomic,assign) BOOL isEraseMode;
@property (nonatomic, strong) NSMutableArray *lineArr;
@property (nonatomic, assign) NSInteger colorIndex;
@property (nonatomic, assign) CGFloat lineWidth;

@end
