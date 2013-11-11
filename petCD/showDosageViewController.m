//
//  showDosageViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 17/04/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "showDosageViewController.h"
#import "FBCDAppDelegate.h"
#import "PetProfile.h"
#import "nextstepViewController.h"
#import "userprofileViewController.h"

@interface showDosageViewController ()

@end

@implementation showDosageViewController
@synthesize producttoshow,dosetoshow,speciesofpet,petname,user,nextsteptogo,headerhere,profileID,inclusions,productcatid;


- (void)viewDidLoad
{
    [super viewDidLoad];     
    self.inclusions.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pp_incl_label.png"]];
    NSLog(@"checking %@ %@ %@ %@",user,petname,speciesofpet,headerhere);
       FBCDAppDelegate *appdele=(FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    productnumber=[producttoshow intValue];
    NSLog(@"product number %i",[productcatid intValue]);
    dose=[dosetoshow intValue];
    NSLog(@"dose is %i",dose);
    NSMutableArray *amountofdose=[[NSMutableArray alloc]init];
    amountofdose=[appdele.dosetoadmin objectForKey:[NSNumber numberWithInt:productnumber]];
    NSLog(@"amount %@",amountofdose);
    FBCDAppDelegate *appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appdele managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dogname == %@ && username== %@ && species==%@" ,petname,user,speciesofpet];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PetProfile"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSLog(@"fetchobjects is showdosage%@",fetchedObjects);
    for(PetProfile *profile in fetchedObjects)
    {
        NSLog(@"weight and date %@ %@",profile.weight,profile.dob);
    birthday =profile.dob;
        weight=[profile.weight intValue];
    }
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSDayCalendarUnit
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents day];
    NSDateComponents* ageComponents2 = [[NSCalendar currentCalendar]
                                       components:NSWeekCalendarUnit
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger ageweeks=[ageComponents2 week];
    NSLog(@"age in days %i",age);
    int ageindex;
    if(age<=90)
    {NSLog(@"age in weeks %i",ageweeks);}
    int agevacci;
    if(ageweeks<=16)
    {agevacci=2;}
    else
    {agevacci=3;}
    NSMutableArray *dosetohave=[[NSMutableArray alloc]init];
    if(age<=90)
    {dosetohave=[NSMutableArray arrayWithArray:appdele.dosearray];
        ageindex=2;}
    else if(age>90 && age<=180){
        dosetohave=[NSMutableArray arrayWithArray:appdele.dosearray2];
        ageindex=3;}
    else if(age>180 && age<=360)
    {dosetohave=[NSMutableArray arrayWithArray:appdele.dosearray3];
        ageindex=4;
        agevacci=3;}
    else if(age>360)
    {dosetohave=[NSMutableArray arrayWithArray:appdele.dosearray4];
        ageindex=5;
        agevacci=4;}
   
    NSLog(@"dosearray is %@",dosetohave);
    int number=0,doseindex;
    NSArray *weightcat;
    if([speciesofpet isEqualToString:@"Dog"])
    {
    weightcat=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"65",@"70",@"75",@"80",@"85",@"90",@"95",@"100", nil];
        doseindex=30;
    }
    else{
        weightcat=[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12", nil];
        doseindex=30;
    }
    for(int i=0;i<[weightcat count];i++){
    if (weight>[[weightcat objectAtIndex:i]intValue] && weight<=[[weightcat objectAtIndex:i+1]intValue]) {
        number=6+i;
    }}
    if([productcatid intValue]>=10)
    {
        UIView *vaccishowview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        vaccishowview.opaque=YES;
        vaccishowview.backgroundColor=[UIColor grayColor];
        UITextView *vacciamount=[[UITextView alloc]init];
        UITextView *warning;
        if([[amountofdose objectAtIndex:doseindex+3] isEqualToString:@""]){
        vacciamount.frame=CGRectMake(20, 200, 280, 200);}
        else{
        vacciamount.frame=CGRectMake(20, 100, 280, 150);
            warning=[[UITextView alloc]initWithFrame:CGRectMake(20, 300, 280, 150)];
            warning.editable=NO;
            warning.text=[amountofdose objectAtIndex:doseindex+3];
            warning.font=[UIFont fontWithName:@"Corbert-Regular" size:21];
            [vaccishowview addSubview:warning];
        }
        vacciamount.text=[amountofdose objectAtIndex:agevacci];
        vacciamount.editable=NO;
        vacciamount.font=[UIFont fontWithName:@"Corbert-Regular" size:21];
        [vaccishowview addSubview:vacciamount];
               [self.view addSubview:vaccishowview];
    }
    else{
    
    self.header.text=[amountofdose objectAtIndex:0];
    self.header.userInteractionEnabled=NO;

    self.hwp.backgroundColor=[UIColor colorWithPatternImage:[self labeltext: [amountofdose objectAtIndex:doseindex]]];
    self.ticks.backgroundColor=[UIColor colorWithPatternImage:[self labeltext: [amountofdose objectAtIndex:doseindex+2]]];
    self.flea.backgroundColor=[UIColor colorWithPatternImage:[self labeltext:[amountofdose objectAtIndex:doseindex+1]]];
    NSLog(@"enthoo %@",[appdele.dosetoadmin objectForKey:[NSNumber numberWithInt:productnumber]]);
    self.information.backgroundColor=[UIColor clearColor];
    self.information2.backgroundColor=[UIColor clearColor];
    self.information.text=[amountofdose objectAtIndex:ageindex];
    self.information2.text=[amountofdose objectAtIndex:number];
    nextsteptogo=[[NSMutableArray alloc]init];
    for (int j=0;j<5;j++)
    {
        [nextsteptogo addObject:[amountofdose objectAtIndex:doseindex+4+j]];
    }
    /*if ([speciesofpet isEqualToString:@"Cat"]) {
        [nextsteptogo removeObjectAtIndex:3];
    }*/
    NSLog(@"next step to go %@",nextsteptogo);
    }
    
    
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];
}


-(void)backbuttonaction
    {
        if([productcatid intValue]>=10)
        {
            
            for (UIViewController* viewController in self.navigationController.viewControllers) {
                
                
                if ([viewController isKindOfClass:[userprofileViewController class]] ) {
                    
                    
                    userprofileViewController *groupViewController = (userprofileViewController*)viewController;
                    [self.navigationController popToViewController:groupViewController animated:YES];
                }
            }
            
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];}
    }

-(UIImage *)labeltext:(NSString *)data
{
//NSString *result=[[NSString alloc]init];
    UIImage *result=[[UIImage alloc]init];
if([data isEqualToString:@"N"])
{ result= [UIImage imageNamed:@"tick.png"];}
else if([data isEqualToString:@"Y"])
{result= [UIImage imageNamed:@"cross.png"];}
    NSLog(@"result is %@ %@ ",data,result);
    return result;
}

-(IBAction)continuetonextstep:(id)sender
{
    [self performSegueWithIdentifier:@"go" sender:nil];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     nextstepViewController *go=[[nextstepViewController alloc]init];
     go=segue.destinationViewController;
     go.steps=[NSMutableArray arrayWithArray:nextsteptogo];
     go.user=user;
     go.speciesofpet=speciesofpet;
     go.petname=petname;
     go.profileID=profileID;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
