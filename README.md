YQZDropDownMenuView
===================

a drop down menu for iOS apps

How to use?

    YQZDropDownMenuView *menuView = [[YQZDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    menuView.delegate = self;
    menuView.menuDataArray = @[@[@"全部报价", @"同行收单", @"机构收单"], @[@"返点降序", @"返点升序", @"月综合费用从高到低", @"月综合费用从低到高"], @[@"全部机构",@"xxx公司", @"yyy公司", @"zzz公司"]];
    [menuView loadData];
    [self.view addSubview:menuView];
