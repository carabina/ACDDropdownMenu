//
//  RootViewController.m
//  ACDDropdownMenu
//
//  Created by nolol on 16/6/23.
//  Copyright © 2016年 nolol. All rights reserved.
//

#import "ACDDropdownMenu.h"
#import "RootViewController.h"

@interface RootViewController () <ACDDropdownMenuDelegate>
@property (nonatomic, strong) UILabel *label;
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
    menu.titlesArray = @[ @"1号动作", @"2号动作", @"3号动作", @"4号动作" ];
    menu.indicatorImage = [UIImage imageNamed:@"Arrow"];
    menu.delegate = self;
    self.navigationItem.titleView = menu;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.label = [[UILabel alloc] init];
    self.label.text = @"动作指示器";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.frame = CGRectMake(0, 0, 100, 40);
    self.label.center = self.view.center;
    [self.view addSubview:self.label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ACDDropdownMenuDelegate
- (void)didSelectedTitleAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            self.label.text = @"1号动作";
            break;
        case 1:
            self.label.text = @"2号动作";
            break;
        case 2:
            self.label.text = @"3号动作";
            break;
        case 3:
            self.label.text = @"4号动作";
            break;
        default:
            break;
    }
}
@end
