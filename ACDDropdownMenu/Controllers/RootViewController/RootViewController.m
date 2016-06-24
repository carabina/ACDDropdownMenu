//
//  RootViewController.m
//  ACDDropdownMenu
//
//  Created by onedotM on 16/6/23.
//  Copyright © 2016年 nolol. All rights reserved.
//

#import "ACDDropdownMenu.h"
#import "RootViewController.h"

@interface RootViewController () <ACDDropdownMenuDelegate>
@end

@implementation RootViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =
        [UIColor colorWithRed:0.162 green:0.928 blue:1.000 alpha:1.000];
    ACDDropdownMenu *menu =
        [[ACDDropdownMenu alloc] initWithTitle:@"下拉菜单"
                          navigationController:self.navigationController];
    menu.titlesArray =
        @[ @"1号控制器", @"2号控制器", @"3号控制器", @"4号控制器" ];
    menu.indicatorImage = [UIImage imageNamed:@"Arrow"];
    menu.delegate = self;
    self.navigationItem.titleView = menu;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ACDDropdownMenuDelegate
- (void)didSelectedTitleAtIndex:(NSUInteger)index {
}
@end
