//
//  additionalreminderViewController.m
//  Pet Planner
//
//  Created by Vinila Vijayakumar on 19/07/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "additionalreminderViewController.h"
#import "PetProfile.h"
#import "Additional.h"
#define kOFFSET_FOR_KEYBOARD_iphone 250.0
#define kOFFSET_FOR_KEYBOARD 250.0

@interface additionalreminderViewController ()

@end

@implementation additionalreminderViewController
@synthesize profileID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.petname.userInteractionEnabled=NO;
    self.productname.delegate=self;
    self.manufname.delegate=self;
    self.amountdosage.delegate=self;
    self.frequencydosge.delegate=self;
    appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"PetProfile"
                inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"profileID ==%@", profileID];
    
    [request setEntity:[NSEntityDescription entityForName:@"PetProfile" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSMutableArray *results;
    results =[[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
    
    NSLog(@"results from fetchdata%@",results);
    for(PetProfile *petdet in results)
    {
        self.petimage.image=[UIImage imageWithData:petdet.image];
        self.petname.text=petdet.dogname;
    }
	self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];
}

-(void)save
{
    NSNumber *numberID=[NSNumber numberWithInt:[self.profileID intValue]];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    Additional *newreminder = [NSEntityDescription
                              insertNewObjectForEntityForName:@"Additional"
                              inManagedObjectContext:context];
    newreminder.petProfileID=numberID;
    [newreminder setValue:self.productname.text forKeyPath:@"productname"];
    [newreminder setValue:self.manufname.text forKeyPath:@"manufacturername"];
    [newreminder setValue:self.amountdosage.text forKeyPath:@"amount"];
    [newreminder setValue:self.frequencydosge.text forKeyPath:@"dosage"];
    NSError *error;
    
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSLog(@"saved");
    [appDelegate saveContext];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backbuttonaction
{
[self.navigationController popViewControllerAnimated:YES];
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        NSLog(@"iphone");
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if (sender.tag==222 )
    {
        NSLog(@"inside did edit begin");
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
