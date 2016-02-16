//
//  ViewController.m
//  Acromine
//
//  Created by DevanRaju on 08/01/16.
//  Copyright © 2016 First-tek. All rights reserved.
//

#import "ViewController.h"
#import "WebserviceCalls.h"
#import "MBProgressHUD.h"
#import "DetailViewController.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFKeyword;
@property (weak, nonatomic) IBOutlet UILabel *labelAcromine;
@property (nonatomic,strong)NSMutableArray *arrayAcromines;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //for setting the navigation title color
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Helvetica Bold" size:20]}];
    
    self.arrayAcromines =[NSMutableArray new];
    
   
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonDoneAction:(id)sender
{
    if ([self.textFKeyword.text isEqualToString:@""]||[self.textFKeyword.text isKindOfClass:[NSNull class]])
    {
        UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Please enter the valied String" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertCont addAction:okAction];
        [self presentViewController:alertCont animated:YES completion:nil];
    }
    else
    {
        [self showHUD];
        [self makeWebServiceCallWithKeyWord:self.textFKeyword.text];
    }
}

#pragma mark WebServiceCall methods

-(void)makeWebServiceCallWithKeyWord:(NSString*)keyWordString
{
    [[WebserviceCalls sharedInstance]getAcromineWithKeyWork:keyWordString SuccessBlock:^(id responseObject)
    {
        NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions
                                                                   error:nil];
        [self jsonObjectWithMethod:jsonDict];
    }
    failedCallBack:^(NSError *error)
    {
        UIAlertController *alertCont = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Server Error. Please try after some time." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertCont addAction:okAction];
        [self presentViewController:alertCont animated:YES completion:nil];
        
    }];
}

#pragma mark CustomMethod

-(void)jsonObjectWithMethod:(NSDictionary*)dict
{
     self.arrayAcromines =[NSMutableArray new];
    NSArray *array = (NSArray *)dict;
    for (int i=0;i<[array count] ; i++)
    {
        NSDictionary *dict = array[0];
        NSArray *localArray = [dict objectForKey:@"lfs"];
        for (int i =0; i<[localArray count]; i++)
        {
            NSDictionary *localDict =localArray[i];
            NSString *str =[localDict objectForKey:@"lf"];
            [self.arrayAcromines addObject:str];
        }
    }

    [self hideHUD];
    [self performSegueWithIdentifier:@"Details" sender:self];
}

#pragma mark Progress HUD

-(void)showHUD
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideHUD
{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

#pragma mark Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"Details"])
    {
        DetailViewController *detailVC =[segue destinationViewController];
        detailVC.arrayAcromine = self.arrayAcromines;
        detailVC.strTitle = self.textFKeyword.text;
        
        //Setting the back Button text for the next View controller.
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
    }
}

#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
