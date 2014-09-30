//
//  YQZDropDownMenuView.h
//  YQZ
//  下拉菜单控件
//  Created by lvlin on 14/9/28.
//  Copyright (c) 2014年 All rights reserved.
/*  使用方法
 
    YQZDropDownMenuView *menuView = [[YQZDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    menuView.delegate = self;
    menuView.menuDataArray = @[@[@"全部报价", @"同行收单", @"机构收单"], @[@"返点降序", @"返点升序", @"月综合费用从高到低", @"月综合费用从低到高"], @[@"全部机构",@"xxx公司", @"yyy公司", @"zzz公司"]];
    [menuView loadData];
    [self.view addSubview:menuView];
 */
//

#import <UIKit/UIKit.h>

//菜单显示风格
typedef enum : NSUInteger
{
    MenuStyleGrayCustom = 0,       //使用自定义颜色
    MenuStyleGray,                 //灰色的
    MenuStyleRed,                  //红色的
    MenuStyleGreen,                //绿色的
    MenuStyleBlue,                 //蓝色的
    MenuStyleYellow,               //黄色的
} MenuStyle;

//菜单显示动画类型
typedef enum : NSUInteger
{
    MenuAnimationTypeSlide = 0,            //下滑的
    MenuAnimationTypeFade,                 //渐变的
} MenuAnimationType;

@protocol YQZDropDownMenuViewDelegate <NSObject>

@optional

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfCols;

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface YQZDropDownMenuView : UIView <UITableViewDataSource, UITableViewDelegate>
//代理
@property (nonatomic, weak) id<YQZDropDownMenuViewDelegate> delegate;
//菜单动画类型
@property (nonatomic, assign) MenuAnimationType menuAnimationType;
//菜单风格
@property (nonatomic, assign) MenuStyle menuStyle;
//背景色
@property (nonatomic, strong) UIColor *backGroundColor;
//字体颜色
@property (nonatomic, strong) UIColor *textColor;
//button选中后的字体颜色
@property (nonatomic, strong) UIColor *selectTextColor;
//cell选中后的背景颜色
@property (nonatomic, strong) UIColor *cellSelectBackColor;
//线条颜色
@property (nonatomic, strong) UIColor *lineColor;
//二维数组
@property (nonatomic, strong) NSArray *menuDataArray;

- (void)loadData;

- (void)reloadData;
@end
