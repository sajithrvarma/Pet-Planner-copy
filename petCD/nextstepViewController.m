//
//  nextstepViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 19/04/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "nextstepViewController.h"
#import "FBCDDetailViewController.h"
#import "userprofileViewController.h"
#import "Pet.h"

@interface nextstepViewController ()

@end

@implementation nextstepViewController
@synthesize steps,speciesofpet,user,petname,profileID;

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
     appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
        self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];
    displayarray=[[NSMutableArray alloc]init];
    int profileidint=[profileID intValue];
    possiblesteps=[[NSMutableArray alloc]initWithObjects:@"Gastrointestinal Worm Prevention",@"Heartworm Prevention",@"Tapeworm Prevention",@"Flea Prevention",@"Tick Prevention", nil];
    dupliarray=[[NSMutableArray alloc]initWithArray:possiblesteps];
   /* if([steps count]==4)
    { [possiblesteps removeObjectAtIndex:3];
        [steps removeObjectAtIndex:3];}*/
    for(int i=0;i<[steps count];i++)
    {
        if ([[steps objectAtIndex:i]isEqualToString:@"-"]) {
            [steps removeObjectAtIndex:i];
            [possiblesteps removeObjectAtIndex:i];
        }}
    NSLog(@"next step to go is %i %@ %@",[steps count],steps,possiblesteps);

    for(int j=0;j<[steps count];j++)
    {
        if ([[steps objectAtIndex:j]isEqualToString:@"N"]) {
          //  [steps removeObjectAtIndex:j];
           // [possiblesteps removeObjectAtIndex:j];
            [displayarray addObject:[possiblesteps objectAtIndex:j]];
            NSLog(@"removed object at %i",j);
        }
        else{NSLog(@"noooooo %i",j);}
    }
    NSLog(@"next step to go is %i %@ %@ %@",[steps count],steps,possiblesteps,displayarray);
     NSMutableArray *anotherdupli=[[NSMutableArray alloc]initWithArray:displayarray];
    [displayarray removeAllObjects];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    for (int i=0; i<[anotherdupli count]; i++) {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productname==%@ && petprofileID==%@",[anotherdupli objectAtIndex:i],[NSNumber numberWithInt:profileidint]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if([fetchedObjects count]==0) {
        [displayarray addObject:[anotherdupli objectAtIndex:i]];
    }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Received memory warning");
}


-(void)backbuttonaction
{
   [self performSegueWithIdentifier:@"gohome" sender:nil];
    //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

#pragma mark - Table View


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if([displayarray count]!=0)
    {return [displayarray count];}
    else
    { return 1;}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITextView *header=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    header.backgroundColor=[UIColor blueColor];
    header.font=[UIFont boldSystemFontOfSize:20];
    header.textColor=[UIColor whiteColor];
    header.text=@"            Next step to go";
    header.editable=NO;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    cell.textLabel.font=[ UIFont fontWithName: @"Helvetica" size: 17.0];
    if ([displayarray count]!=0) {
        
        cell.textLabel.text=[displayarray objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text=@"                       COMPLETE";
         cell.accessoryType = UITableViewCellAccessoryNone;
        UIAlertView *novaccination=[[UIAlertView alloc]initWithTitle:nil message:@"Congratulations! Your pet's preventative health program is now complete!" delegate:self cancelButtonTitle:@"OK, Return home" otherButtonTitles:nil];
        [novaccination show];
    }
         //  novacci=YES;}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tosearch=[[NSString alloc]init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    tosearch = cell.textLabel.text;
  

   [self performSegueWithIdentifier:@"goback" sender:nil];
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        //[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
        [self performSegueWithIdentifier:@"gohome" sender:nil];
    }
}


-(int)searchforit
{
    int index=0;
    for(int i=0;i<[dupliarray count];i++)
{if([[dupliarray objectAtIndex:i]isEqualToString:tosearch])
{index=i;
    break;}}
    return index;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        if([[segue identifier]isEqualToString:@"gohome"])
        {
            userprofileViewController *home=[[userprofileViewController alloc]init];
            home=segue.destinationViewController;
            home.usernameprofile=user;
        }
else
{
    FBCDDetailViewController *extra=[[FBCDDetailViewController alloc]init];
    extra=segue.destinationViewController;
    int i;
    if([speciesofpet isEqualToString:@"Dog"])
    {i=1;}
    else {i=2;}
    extra.num=[NSString stringWithFormat:@"%d",[self searchforit]];
    extra.tablenum=[NSString stringWithFormat:@"%d",i];
    extra.profileid=profileID;
    extra.speciesofpet=speciesofpet;
    extra.petname=petname;
    extra.user=user;
}
}

@end
