//
//  detailsPopViewController.m
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "detailsPopViewController.h"

@interface detailsPopViewController ()

@end

@implementation detailsPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.closeBu setTitle:[NSString stringWithFormat:@"%C",0xf057] forState:UIControlStateNormal];
    
    self.backView.layer.cornerRadius = 7;
    
    self.backView.clipsToBounds = YES;
    
    self.namelb.text = self.we.name;
    
    self.templb.text = self.we.temp;
    
    self.minTemplb.text = self.we.tempMin;
    
    self.maxTemplb.text = self.we.tempMax;
    
    self.humiditylb.text = self.we.humidity;
    
    self.pressurelb.text = self.we.pressure;
    
    self.degreelb.text = self.we.degree;
    
    self.speedlb.text = self.we.speed;
    
    self.descriptionlb.text = self.we.descriptions;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeClicked:(id)sender {
    
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
}
@end
