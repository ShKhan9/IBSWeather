//
//  splashViewController.m
//  IBSWeather
//
//  Created by ShKhan on 12/4/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "splashViewController.h"

@interface splashViewController ()

@end

@implementation splashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewDidAppear:(BOOL)animated
{
    //move logo down
     self.weatherImageVBCon.constant = self.view.bounds.size.height/2.0 + self.weatherImageV.bounds.size.height/2.0 ;
    
     self.weatherlbTopCon.constant = -1*(self.view.bounds.size.height/2.0 - self.weatherImageV.bounds.size.height/2.0 - 10 );
    
    [UIView animateWithDuration:2.0 animations:^{
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
       
        UIViewController*vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        
         [self.navigationController pushViewController:vc animated:YES];
        
    }]; 
    
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

@end
