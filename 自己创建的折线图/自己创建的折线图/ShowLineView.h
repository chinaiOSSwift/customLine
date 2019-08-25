//
//  ShowLineView.h
//  自己创建的折线图
//
//  Created by KOCHIAEE6 on 2019/8/25.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowLineView : UIView
/*横线个数*/
@property(nonatomic,assign)int horizontalLineNum;
/*竖线个数*/
@property(nonatomic,assign)int verticalLineNum;

/**
 Y轴的起始数据
 */
@property(nonatomic,assign)int YStartNum;
/**
 Y轴的间隔 step 步长
 */
@property(nonatomic,assign)int YStepSize;

- (void)drawRateWithPoint:(NSNumber *)point Point1:(NSNumber *)point1 Point2:(NSNumber *)point2 Point3:(NSNumber *)point3 Point4:(NSNumber *)point4;
@end

NS_ASSUME_NONNULL_END
