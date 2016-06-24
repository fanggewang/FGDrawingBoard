//
//  FGAboutViewController.m
//  FGDrawingBoard
//
//  Created by 王放歌 on 16/6/24.
//  Copyright © 2016年 WangFangGe. All rights reserved.
//

#import "FGAboutViewController.h"
#import "FGNavigationItem.h"
@interface FGAboutViewController ()

@end

@implementation FGAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    FGNavigationItem *navigation = [[FGNavigationItem alloc]initWithFrame:self.view.frame buttonName:@"ic_back_dark" title:@"关于" AndPushButtonblock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
        //[self popoverPresentationController];
    }];
    
    [self.view addSubview:navigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
