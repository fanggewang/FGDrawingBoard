//
//  FGNavigationItem.m
//  food
//
//  Created by  on 15/8/19.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "FGNavigationItem.h"
#import "Alldefined.h"
@interface FGNavigationItem()
@property (nonatomic,copy)anBloick anBlock;
@end
@implementation FGNavigationItem

- (instancetype)initWithFrame:(CGRect)frame buttonName:(NSString *)name title:(NSString *)title AndPushButtonblock:(anBloick)block{
    if (self == [super initWithFrame:CGRectMake(0, 0, screenRect.size.width, 44)]) {
        self.userInteractionEnabled = YES;
        //self.image = [UIImage imageNamed:@"nearInputbox@2x.png"];
        self.backgroundColor = UIColorFromRGB(0x8d633d);
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [pushButton setImage:[[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        pushButton.frame = CGRectMake(0, 0, 44, 44);
        [self addSubview:pushButton];
        [pushButton addTarget:self action:@selector(pushButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, screenRect.size.width-88, 44)];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
        _anBlock = block;
        
    }
    return self;
}

- (void)pushButtonClick:(UIButton *)button{
    _anBlock();
}



@end
