//
//  CustomView.h
//  自己创建的折线图
//
//  Created by KOCHIAEE6 on 2019/8/24.
//  Copyright © 2019 KOCHIAEE6. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView
@property(nonatomic, strong)NSArray *YTitlesArr;

- (void)drawRateWithPoint:(NSNumber *)point Point1:(NSNumber *)point1 Point2:(NSNumber *)point2 Point3:(NSNumber *)point3 Point4:(NSNumber *)point4;
@end

NS_ASSUME_NONNULL_END
