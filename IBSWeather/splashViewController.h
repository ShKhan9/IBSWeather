//
//  splashViewController.h
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface splashViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageV;

@property (weak, nonatomic) IBOutlet UILabel *weatherlb;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weatherImageVBCon;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weatherlbTopCon;

@end
