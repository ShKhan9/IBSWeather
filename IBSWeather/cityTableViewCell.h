//
//  mesgrTableViewCell.h
//  PrayerNow
//
//  Created by ApprocksEg on 10/30/15.
//  Copyright © 2015 ApprocksEg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cityTableViewCell : UITableViewCell
 
@property (weak, nonatomic) IBOutlet UILabel*  cityNamelb;

@property (weak, nonatomic) IBOutlet UILabel*  currentTemplb;

@property (weak, nonatomic) IBOutlet UILabel*  humiditylb;

@property (weak, nonatomic) IBOutlet UILabel*  degreelb;

@property (weak, nonatomic) IBOutlet UILabel*  speedlb;

@property (weak, nonatomic) IBOutlet UIView *helperView;


@end
