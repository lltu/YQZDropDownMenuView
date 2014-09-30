//
//  YQZDropDownMenuView.m
//  YQZ
//
//  Created by lvlin on 14/9/28.
//  Copyright (c) 2014年 All rights reserved.
//

#import "YQZDropDownMenuView.h"

#define DefaultButtonBarHeight      30               //按钮行高度
#define DefaultTableViewHeight      140              //默认TableView高度
#define FootButtonHeight            1                //footButton 高度

@interface YQZDropDownMenuView ()
//初始化frame
@property (nonatomic, assign) CGRect originFrame;
//菜单标题高度
@property (nonatomic, assign) NSInteger menuBarHeight;
//列总数
@property (nonatomic, assign) NSInteger columnCount;
//是否已显示出menu
@property (nonatomic, assign) BOOL isShowMenu;
//点击的按钮索引
@property (nonatomic, assign) NSInteger clickButtonIndex;

//菜单View  菜单View含menuTableView\footButton
@property (nonatomic, strong) UIView *menuView;
//菜单TableView
@property (nonatomic, strong) UITableView *menuTableView;
//菜单最底部的按钮
@property (nonatomic, strong) UIButton *footButton;
//按钮数组
@property (nonatomic, strong) NSMutableArray *menuButtonArray;
//tableView数组
@property (nonatomic, strong) NSArray *datasourceArray;
//背景按钮
@property (nonatomic, strong) UIButton *shadowButton;
//存储选中的行
@property (nonatomic, strong) NSMutableArray *selectRowArray;
@end

@implementation YQZDropDownMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.originFrame = frame;
        self.menuBarHeight = frame.size.height;
        self.clipsToBounds = NO;
        self.menuDataArray = [NSArray array];
        self.menuButtonArray = [NSMutableArray array];
        self.datasourceArray = [NSArray array];
        self.selectRowArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadData
{
    //加载默认数据
    [self loadDefaultSet];
    //加载视图
    [self loadView];
}

- (void)reloadData
{
    [self loadView];
}

#pragma mark - Private function -

//加载缺省数据
- (void)loadDefaultSet
{
    switch (self.menuStyle) {
        case MenuStyleGrayCustom:
            if (self.backGroundColor == nil) {
                self.backGroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
            }
            if (self.textColor == nil) {
                self.textColor       = [UIColor colorWithRed:(119/255.0) green:(119/255.0) blue:(119/255.0) alpha:1];
            }
            if (self.selectTextColor == nil) {
                self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            }
            if (self.lineColor == nil) {
                self.lineColor       = [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1];
            }
            if (self.cellSelectBackColor == nil) {
                self.cellSelectBackColor = [UIColor colorWithRed:(217/255.0) green:(217/255.0) blue:(217/255.0) alpha:1];
            }
            break;
        case MenuStyleGray:
        {
            self.backGroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0) blue:(248/255.0) alpha:1];
            self.textColor       = [UIColor colorWithRed:(119/255.0) green:(119/255.0) blue:(119/255.0) alpha:1];
            self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            self.lineColor       = [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1];
            self.cellSelectBackColor = [UIColor colorWithRed:(217/255.0) green:(217/255.0) blue:(217/255.0) alpha:1];
        }
            break;
            
        case MenuStyleRed:
        {
            self.backGroundColor = [UIColor colorWithRed:(255/255.0) green:(241/255.0) blue:(241/255.0) alpha:1];
            self.textColor       = [UIColor colorWithRed:(160/255.0) green:(50/255.0) blue:(70/255.0) alpha:1];
            self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            self.lineColor       = [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1];
            self.cellSelectBackColor = [UIColor colorWithRed:(220/255.0) green:(206/255.0) blue:(206/255.0) alpha:1];
        }
            break;
            
        case MenuStyleGreen:
        {
            self.backGroundColor = [UIColor colorWithRed:(241/255.0) green:(255/255.0) blue:(241/255.0) alpha:1];
            self.textColor       = [UIColor colorWithRed:(70/255.0) green:(160/255.0) blue:(50/255.0) alpha:1];
            self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            self.lineColor       = [UIColor colorWithRed:(218/255.0) green:(218/255.0) blue:(218/255.0) alpha:1];
            self.cellSelectBackColor = [UIColor colorWithRed:(210/255.0) green:(220/255.0) blue:(200/255.0) alpha:1];
        }
            break;
            
        case MenuStyleBlue:
        {
            self.backGroundColor = [UIColor colorWithRed:(241/255.0) green:(241/255.0) blue:(255/255.0) alpha:1];
            self.textColor       = [UIColor colorWithRed:(70/255.0) green:(100/255.0) blue:(160/255.0) alpha:1];
            self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            self.lineColor       = [UIColor colorWithRed:(120/255.0) green:(147/255.0) blue:(183/255.0) alpha:1];
            self.cellSelectBackColor = [UIColor colorWithRed:(172/255.0) green:(192/255.0) blue:(220/255.0) alpha:1];
        }
            break;
        case MenuStyleYellow:
        {
            self.backGroundColor = [UIColor colorWithRed:(255/255.0) green:(250/255.0) blue:(240/255.0) alpha:1];
            self.textColor       = [UIColor colorWithRed:(211/255.0) green:(160/255.0) blue:(1/255.0) alpha:1];
            self.selectTextColor = [UIColor colorWithRed:(233/255.0) green:(97/255.0) blue:(75/255.0) alpha:1];
            self.lineColor       = [UIColor colorWithRed:(184/255.0) green:(147/255.0) blue:(49/255.0) alpha:1];
            self.cellSelectBackColor = [UIColor colorWithRed:(220/255.0) green:(218/255.0) blue:(200/255.0) alpha:1];
        }
            break;
        default:
            break;
    }
}

//加载视图
- (void)loadView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfCols)]) {
        self.columnCount = [self.delegate numberOfCols];
    }
    else {
        self.columnCount = [self.menuDataArray count];
    }
    for (NSInteger i=0; i<self.columnCount; i++) {
        self.selectRowArray[i] = [NSNumber numberWithInteger:0];
    }
    
    [self addShadowButton];
    [self addMenuView];
    [self addMenuBar];
}

//添加背景阴影按钮
- (void)addShadowButton
{
    self.shadowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shadowButton.frame = [UIScreen mainScreen].bounds;
    self.shadowButton.backgroundColor = [UIColor colorWithRed:0.23 green:0.23 blue:0.23 alpha:0.3];
    self.shadowButton.hidden = YES;
    [self.shadowButton addTarget:self action:@selector(shadowButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.shadowButton];
}

//添加菜单条
- (void)addMenuBar
{
    //高度未指定时使用默认值
    if (self.menuBarHeight == 0) {
        self.menuBarHeight = DefaultButtonBarHeight;
    }
    
    if ([self.menuDataArray count] == 0) {
        NSException *exception =[[NSException alloc] initWithName:@"Error Message" reason:@"MenuArray is empty " userInfo:nil];
        @throw exception;
        return;
    }
    //数组长度和给定值不符 抛出异常
    if ([self.menuDataArray count] < self.columnCount) {
        NSException *exception =[[NSException alloc]initWithName:@"Error Message" reason:@"MenuArray count is less than columnCount " userInfo:nil];
        @throw exception;
        return;
    }
    //计算列宽
    float buttonWidth = self.frame.size.width / self.columnCount;
    
    //按钮容器视图
    UIView *buttonBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.menuBarHeight)];
    buttonBarView.layer.shadowColor = [UIColor grayColor].CGColor;
    buttonBarView.layer.shadowOffset = CGSizeMake(0, 0.2);
    buttonBarView.layer.shadowOpacity = 0.5;
    buttonBarView.clipsToBounds = NO;
    [self addSubview:buttonBarView];
    
    //加载按钮
    for (NSInteger i=0; i<self.columnCount; i++) {
        //若列表数据为空则抛出异常
        NSArray *childMenuArray = (NSArray *)[self.menuDataArray objectAtIndex:i];
        if ([childMenuArray count] == 0) {
            NSException *exception =[[NSException alloc]initWithName:@"Error Message" reason:[NSString stringWithFormat:@"Array %d in MenuArray is nil", i] userInfo:nil];
            @throw exception;
            return;
        }
        else
        {
            //向按钮容器添加按钮
            NSString *menuString = [childMenuArray objectAtIndex:0];
            UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
            menuButton.frame = CGRectMake(buttonWidth * i, 0, buttonWidth, self.menuBarHeight);
            [menuButton setTitle:menuString forState:UIControlStateNormal];
            [menuButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
            [menuButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
            [menuButton setTitleColor:self.textColor forState:UIControlStateNormal];
            [menuButton setTitleColor:self.selectTextColor forState:UIControlStateSelected];
            [menuButton setBackgroundColor:self.backGroundColor];
            [buttonBarView addSubview:menuButton];
            [self.menuButtonArray addObject:menuButton];
        }
    }
}
//菜单按钮点击事件
- (void)showMenu:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger buttonIndex = [self.menuButtonArray indexOfObject:button];
    
    if (self.isShowMenu) {      //菜单已经显示
        [self showAnimationMenu:NO];
        [self setButtonSelectWithIndex:self.clickButtonIndex state:NO];
        
        if (self.clickButtonIndex != buttonIndex) {
            //更换了列需要重新加载数据 并设置选中状态
            self.clickButtonIndex = buttonIndex;
            self.datasourceArray = [self.menuDataArray objectAtIndex:buttonIndex];
            [self reSetMenuView];
            [self setTableRowSelect];
            
            //延迟执行
            [self setButtonSelectWithIndex:self.clickButtonIndex state:YES];
            [self showAnimationMenu:YES];
        }
        else
        {
            [self showAnimationMenu:NO];
            [self setButtonSelectWithIndex:buttonIndex state:NO];
        }
    }
    else
    {
        //菜单未显示
        self.datasourceArray = [self.menuDataArray objectAtIndex:buttonIndex];
        
        if (self.clickButtonIndex != buttonIndex) {
            [self setButtonSelectWithIndex:self.clickButtonIndex state:NO];
            self.clickButtonIndex = buttonIndex;
        }
        
        [self reSetMenuView];
        [self setTableRowSelect];
        
        [self setButtonSelectWithIndex:buttonIndex state:YES];
        [self showAnimationMenu:YES];
    }
}

//设置行选中状态
- (void)setTableRowSelect
{
    NSInteger row = [self.selectRowArray[self.clickButtonIndex] integerValue];
    NSIndexPath *inPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.menuTableView selectRowAtIndexPath:inPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

//背景按钮点击
- (void)shadowButtonClick:(id)sender
{
    [self showAnimationMenu:NO];
    [self setButtonSelectWithIndex:self.clickButtonIndex state:NO];
}

//设置按钮选中状态
- (void)setButtonSelectWithIndex:(NSInteger)index state:(BOOL)select
{
    UIButton *button = [self.menuButtonArray objectAtIndex:index];
    [button setSelected:select];
}

//动画显示或隐藏按钮
- (void)showAnimationMenu:(BOOL)flag
{
    switch (self.menuAnimationType) {
        case MenuAnimationTypeSlide:
            self.menuView.hidden = NO;
            [self showSlideMenu:flag];
            break;
            
        case MenuAnimationTypeFade:
            [self showFadeMenu:flag];
            break;
        default:
            break;
    }
    
    self.isShowMenu = flag;
    self.frame = flag ? [UIScreen mainScreen].bounds : self.originFrame;
}

//显示下拉菜单动画
- (void)showSlideMenu:(BOOL)flag
{
    NSInteger pointY = flag ? self.menuBarHeight : self.menuBarHeight - self.menuView.frame.size.height;
    CGRect frame = CGRectMake(0, pointY, self.frame.size.width, self.menuView.frame.size.height);
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.menuView.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         self.shadowButton.hidden = !flag;
                     }];
}

//显示渐变菜单动画
- (void)showFadeMenu:(BOOL)flag
{
    if (flag) {
        self.menuView.alpha = 0;
        self.menuView.hidden = NO;                          //设置可见
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.menuView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             self.menuView.hidden = NO;     //设置可见 这里重复是因为切换不同菜单时 可能显示不出来
                             self.shadowButton.hidden = !flag;
                         }];
    }
    else
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.menuView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                             self.menuView.hidden = YES;
                             self.shadowButton.hidden = !flag;
                         }];
    }
}
//添加菜单列表
- (void)addMenuView
{
    self.menuView = [[UIView alloc] init];
    self.menuView.backgroundColor = self.backgroundColor;
    self.menuView.hidden = YES;
    [self addSubview:self.menuView];
    
    self.menuTableView = [[UITableView alloc] init];
    self.menuTableView.backgroundColor = self.backGroundColor;
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.separatorColor = self.lineColor;
    self.menuTableView.allowsSelection = YES;
    [self.menuView addSubview:self.menuTableView];
    
    self.footButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.footButton.backgroundColor = [UIColor grayColor];
    [self.menuView addSubview:self.footButton];
}

//重置下拉菜单坐标
//此处为重置下拉菜单的最大高度 由宏定义DefaultTableViewHeight控制
- (void)reSetMenuView
{
    //高度取TableView heightForRowAtIndexPath第0行第0列高度
    NSInteger tableRowHeight = [self tableView:self.menuTableView heightForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger tableHeight = (tableRowHeight * [self.datasourceArray count] > DefaultTableViewHeight ? DefaultTableViewHeight : tableRowHeight * [self.datasourceArray count]);
    self.menuView.frame = CGRectMake(0, self.menuBarHeight, self.frame.size.width, tableHeight + FootButtonHeight);
    self.menuTableView.frame = CGRectMake(0, 0, self.frame.size.width, tableHeight);
    CGRect footButtonFrame = CGRectMake(0, self.menuTableView.frame.size.height, self.menuTableView.frame.size.width, FootButtonHeight);
    self.footButton.frame = footButtonFrame;
    
    //重新加载数据
    [self.menuTableView reloadData];
}

#pragma mark - UITableView Delegate -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 35;
    if (self.delegate && [self.delegate respondsToSelector:@selector(heightForRowAtIndexPath:)]) {
        height = [self.delegate heightForRowAtIndexPath:indexPath];
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.backgroundColor = self.backGroundColor;
        
        UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
        backView.backgroundColor = self.cellSelectBackColor;
        [cell setSelectedBackgroundView:backView];
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = self.textColor;
    }
    
    if (indexPath.row == [self.selectRowArray[self.clickButtonIndex] integerValue])
    {
        [cell setSelected:YES animated:NO];
        [cell setHighlighted:YES animated:NO];
    }
    
    NSString *rowString = [self.datasourceArray objectAtIndex:indexPath.row];
    cell.textLabel.text = rowString;
    cell.textLabel.textAlignment = (self.clickButtonIndex == 0 ? NSTextAlignmentLeft :(self.clickButtonIndex == (self.columnCount - 1) ? NSTextAlignmentRight : NSTextAlignmentCenter) ) ;   //左中右对齐
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //更新按钮文字
    NSString *selectRowString = [self.datasourceArray objectAtIndex:indexPath.row];
    UIButton *button = [self.menuButtonArray objectAtIndex:self.clickButtonIndex];
    [button setTitle:selectRowString forState:UIControlStateNormal];
    [button setTitle:selectRowString forState:UIControlStateSelected];
    //关闭菜单显示
    [self showAnimationMenu:NO];
    
    //保存点击的行
    self.selectRowArray[self.clickButtonIndex] = [NSNumber numberWithInteger:indexPath.row];
    
    //执行协议方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:self.clickButtonIndex];
        [self.delegate didSelectRowAtIndexPath:selectIndexPath];
    }
}
@end
