//
//  setreminderViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 13/05/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "setreminderViewController.h"

@interface setreminderViewController ()

@end

@implementation setreminderViewController
@synthesize radioButtonSetController,minute,hour,day,month,year,profileid;

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
    radioButtonSetController = [[GSRadioButtonSetController alloc] init];
    radioButtonSetController.delegate = self;
    NSArray *first=[[NSArray alloc]initWithObjects:minute,hour,day,month,year, nil];
    radioButtonSetController.buttons=first;
    month.selected=YES;
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];
}



-(void)backbuttonaction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchtimes
{
}

- (void)radioButtonSetController:(GSRadioButtonSetController *)controller didSelectButtonAtIndex:(NSUInteger)selectedIndex
{
}


@end
