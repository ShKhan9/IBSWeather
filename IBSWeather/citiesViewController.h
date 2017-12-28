//
//  loginViewController.h
//  sweaa
//
//  Created by ShKhan on 10/9/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface citiesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate >
 
@property (weak, nonatomic) IBOutlet UITableView *areaSettTable;

@property (weak, nonatomic) IBOutlet UIButton *backBu;


@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UITextField *searchTexF;



- (IBAction)backClicked:(id)sender;

@end

