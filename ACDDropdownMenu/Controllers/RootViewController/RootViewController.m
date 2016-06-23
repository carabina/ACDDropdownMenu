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
    ACDDropdownMenu *menu =
        [[ACDDropdownMenu alloc] initWithTitle:@"下拉菜单"
                          navigationController:self.navigationController];
    menu.titlesArray = @[ @"1", @"2", @"3", @"4" ];
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
