//
//  ViewController.h
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/5/10.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

+ (UIImage *)transToMosaicImage:(UIImage*)orginImage blockLevel:(NSUInteger)level;

@end

