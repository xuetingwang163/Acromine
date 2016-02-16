//
//  DetailViewController.m
//  Acromine
//
//  Created by Devan Raju on 16/02/16.
//  Copyright © 2016 First-tek. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableViewDetails;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //for setting the navigation title color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:18]}];
    
     self.navigationItem.title = [NSString stringWithFormat:@"Acronyms of %@",_strTitle];
    
    if (self.arrayAcromine.count == 0)
    {
        UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Alert" message:@"No Acronyms with this word." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertCont addAction:okAction];
        [self presentViewController:alertCont animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Deleagte Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayAcromine.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.arrayAcromine objectAtIndex:indexPath.row];
    
    return cell;
}

@end
