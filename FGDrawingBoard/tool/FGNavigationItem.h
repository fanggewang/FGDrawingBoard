//
//  FGNavigationItem.h
//  food
//
//  Created by  on 15/8/19.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^myBlock)();
typedef void (^anBloick) ();
@interface FGNavigationItem : UIView

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSString *)name title:(NSString *)title AndPushButtonblock:(anBloick)block;
@end
