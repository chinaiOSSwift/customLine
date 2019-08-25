# customLine
自定义一个折线图,实时绘制

自定义一个类似心率的折线图,可以实时绘制

// 这里创建


// 这里需要注意的是 Y轴是从下往上的
 CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
 customView.YTitlesArr = @[@"-100",@"-95",@"-90",@"-85",@"-80",@"-75",@"-70",@"-65",@"-60",@"-55",@"-50",@"-45",@"-40",@"-35",@"-30"];
    [customView drawRateWithPoint:@-65 Point1:@-65 Point2:@-65 Point3:@-65 Point4:@-65];
    [self.view addSubview:customView];
    _customView = customView;
    
    
    
    // 这里保存多条线的点
    
/*第一条线的数据数组*/
@property (strong, nonatomic) NSMutableArray *points;
/*第二条线的数据数组*/
@property (strong, nonatomic) NSMutableArray *points1;
/*第三条线的数据数组*/
@property (strong, nonatomic) NSMutableArray *points2;
/*第四条线的数据数组*/
@property (strong, nonatomic) NSMutableArray *points3;
/*第五条线的数据数组*/
@property (strong, nonatomic) NSMutableArray *points4;

//这里删除多余的点

- (void)drawRateWithPoint:(NSNumber *)point Point1:(NSNumber *)point1 Point2:(NSNumber *)point2 Point3:(NSNumber *)point3 Point4:(NSNumber *)point4 {
    // 倒叙插入数组
    [self.points insertObject:point atIndex:0];
    [self.points1 insertObject:point1 atIndex:0];
    [self.points2 insertObject:point2 atIndex:0];
    [self.points3 insertObject:point3 atIndex:0];
    [self.points4 insertObject:point4 atIndex:0];
    
    // 删除溢出屏幕数据
    if (self.points.count > self.frame.size.width / (self.horizontalLineNum - 1)) {
        [self.points removeLastObject];
        [self.points1 removeLastObject];
        [self.points2 removeLastObject];
        [self.points3 removeLastObject];
        [self.points4 removeLastObject];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 这个方法自动调取 drawRect:方法
        [self setNeedsDisplay];
    });
}


/// 注意:

 for (int i = 0; i < self.points.count; i++) {
        float h = [self.points[i] floatValue];
        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight; // 注意这里
        NSString *tempStr = [NSString stringWithFormat:@"%.lf",h];
        [path addLineToPoint:CGPointMake(pos_x, pos_y)];
        [tempStr drawInRect:CGRectMake(pos_x - 15, pos_y - 12, 30, 20) withAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        pos_x -= itemWidth;
    }

pos_y 需要根据自己实际情况来算
