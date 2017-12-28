//
//  detailsPopViewController.h
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "weatherItem.h"
@interface detailsPopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *namelb;

@property (weak, nonatomic) IBOutlet UILabel *templb;

@property (weak, nonatomic) IBOutlet UILabel *minTemplb;

@property (weak, nonatomic) IBOutlet UILabel *maxTemplb;

@property (weak, nonatomic) IBOutlet UILabel *humiditylb;

@property (weak, nonatomic) IBOutlet UILabel *pressurelb;

@property (weak, nonatomic) IBOutlet UILabel *degreelb;

@property (weak, nonatomic) IBOutlet UILabel *speedlb;

@property (weak, nonatomic) IBOutlet UILabel *descriptionlb;


@property (weak, nonatomic) IBOutlet UIView *backView;


@property(nonatomic,strong)weatherItem*we;

@property (weak, nonatomic) IBOutlet UIButton *closeBu;

- (IBAction)closeClicked:(id)sender;

@end
