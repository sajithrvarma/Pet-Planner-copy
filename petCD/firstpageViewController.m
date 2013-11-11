//
//  firstpageViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "firstpageViewController.h"
#import "UITextField+custom.h"
#import "userprofileViewController.h"
#import "profileViewController.h"
#define kOFFSET_FOR_KEYBOARD_iphone 120.0
#define kOFFSET_FOR_KEYBOARD 120.0


@interface firstpageViewController ()

@end

@implementation firstpageViewController

@synthesize username,label,create,signin,createprofile,viewprofile;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.username.delegate=self;
    /*if ([UIScreen mainScreen ].bounds.size.height==568)
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pp_loginbg-568h@2x.png"]];
    
    else
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pp_loginbg.png"]];*/

}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.label.hidden=YES;
    self.username.hidden=YES;
    self.viewprofile.hidden=YES;
    self.createprofile.hidden=YES;
    self.create.hidden=NO;
    self.signin.hidden=NO;
}
-(IBAction)create:(id)sender
{
    self.label.hidden=NO;
    self.username.hidden=NO;
    username.text=@"";
    self.signin.hidden=YES;
    self.create.hidden=YES;
    self.createprofile.hidden=NO;
    self.label.font=[UIFont fontWithName:@"Corbert-Regular" size:15];
    self.label.textColor=[UIColor whiteColor];
    self.label.text=@"Create a user name:";
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


-(IBAction)createprofile:(id)sender
{
    BOOL single;
    if ([self.username.text isEqualToString:@""]) {
        UIAlertView *emptystring=[[UIAlertView alloc]initWithTitle:@"Empty string" message:@"Please select a user name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Go Back", nil];
        emptystring.tag=111;
        [emptystring show];
    }
    else
    {
        
        NSUserDefaults *usernames=[NSUserDefaults standardUserDefaults];
        if ([usernames objectForKey:@"username"])
        {
            namearray=[[NSMutableArray alloc]initWithArray:[usernames objectForKey:@"username"]];
            for (int i=0; i<[namearray count]; i++) {
                if([username.text isEqualToString:[namearray objectAtIndex:i]])
                {
                    UIAlertView *duplicatename=[[UIAlertView alloc]initWithTitle:nil message:@"This User Name already exists. Please select a different User Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [duplicatename show];
                    single=NO;
                    [self viewWillAppear:YES];
                    break;
                }
                else
                    single=YES;
            }
        }
        
        else
        {
            namearray=[[NSMutableArray alloc]init];
            single=YES;
        }
        
        if (single==YES) {
            name=username.text;
            [namearray addObject:username.text];
            [usernames setObject:namearray forKey:@"username"];
            [self performSegueWithIdentifier:@"createprofile" sender:nil];
        }
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
if(alertView.tag==111)
{
    if (buttonIndex == 1) {[self viewWillAppear:YES];}
}
}


-(IBAction)signin:(id)sender
{
    self.signin.hidden=YES;
    self.label.hidden=NO;
    self.username.hidden=NO;
    username.text=@"";
    self.create.hidden=YES;
    self.label.font=[UIFont fontWithName:@"Corbert-Regular" size:15];
    self.label.textColor=[UIColor whiteColor];
    self.label.text=@"Please enter your User Name";
    self.viewprofile.hidden=NO;
    
}

-(IBAction)viewprofile:(id)sender
{
    BOOL check;
    NSUserDefaults *usernames=[NSUserDefaults standardUserDefaults];
    NSMutableArray *checkarray=[[NSMutableArray alloc]initWithArray:[usernames objectForKey:@"username"]];
    NSLog(@"usernames%@",[usernames objectForKey:@"username"]);
    for (int i=0;i<[checkarray count];i++)
    {
        if ([self.username.text isEqualToString:[checkarray objectAtIndex:i]])
        {
            NSLog(@"logged in");
            name=username.text;
            check=YES;
            [self performSegueWithIdentifier:@"showprofile" sender:nil];
            break;
        }
        else
            check=NO;
    }
    if(check==NO)
    {
        UIAlertView *emptystring=[[UIAlertView alloc]initWithTitle:@"Invalid User Name" message:@"Please enter a valid User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [emptystring show];
        [self viewWillAppear:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    profileViewController *petVC=[[profileViewController alloc]init];
    userprofileViewController *cdVC=[[userprofileViewController alloc]init];
    if ([[segue identifier] isEqualToString:@"createprofile"])
    {
        NSLog(@"name is %@",name);
        petVC=[segue destinationViewController];
        petVC.user=name;
    }
    else
    {
        NSLog(@"name is %@",name);
        cdVC=[segue destinationViewController];
        cdVC.usernameprofile=name;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
