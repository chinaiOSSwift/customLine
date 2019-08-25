//
//  ViewController.m
//  自己创建的折线图
//
//  Created by KOCHIAEE6 on 2019/8/24.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
@interface ViewController ()
@property(nonatomic,strong)CustomView * customView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
    customView.YTitlesArr = @[@"-100",@"-95",@"-90",@"-85",@"-80",@"-75",@"-70",@"-65",@"-60",@"-55",@"-50",@"-45",@"-40",@"-35",@"-30"];
    [customView drawRateWithPoint:@-65 Point1:@-65 Point2:@-65 Point3:@-65 Point4:@-65];
    [self.view addSubview:customView];
    _customView = customView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSInteger temp0 = (40.0 + arc4random_uniform(20)) * -1;
    NSInteger temp1 = (60.0 + arc4random_uniform(20)) * -1;
    NSInteger temp2 = (50.0 + arc4random_uniform(20)) * -1;
    NSInteger temp3 = (70.0 + arc4random_uniform(10)) * -1;
    NSInteger temp4 = (30.0 + arc4random_uniform(10)) * -1;
    NSLog(@"temp--       %ld",temp0);
    [self.customView drawRateWithPoint:[NSNumber numberWithInteger:temp0] Point1:[NSNumber numberWithInteger:temp1] Point2:[NSNumber numberWithInteger:temp2] Point3:[NSNumber numberWithInteger:temp3] Point4:[NSNumber numberWithInteger:temp4]];
}

@end
