//
//  ACDDropdownMenu.h
//  ACDDropdownMenu
//
//  Created by nolol on 16/6/23.
//  Copyright © 2016年 nolol. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - ACDDropdownMenu Delegate
@protocol ACDDropdownMenuDelegate <NSObject>
- (void)didSelectedTitleAtIndex:(NSUInteger)index;
@end

#pragma mark -
@interface ACDDropdownMenu : UIButton
@property (nonatomic, weak) id<ACDDropdownMenuDelegate> delegate;
// 定制下拉菜单按钮
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIImage *indicatorImage;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, assign) CGFloat indicatorPadding;
@property (nonatomic, assign) NSTimeInterval animationDuration;
// 定制下拉菜单
@property (nonatomic, assign) BOOL keepMenuCellSelection;
@property (nonatomic, assign) CGFloat menuCellHeight;
@property (nonatomic, assign) UIEdgeInsets menuCellSeparatorInsets;
@property (nonatomic, assign) NSTextAlignment menuCellTextAlignment;
@property (nonatomic, strong) UIFont *menuCellTextFont;
@property (nonatomic, strong) UIColor *menuCellTextColor;
@property (nonatomic, strong) UIColor *menuBackgroundColor;
@property (nonatomic, strong) UIColor *menuCellSelectionColor;
@property (nonatomic, assign) CGFloat menuBackgroundAlpha;

- (instancetype)initWithTitle:(NSString *)title
         navigationController:(UINavigationController *)navigationController;
- (void)show;
- (void)dismiss;

@end
