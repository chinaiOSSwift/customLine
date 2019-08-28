//
//  CustomView.m
//  自己创建的折线图
//
//  Created by KOCHIAEE6 on 2019/8/24.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import "CustomView.h"
#import "ShowLineView.h"

#define YLabelWidth 25
#define YLabelHeight 20
#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height

@interface CustomView()
@property(nonatomic, strong)ShowLineView *lineView;
@end

@implementation CustomView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}


//@[@"-100",@"-95",@"-90",@"-85",@"-80",@"-75",@"-70",@"-65",@"-60",@"-55",@"-50",@"-45",@"-40",@"-35",@"-30"];
- (void)setYTitlesArr:(NSArray *)YTitlesArr{
    _YTitlesArr = YTitlesArr;
    CGFloat itemHeight = ViewHeight / (YTitlesArr.count - 1);// 每一格的高度,10个数有9个空格,所以减去一
    CGFloat YLeftLabelX = 0; //左边LabelX的起始
    CGFloat YRightLabelX = ViewWidth - YLabelWidth;// 右边LabelX的起始
    for (int i = 0; i < YTitlesArr.count; i ++) {
        CGFloat YLabelY =  ViewHeight - (i * itemHeight) - (YLabelHeight / 2); // Y起始点

        /*左边LB*/
        UILabel * YLeftLB = [[UILabel alloc]initWithFrame:CGRectMake(YLeftLabelX,YLabelY, YLabelWidth, YLabelHeight)]; // 这里是为了让Label的中心 和 线 对齐
        YLeftLB.text = YTitlesArr[i];
        YLeftLB.backgroundColor = [UIColor whiteColor];
        YLeftLB.textAlignment = NSTextAlignmentCenter;
        YLeftLB.font = [UIFont systemFontOfSize:10];
        YLeftLB.textColor = [UIColor blackColor];
        [self addSubview:YLeftLB];
        
        /*右边LB*/
        UILabel * YRightLB = [[UILabel alloc]initWithFrame:CGRectMake(YRightLabelX, YLabelY, YLabelWidth, YLabelHeight)];
        YRightLB.text = YTitlesArr[i];
        YRightLB.backgroundColor = [UIColor whiteColor];
        YRightLB.textAlignment = NSTextAlignmentCenter;
        YRightLB.font = [UIFont systemFontOfSize:10];
        YRightLB.textColor = [UIColor blackColor];
        [self addSubview:YRightLB];
    }
    [self setUpLineView];
}

/*
 创建折线图View
 */

- (void)setUpLineView{
    
    ShowLineView *lineView = [[ShowLineView alloc]initWithFrame:CGRectMake(YLabelWidth, 0, ViewWidth - (2 * YLabelWidth), ViewHeight)];
    _lineView = lineView;
    lineView.horizontalLineNum = 11;
    lineView.verticalLineNum = 15;
    lineView.YStartNum = ((NSString *)self.YTitlesArr.firstObject).intValue; //-100
    lineView.YEndNum = ((NSString *)self.YTitlesArr.lastObject).intValue; //-30
    [self addSubview:lineView];
    
}

- (void)drawRateWithPoint:(NSNumber *)point Point1:(NSNumber *)point1 Point2:(NSNumber *)point2 Point3:(NSNumber *)point3 Point4:(NSNumber *)point4{
    [self.lineView drawRateWithPoint:point Point1:point1 Point2:point2 Point3:point3 Point4:point4];
}



@end
