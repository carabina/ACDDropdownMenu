//
//  ACDDropdownMenu.m
//  ACDDropdownMenu
//
//  Created by nolol on 16/6/23.
//  Copyright © 2016年 nolol. All rights reserved.
//

#import "ACDDropdownMenu.h"

@interface ACDDropdownMenu () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UINavigationController *navigationController;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) UIView *menuHeaderView;
@property (nonatomic, strong) UIView *menuBackgroundView;
@end

#pragma mark -
@implementation ACDDropdownMenu
#pragma mark - Init
- (instancetype)initWithTitle:(NSString *)title
         navigationController:(UINavigationController *)navigationController {
    self = [ACDDropdownMenu buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = navigationController.navigationBar.frame;
        self.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self setTitle:title forState:UIControlStateNormal];
        self.navigationController = navigationController;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    //对简单数据结构初始化
    _indicatorPadding = 8.0;
    _animationDuration = 0.25;
    _keepMenuCellSelection = NO;
    _menuCellHeight = 45.0;
    _menuCellSeparatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _menuCellTextAlignment = NSTextAlignmentCenter;
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.font = self.titleFont;
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(
                                 0.0, -CGRectGetWidth(self.imageView.frame),
                                 0.0, CGRectGetWidth(self.imageView.frame) +
                                          self.indicatorPadding)];

    [self setImage:self.indicatorImage forState:UIControlStateNormal];
    [self setImageEdgeInsets:UIEdgeInsetsMake(
                                 0.0, CGRectGetWidth(self.titleLabel.frame) +
                                          self.indicatorPadding,
                                 0.0, -CGRectGetWidth(self.titleLabel.frame))];

    CGRect menuHeaderViewFrame = self.menuHeaderView.frame;
    menuHeaderViewFrame.size.width =
        CGRectGetWidth(self.navigationController.navigationBar.frame);
    menuHeaderViewFrame.size.height = self.menuCellHeight;
    self.menuHeaderView.frame = menuHeaderViewFrame;

    CGRect menuBackgoundViewFrame = [[UIScreen mainScreen] bounds];
    menuBackgoundViewFrame.origin.y +=
        CGRectGetMaxY(self.navigationController.navigationBar.frame);
    menuBackgoundViewFrame.size.height -=
        CGRectGetMaxY(self.navigationController.navigationBar.frame);
    self.menuBackgroundView.frame = menuBackgoundViewFrame;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake([super sizeThatFits:size].width + self.indicatorPadding,
                      [super sizeThatFits:size].height);
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake([super intrinsicContentSize].width + self.indicatorPadding,
                      [super intrinsicContentSize].height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect menuHeaderViewFrame = self.menuHeaderView.frame;
    menuHeaderViewFrame.size.height =
        MAX(0.0, self.menuCellHeight - scrollView.contentOffset.y);
    self.menuHeaderView.frame = menuHeaderViewFrame;
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.menuCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.textLabel.font = self.menuCellTextFont;
    cell.textLabel.textColor = self.menuCellTextColor;
    cell.textLabel.textAlignment = self.menuCellTextAlignment;
    cell.backgroundColor = self.menuBackgroundColor;
    if (self.menuCellSelectionColor) {
        cell.selectedBackgroundView = [[UIView alloc] init];
        cell.selectedBackgroundView.backgroundColor =
            self.menuCellSelectionColor;
    }
    return cell;
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:self.menuCellSeparatorInsets];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:self.menuCellSeparatorInsets];
    }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.keepMenuCellSelection) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if ([self.delegate respondsToSelector:@selector(didSelectedTitleAtIndex:)]) {
        [self.delegate didSelectedTitleAtIndex:indexPath.row];
    }
    [self setTitle:self.titlesArray[indexPath.row]
          forState:UIControlStateNormal];
    [self dismiss];
}

#pragma mark - Public methods
- (void)show {
    [[UIApplication sharedApplication]
            .keyWindow addSubview:self.menuBackgroundView];
    CGRect menuTableViewFrame = self.menuTableView.frame;
    menuTableViewFrame.origin.y =
        -(MIN(self.titlesArray.count * self.menuCellHeight,
              CGRectGetHeight(self.menuBackgroundView.frame)));
    self.menuTableView.frame = menuTableViewFrame;
    self.selected = YES;
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:kNilOptions
                     animations:^{
                         CGRect menuTableViewFrame = self.menuTableView.frame;
                         menuTableViewFrame.origin.y = 0.0;
                         self.menuTableView.frame = menuTableViewFrame;
                         self.menuBackgroundView.alpha = 1.0;
                     }
                     completion:nil];
}

- (void)dismiss {
    self.selected = NO;
    [UIView animateWithDuration:self.animationDuration
        animations:^{
            CGRect menuTableViewFrame = self.menuTableView.frame;
            menuTableViewFrame.origin.y =
                -(MIN(self.titlesArray.count * self.menuCellHeight,
                      CGRectGetHeight(self.menuBackgroundView.frame)));
            self.menuTableView.frame = menuTableViewFrame;
            self.menuBackgroundView.alpha = 0.0;
        }
        completion:^(BOOL finished) {
            [self.menuBackgroundView removeFromSuperview];
        }];
}

#pragma mark - Event Response
- (void)touchUpInside {
    self.isSelected ? [self dismiss] : [self show];
}

#pragma mark - Access methods
- (NSArray *)titlesArray {
    if (!_titlesArray) {
        return nil;
    }
    return _titlesArray;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:17.0];
    }
    return _titleFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIImage *)indicatorImage {
    if (!_indicatorImage) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(10, 10), NO, 0);
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(0, 3)];
        [bezierPath addLineToPoint:CGPointMake(5, 10)];
        [bezierPath addLineToPoint:CGPointMake(10, 3)];
        bezierPath.lineWidth = 1;
        [self.indicatorColor set];
        [bezierPath stroke];
        _indicatorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return _indicatorImage;
    }
    return _indicatorImage;
}

- (UIFont *)menuCellTextFont {
    if (!_menuCellTextFont) {
        _menuCellTextFont = [UIFont systemFontOfSize:16.0];
    }
    return _menuCellTextFont;
}

- (UIColor *)menuCellTextColor {
    if (!_menuCellTextColor) {
        _menuCellTextColor = [UIColor blackColor];
    }
    return _menuCellTextColor;
}

- (UIColor *)menuBackgroundColor {
    if (!_menuBackgroundColor) {
        _menuBackgroundColor = [UIColor whiteColor];
    }
    return _menuBackgroundColor;
}

- (UIColor *)menuCellSelectionColor {
    if (!_menuCellSelectionColor) {
        return nil;
    }
    return _menuCellSelectionColor;
}

#pragma mark - Private properties
- (UITableView *)menuTableView {
    if (_menuTableView == nil) {
        _menuTableView =
            [[UITableView alloc] initWithFrame:self.menuBackgroundView.bounds
                                         style:UITableViewStylePlain];
        _menuTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                          UIViewAutoresizingFlexibleBottomMargin;
        _menuTableView.dataSource = self;
        _menuTableView.delegate = self;
        _menuTableView.backgroundColor = [UIColor clearColor];
        _menuTableView.tableFooterView = [[UIView alloc]
            initWithFrame:CGRectMake(0.0, 0.0, 0.0, CGFLOAT_MIN)];
        [_menuTableView registerClass:[UITableViewCell class]
               forCellReuseIdentifier:@"Cell"];
        [self.menuBackgroundView addSubview:_menuTableView];
    }
    return _menuTableView;
}

- (UIView *)menuHeaderView {
    if (_menuHeaderView == nil) {
        _menuHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _menuHeaderView.backgroundColor = self.menuBackgroundColor;
        [self.menuBackgroundView addSubview:_menuHeaderView];
    }
    return _menuHeaderView;
}

- (UIView *)menuBackgroundView {
    if (_menuBackgroundView == nil) {
        _menuBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuBackgroundView.autoresizingMask =
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _menuBackgroundView.clipsToBounds = YES;
        _menuBackgroundView.alpha = 0.0;
        _menuBackgroundView.backgroundColor =
            [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return _menuBackgroundView;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:self.animationDuration
        animations:^{
            if (self.indicatorImage) {
                if (selected) {
                    self.imageView.transform =
                        CGAffineTransformMakeRotation(M_PI);
                } else {
                    self.imageView.transform =
                        CGAffineTransformMakeRotation(0.0);
                }
            }
        }
        completion:^(BOOL finished) {
            self.userInteractionEnabled = YES;
        }];
}

- (void)setDelegate:(id<ACDDropdownMenuDelegate>)delegate {
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(didSelectedTitleAtIndex:)]) {
        [self addTarget:self
                      action:@selector(touchUpInside)
            forControlEvents:UIControlEventTouchUpInside];
    }
}

@end
