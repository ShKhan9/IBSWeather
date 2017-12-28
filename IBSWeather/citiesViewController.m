//
//  messengerViewController.m
//  sweaa
//
//  Created by ShKhan on 10/9/17.
//  Copyright © 2017 Approcks. All rights reserved.
//

#import "citiesViewController.h"
#import "weatherItem.h"
#import "DataClass.h"
#import "cityTableViewCell.h"
#import "downloadItem.h"
#import "detailsPopViewController.h"
static NSString *CellIdentifier1 = @"ContentCell1";

@interface citiesViewController ()
{
    
    
    NSMutableArray*dataDef;
    

}

@property(nonatomic,strong) NSMutableArray* allDownloads;

@property(nonatomic,copy) NSMutableArray* dataDef;

@end

@implementation citiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"refreshDataYaCities"
                                               object:nil];
    
    self.allDownloads = [NSMutableArray new];
    
     self.dataDef = [NSMutableArray new];
    
    self.searchView.layer.cornerRadius = 7;
    
    self.searchView.clipsToBounds = YES;
    
    self.searchView.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.searchView.layer.borderWidth = 1 ;
    
    
    _searchTexF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"Search for a city . . ."
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                 
                                                 }
     ];
    
    
    _searchTexF.delegate = self ;
    
    NSBundle* frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    UINib *nib1 = [UINib nibWithNibName:@"cityTableViewCell" bundle:frameworkBundle];
    
    [self.areaSettTable registerNib:nib1 forCellReuseIdentifier:CellIdentifier1];
    
  //  self.view.backgroundColor = [UIColor lightGrayColor];
   
    [self.areaSettTable setBounces:NO];
    
    self.areaSettTable.delegate=self;
    
    self.areaSettTable.dataSource=self;
    
    self.areaSettTable.backgroundColor = [UIColor lightGrayColor];
    
    self.areaSettTable.opaque = NO;
    
    self.areaSettTable.separatorColor = [UIColor clearColor];
    
    self.areaSettTable.estimatedRowHeight = 300;
    
    self.areaSettTable.rowHeight = UITableViewAutomaticDimension;
    
    self.areaSettTable.showsVerticalScrollIndicator = NO;
    
  
    if([[DataClass getInstance] ar])
    {
        [self.backBu setTitle:[DataClass getInstance].rightArrow forState:UIControlStateNormal];
    }
    else
    {
        [self.backBu setTitle:[DataClass getInstance].leftArrow forState:UIControlStateNormal];
    }
    
  
    [_searchTexF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    self.dataDef = [DataClass getInstance].allEgypt;
}

-(void)textFieldDidChange :(UITextField *)textField{
   
    
    NSString*text = textField.text;
    
    if([text isEqualToString:@""])
    {
       self.dataDef = [DataClass getInstance].allEgypt;
        
    }
    else
    {
        
        NSMutableArray*wer = [NSMutableArray new];
        
        for (int i = 0; i<[[DataClass getInstance].allEgypt count]; i++)
        {
            
            weatherItem*we = [[DataClass getInstance].allEgypt objectAtIndex:i];
            
            if ([we.name.uppercaseString rangeOfString:text.uppercaseString].location != NSNotFound)
            {
                
                [wer addObject:we];
               
            }
            
        }
        
        
        self.dataDef = wer ;
        
        
    }
    
    [self.areaSettTable reloadData];
    
    NSLog( @"last count: %lu", (unsigned long)self.dataDef.count);
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)receiveNotification:(NSNotification *)paramNotification
{
    
    
    if([paramNotification.name isEqualToString:@"refreshDataYaCities"])
    {
        NSLog(@"654656655sdaasdasd");
        
        [self.areaSettTable reloadData];
    }
    

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.areaSettTable])
    {
        
        return [self.dataDef count];
        
    }
    
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath      *)indexPath
{
    
    
    if ([tableView isEqual:self.areaSettTable])
    {
       
        
        weatherItem* cr = [self.dataDef objectAtIndex:indexPath.row];
      
        cityTableViewCell *cell =[self.areaSettTable dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if(cr.temp != nil)
        {
            cell.cityNamelb.text = cr.name;
            
            cell.currentTemplb.text = cr.temp;
            
            cell.humiditylb.text = cr.humidity;
            
            cell.degreelb.text = cr.degree;
            
            cell.speedlb.text = cr.speed;
            
        }
        else
        {
            BOOL download  = YES;
            
            for (downloadItem*dwi in self.allDownloads) {
                
                if(dwi.id == cr.id)
                {
                    download = NO ;
                    
                }
                
            }
            
           if(download)
           {
               downloadItem*dw = [[downloadItem alloc]initWithId:cr.id cityName:cr.name];
               
               [self.allDownloads addObject:dw];
               
               [dw startDownload];
           }
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell layoutSubviews];
        
        [cell layoutIfNeeded];
         
        return  cell;
        
    }
  
    
    return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if ([tableView isEqual:self.areaSettTable])
        
    {
         NSLog(@"6551351212222");
        
        weatherItem* cr = [self.dataDef objectAtIndex:indexPath.row];
        
        [self performSegueWithIdentifier:@"showDetails" sender:cr];
        
    }
    
    
}

/*
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 72;
 }
 
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showDetails"])
    {
        
        detailsPopViewController *newVC = segue.destinationViewController;
        
        newVC.we = sender;
        
        [citiesViewController setPresentationStyleForSelfController:self presentingController:newVC];
    }
    
}


+ (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
        
        
        
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}





 -(void)didReceiveMemoryWarning
{
    
    
}

- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
