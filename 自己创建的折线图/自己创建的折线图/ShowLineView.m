//
//  ShowLineView.m
//  自己创建的折线图
//
//  Created by KOCHIAEE6 on 2019/8/25.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import "ShowLineView.h"


#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height


@interface ShowLineView()
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

@end

@implementation ShowLineView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.points = [[NSMutableArray alloc]init];
        self.points1 = [[NSMutableArray alloc]init];
        self.points2 = [[NSMutableArray alloc]init];
        self.points3 = [[NSMutableArray alloc]init];
        self.points4 = [[NSMutableArray alloc]init];
        self.clearsContextBeforeDrawing = YES;
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawRate];
    [self buildGrid];
}


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

- (void)drawRate {
    
    CGFloat pos_x = ViewWidth; // 起始的X
    CGFloat pos_y =  ViewHeight / 2; //起始的Y View的中间
    CGFloat itemWidth = ViewWidth / (self.horizontalLineNum - 1);
    CGFloat itemHeight = ViewHeight / (self.verticalLineNum - 1);
    
    //1 获取上下文
    //分别设置线段的颜色
    CGContextRef cyan = UIGraphicsGetCurrentContext();
    [[UIColor cyanColor]setStroke];
    CGContextSaveGState(cyan);
    
    CGContextRef orange = UIGraphicsGetCurrentContext();
    [[UIColor orangeColor]setStroke];
    CGContextSaveGState(orange);
    
    CGContextRef blue = UIGraphicsGetCurrentContext();
    [[UIColor blueColor]setStroke];
    CGContextSaveGState(blue);
    
    CGContextRef purple = UIGraphicsGetCurrentContext();
    [[UIColor purpleColor]setStroke];
    CGContextSaveGState(purple);
    
    CGContextRef red = UIGraphicsGetCurrentContext();
    [[UIColor redColor]setStroke];
    CGContextSaveGState(red);
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    //设置线宽
    path.lineWidth = 2.0;
    //把白色的上下文从栈中取出来
    CGContextRestoreGState(cyan);
    //第一条线
    [[UIColor cyanColor]setStroke];
    [path moveToPoint:CGPointMake(pos_x + 3, pos_y)]; //起始点加 3 是为了在边界看不出来,但是不影响后面的点,所有没有关系
    for (int i = 0; i < self.points.count; i++) {
        float h = [self.points[i] floatValue];
        CGFloat Y = 0;
        CGFloat nextY = 0;
        if (i != self.points.count - 1 && self.points.count > 2 ) {
          float nextH = [self.points[i + 1] floatValue];
            nextY = ViewHeight - ((nextH + 100) / 5)  * itemHeight; // 注意这里
        }
        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight; // 注意这里
        if (pos_y >= nextY) { // 上升,不用动
            Y =  pos_y - 12;
        }else{
            Y =  pos_y + 10;
        }
        NSString *tempStr = [NSString stringWithFormat:@"%.lf",h];
        [path addLineToPoint:CGPointMake(pos_x, pos_y)];
        [tempStr drawInRect:CGRectMake(pos_x - 15, Y, 30, 20) withAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        pos_x -= itemWidth;
    }
    [path stroke];
    
    pos_x = ViewWidth; // 起始的X
    pos_y =  ViewHeight / 2; //起始的Y View的中间
    //把紫色的上下文从栈中取出来
    CGContextRestoreGState(orange);
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    //设置线宽
    path1.lineWidth = 2.0;
    //第二条线
    [[UIColor orangeColor]setStroke];
    [path1 moveToPoint:CGPointMake(pos_x + 3, pos_y)];//起始点加 3 是为了在边界看不出来,但是不影响后面的点,所有没有关系
    for (int i = 0; i < self.points1.count; i++) {
        float h = [self.points1[i] floatValue];

        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight;
        [path1 addLineToPoint:CGPointMake(pos_x, pos_y)];
        pos_x -= itemWidth;
    }
    [path1 stroke];


    pos_x = ViewWidth; // 起始的X
    pos_y =  ViewHeight / 2; //起始的Y View的中间
    // 第三条
    //把紫色的上下文从栈中取出来
    CGContextRestoreGState(blue);
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    //设置线宽
    path2.lineWidth = 2.0;
    //第三条线
    [[UIColor blueColor]setStroke];
    [path2 moveToPoint:CGPointMake(pos_x + 3, pos_y)];//起始点加 3 是为了在边界看不出来,但是不影响后面的点,所有没有关系
    for (int i = 0; i < self.points2.count; i++) {
        float h = [self.points2[i] floatValue];
        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;

        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight;
        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
        [path2 addLineToPoint:CGPointMake(pos_x, pos_y)];
        pos_x -= itemWidth;
    }
    [path2 stroke];


    //第四条
    pos_x = ViewWidth; // 起始的X
    pos_y =  ViewHeight / 2; //起始的Y View的中间
    //把紫色的上下文从栈中取出来
    CGContextRestoreGState(purple);
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    //设置线宽
    path3.lineWidth = 2.0;
    [[UIColor purpleColor]setStroke];
    [path3 moveToPoint:CGPointMake(pos_x + 3, pos_y)];//起始点加 3 是为了在边界看不出来,但是不影响后面的点,所有没有关系
    for (int i = 0; i < self.points3.count; i++) {
        float h = [self.points3[i] floatValue];
        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;

        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight;
        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
        [path3 addLineToPoint:CGPointMake(pos_x, pos_y)];
        pos_x -= itemWidth;
    }
    [path3 stroke];


    //第五条
    pos_x = ViewWidth; // 起始的X
    pos_y =  ViewHeight / 2; //起始的Y View的中间
    //把紫色的上下文从栈中取出来
    CGContextRestoreGState(red);
    UIBezierPath *path4 = [UIBezierPath bezierPath];
    //设置线宽
    path4.lineWidth = 2.0;
    [[UIColor redColor]setStroke];
    [path4 moveToPoint:CGPointMake(pos_x + 3, pos_y)];//起始点加 3 是为了在边界看不出来,但是不影响后面的点,所有没有关系
    for (int i = 0; i < self.points4.count; i++) {
        float h = [self.points4[i] floatValue];
        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;

        pos_y = ViewHeight - ((h + 100) / 5)  * itemHeight;
        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
        [path4 addLineToPoint:CGPointMake(pos_x, pos_y)];
        pos_x -= itemWidth;
    }
    [path4 stroke];

    
    
    
    
    
    //
    //    // 获取当前画布
    //    CGContextRef purple = UIGraphicsGetCurrentContext();
    //    //    // 折线宽度
    //    //    CGContextSetLineWidth(context, 1.0);
    //    //    //消除锯齿
    //    //    CGContextSetAllowsAntialiasing(context,false);
    //    //    // 折线颜色
    //    //    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //    [[UIColor purpleColor] setStroke];
    //    CGContextSetLineWidth(purple, 1.0);
    //    pos_x = ww; // 起始的X
    //    pos_y =  hh / 2; //起始的Y View的中间
    //    CGContextMoveToPoint(purple, pos_x, pos_y);
    //    for (int i = 0; i < self.points.count; i++) {
    //        float h = [self.points[i] floatValue];
    //        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;
    //
    //        pos_y = hh - ((h + 100) / 5)  * itemHeight;
    //        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
    //        CGContextAddLineToPoint(purple, pos_x, pos_y);
    //        pos_x -= itemWidth;
    //    }
    //    // 紫色CGContextRef保存到栈
    //    UIGraphicsPushContext(purple);
    //    // 重新设置颜色
    //    [[UIColor redColor] setStroke];
    //    // 重新设置线宽
    //    CGContextSetLineWidth(purple, 1);
    //    pos_x = ww; // 起始的X
    //    pos_y =  hh / 2; //起始的Y View的中间
    //    CGContextMoveToPoint(purple, pos_x, pos_y);
    //    for (int i = 0; i < self.points2.count; i++) {
    //        float h = [self.points2[i] floatValue];
    //        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;
    //
    //        pos_y = hh - ((h + 100) / 5)  * itemHeight;
    //        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
    //        CGContextAddLineToPoint(purple, pos_x, pos_y);
    //        pos_x -= itemWidth;
    //    }
    //
    //    // 紫色CGContextRef保存到栈
    //    UIGraphicsPushContext(purple);
    //    // 重新设置颜色
    //    [[UIColor blueColor] setStroke];
    //    // 重新设置线宽
    //    CGContextSetLineWidth(purple, 1);
    //    pos_x = ww; // 起始的X
    //    pos_y =  hh / 2; //起始的Y View的中间
    //    CGContextMoveToPoint(purple, pos_x, pos_y);
    //    for (int i = 0; i < self.points3.count; i++) {
    //        float h = [self.points3[i] floatValue];
    //        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;
    //
    //        pos_y = hh - ((h + 100) / 5)  * itemHeight;
    //        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
    //        CGContextAddLineToPoint(purple, pos_x, pos_y);
    //        pos_x -= itemWidth;
    //    }
    //
    //    // 紫色CGContextRef保存到栈
    //    UIGraphicsPushContext(purple);
    //    // 重新设置颜色
    //    [[UIColor orangeColor] setStroke];
    //    // 重新设置线宽
    //    CGContextSetLineWidth(purple, 1);
    //    pos_x = ww; // 起始的X
    //    pos_y =  hh / 2; //起始的Y View的中间
    //    CGContextMoveToPoint(purple, pos_x, pos_y);
    //    for (int i = 0; i < self.points4.count; i++) {
    //        float h = [self.points4[i] floatValue];
    //        //        pos_y = (((hh / -70) * h ) + ((3 / 7 * -1) * hh)) ;
    //
    //        pos_y = hh - ((h + 100) / 5)  * itemHeight;
    //        NSLog(@"第[%d]数值是:%@, h -- %lf pos_y值是:%f h + 100:%lf",i,self.points[i],h,pos_y,h + 100);
    //        CGContextAddLineToPoint(purple, pos_x, pos_y);
    //        pos_x -= itemWidth;
    //    }
    //
    //
    //
    //
    //
//    CGContextStrokePath(red);
//    CGContextStrokePath(blue);
//    CGContextStrokePath(purple);
//    CGContextStrokePath(white);
//    CGContextStrokePath(orange);
}


#pragma mark - 网格

- (void)buildGrid {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat itemWidth = ViewWidth / (self.horizontalLineNum - 1);
        CGFloat itemHeight = ViewHeight / (self.verticalLineNum - 1);
        CGFloat pos_x = 0.0f;
        CGFloat pos_y = 0.0f;
    
        // 在wight(宽度)范围内画竖线
        while (pos_x <= ViewWidth) {
            // 设置网格线宽度
            CGContextSetLineWidth(context, 0.2);
            // 设置网格线颜色
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
            // 起点
            CGContextMoveToPoint(context, pos_x, 0.0f);
            // 终点
            CGContextAddLineToPoint(context, pos_x, ViewHeight);
            pos_x += itemWidth;
            //开始划线
            CGContextStrokePath(context);
        }
    
        // 在height范围内画横线
        while (pos_y <= ViewHeight) {
    
            CGContextSetLineWidth(context, 0.2);
            CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
            CGContextMoveToPoint(context, 0.0f, pos_y);
            CGContextAddLineToPoint(context, ViewWidth, pos_y);
            pos_y += itemHeight;
            CGContextStrokePath(context);
        }
    
    /**
        pos_x = 0.0f; pos_y = 0.0f;
        // 在wight范围内画竖线
        while (pos_x < ViewWidth) {
            CGContextSetLineWidth(context, 0.1);
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextMoveToPoint(context, pos_x, 1.0f);
            CGContextAddLineToPoint(context, pos_x, ViewHeight);
            pos_x += (itemWidth / 5);
            CGContextStrokePath(context);
        }
    
        // 在height范围内画横线
        while (pos_y < ViewHeight) {
            CGContextSetLineWidth(context, 0.1);
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextMoveToPoint(context, 1.0f, pos_y);
            CGContextAddLineToPoint(context, ViewWidth, pos_y);
            pos_y += (itemHeight / 5);
            CGContextStrokePath(context);
        }
     **/
}

@end
