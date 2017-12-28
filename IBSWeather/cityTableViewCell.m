//
//  mesgrTableViewCell.m
//  PrayerNow
//
//  Created by ApprocksEg on 10/30/15.
//  Copyright © 2015 ApprocksEg. All rights reserved.
//

#import "cityTableViewCell.h"

@implementation cityTableViewCell
 
- (void)awakeFromNib {
    // Initialization code
    
    self.helperView.layer.cornerRadius = 5;
    
    self.helperView.clipsToBounds = YES;
    
   // self.contentView.layer.cornerRadius = 5;
    
   // self.contentView.clipsToBounds = YES;
    
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
