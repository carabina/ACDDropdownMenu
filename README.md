# ACDDropdownMenu

A simple dropdown menu in navigation.  
一个简单的下拉菜单，用于导航栏中。

You can customize almost everything you want custom attributes.  
你几乎可以定制一切你希望定制的属性。

```
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
```

Like this~  
就像这样~

![image](https://github.com/nolol/ACDDropdownMenu/blob/master/demo.gif)  
