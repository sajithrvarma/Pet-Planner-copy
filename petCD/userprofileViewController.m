//
//  userprofileViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "userprofileViewController.h"
#import "profileViewController.h"
#import "TableViewController.h"
#import "PetProfile.h"
#import "Pet.h"
#import "setreminderViewController.h"


@interface userprofileViewController ()

@end

@implementation userprofileViewController
@synthesize arrayfortable,table,usernameprofile,hilabel;

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
 /*   if ([[UIScreen mainScreen] bounds].size.height==568) {
         self.background.image=[UIImage imageNamed:@"pp_listviewbg-568h@2x.png"];
    }
    else
    { self.background.image=[UIImage imageNamed:@"pp_listviewbg.png"];}*/
 
    NSLog(@"user is %@",usernameprofile);
    
    self.hilabel.text=[NSString stringWithFormat:@"HI %@!",usernameprofile ];
    table.delegate=self;
    table.dataSource=self;
   // [table setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pp_listviewbg.png"]]];
    arrayfortable=[[NSMutableArray alloc]init];
    NSLog(@"array is in cdview %@",arrayfortable);
   // self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"Add pet" style:UIBarButtonItemStylePlain target:self action:@selector(addpet:)];
    FBCDAppDelegate *appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@",usernameprofile];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PetProfile"
                                              inManagedObjectContext:context];
        
   
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
     NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
   
    NSLog(@"fetchobjects is userprofile %@",fetchedObjects);
    dataarray=[[NSMutableArray alloc]init];
    IDarray=[[NSMutableArray alloc]init];
    agearray=[[NSMutableArray alloc]init];
    for (PetProfile *profileee in fetchedObjects) {
      
        [arrayfortable addObject:profileee.dogname];
        [agearray addObject:profileee.dob];
        [dataarray addObject:profileee.image];
        [IDarray addObject:profileee.profileID];
        petimage=[[UIImage alloc]initWithData:profileee.image];
    }
     NSLog(@"arrayfortable is %@ id array is %@",arrayfortable,IDarray);
   
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];
    int years=0,month=0,days=0;
    for (int k=0;k<[agearray count]; k++) {
        NSString *agestring=[[NSString alloc]init];
        NSDate *date=[agearray objectAtIndex:k];
        NSDate *today=[NSDate date];
        NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                           components:NSDayCalendarUnit
                                           fromDate:date
                                           toDate:today
                                           options:0];
        int age = [ageComponents day];
        NSLog(@"age is %i",age);
        if (age>365) {
            years =age/365;
            month=age%365;
            month=month/30;
            days=month%30;}
        else if(age<365){
            years=0;
            month=age/30;
            days=age%30;}
            else if(age<30)
            {   years=0;
                month=0;
                days=age%30;}
        agestring=[NSString stringWithFormat:@"%i Yr,%i Month & %i Days",years,month,days];
        [agearray replaceObjectAtIndex:k withObject:agestring];
    }
    NSLog(@"agearray is %@",agearray);
}

-(void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
}
-(void)backbuttonaction
{
   [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}
/*-(void)fetchthis
{
    
    FBCDAppDelegate *appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];

    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Pet"
                                               inManagedObjectContext:context];
    NSError *error = nil;
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc]init];
     [fetchRequest2 setEntity:entity2];
     NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
    NSLog(@"fetchobjects 2 %@",fetchedObjects2);
  //  NSMutableArray *catidarray=[[NSMutableArray alloc]init];
  //  NSMutableArray *cateearray=[[NSMutableArray alloc]init];
   // NSMutableArray *catnamearray=[[NSMutableArray alloc]init];
    for(Pet *pett in fetchedObjects2)
        NSLog(@"cat id is %@",pett.catID);
   }*/

-(void)fetchforpet:(NSString *)Name
{
    FBCDAppDelegate *appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"PetProfile"
                inManagedObjectContext:context];
    [request setEntity:entity];
    
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dogname ==%@", Name];
    
    [request setEntity:[NSEntityDescription entityForName:@"PetProfile" inManagedObjectContext:context]];
     [request setPredicate:predicate];
    NSError *error = nil;
    results =[[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
    
    NSLog(@"results from fetchdata%@",results);
    
    for(PetProfile *pett in results)
    {
        species=pett.species;
        petsname=pett.dogname;
        NSLog(@"species is %@",pett.species);
    }
}


-(IBAction)addpet:(id)sender
{
    
    [self performSegueWithIdentifier:@"addpet" sender:nil];
}
-(IBAction)setrem:(id)sender
{
    
    [self performSegueWithIdentifier:@"setreminder" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"view"])
    {
        TableViewController *showtable=[[TableViewController alloc]init];
        showtable=[segue destinationViewController];
        showtable.speciesofpet=species;
        showtable.dogname=petsname;
        showtable.user=usernameprofile;
        showtable.profileid=profileID;
    }
    else if([[segue identifier]isEqualToString:@"edit"])
    {
        profileViewController *edit=[[profileViewController alloc]init];
        edit=segue.destinationViewController;
        edit.ProfileID=[IDarray objectAtIndex:editfor];
        edit.fromedit=@"Yes";
    }
    else if([[segue identifier]isEqualToString:@"setreminder"])
    {
        setreminderViewController *rem=[[setreminderViewController alloc]init];
        rem=segue.destinationViewController;
        rem.profileid=profileID;
    }
    
    else
    {
        profileViewController *addpet=[[profileViewController alloc]init];
        addpet=[segue destinationViewController];
        addpet.user=usernameprofile;
    }
}

-(void)editdetails:(UIButton *)sender
{
    editfor=sender.tag;
    [self performSegueWithIdentifier:@"edit" sender:nil];
}
-(void)deletedetails:(UIButton *)sender
{
    NSLog(@"index.row %i",sender.tag);
    int ind=sender.tag;
    FBCDAppDelegate *appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"profileID == %@",[IDarray objectAtIndex:ind]];
    NSPredicate *predicate2=[NSPredicate predicateWithFormat:@"petprofileID==%@",[IDarray objectAtIndex:ind]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PetProfile"
                                              inManagedObjectContext:context];
    
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Pet"
                                               inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest2 setEntity:entity2];
    [fetchRequest2 setPredicate:predicate2];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (![context save:&error])
    {
        NSLog(@"Problem deleting destination: %@", [error userInfo]);
    }
    if ([fetchedObjects count]!=0) {
        PetProfile *profile=[fetchedObjects objectAtIndex:0];
        
        [context deleteObject:profile];
    }
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
    if (![context save:&error])
    {
        NSLog(@"Problem deleting destination: %@", [error userInfo]);
    }
    if ([fetchedObjects2 count]!=0) {
        Pet *profile=[fetchedObjects2 objectAtIndex:0];
        
        [context deleteObject:profile];
    }
    [appDelegate saveContext];
    
    [arrayfortable removeObjectAtIndex:ind];
    [dataarray removeObjectAtIndex:ind];
    [IDarray removeObjectAtIndex:ind];

    [self tableViewdelete:table commitEditingStyle:nil forRowAtIndexPath:index row:[NSString stringWithFormat:@"%i",sender.tag]];
}
#pragma mark tableview

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"returned value %i",[arrayfortable count]);
    return [arrayfortable count];
    //return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImageView *petimageframe;
    UILabel *petnamelabel,*petagelabel;
    UIButton *editbutton;
    UIButton *deletebutton;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pp_woodtexture.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0]];  
       // cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pp_woodtexture.png"]];
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];}
        CGRect frame=CGRectMake(0, 0, 100,100);
        petimageframe=[[UIImageView alloc]initWithFrame:frame];
        [cell.contentView addSubview:petimageframe];
       
        petnamelabel=[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x+110, frame.origin.y, 170, 60)];
    petnamelabel.font=[UIFont fontWithName:@"Corbert-Regular" size:22.0];
        [cell.contentView addSubview:petnamelabel];
        editbutton=[[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x+275, frame.origin.y+10, 30, 30)];
        [editbutton setTitle:@"Edit" forState:UIControlStateNormal];
    
    petagelabel=[[UILabel alloc]initWithFrame:CGRectMake(frame.origin.x+110, frame.origin.y+60, 170, 40)];
     petagelabel.font=[UIFont fontWithName:@"Corbert-Regular" size:14.0];
    [cell.contentView addSubview:petagelabel];
    
    [editbutton setImage:[UIImage imageNamed:@"btn_edit.png"] forState:UIControlStateNormal];
    [editbutton setImage:[UIImage imageNamed:@"btn_edit_press.png"] forState:UIControlStateHighlighted];
    editbutton.tag=indexPath.row;
    [editbutton addTarget:self action:@selector(editdetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:editbutton];
        deletebutton=[[UIButton alloc]initWithFrame:CGRectMake(frame.origin.x+275, frame.origin.y+60, 30, 30)];
        [deletebutton setTitle:@"Delete" forState:UIControlStateNormal];
        
    [deletebutton setImage:[UIImage imageNamed:@"btn_delete.png"] forState:UIControlStateNormal];
    [deletebutton setImage:[UIImage imageNamed:@"btn_delete_press.png"] forState:UIControlStateHighlighted];
    deletebutton.tag=indexPath.row;
        [deletebutton addTarget:self action:@selector(deletedetails:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:deletebutton];
        
    
   // cell.textLabel.text=[arrayfortable objectAtIndex:indexPath.row];
   // cell.imageView.image = [UIImage imageWithData:[dataarray objectAtIndex:indexPath.row]];
    petimageframe.image= [UIImage imageWithData:[dataarray objectAtIndex:indexPath.row]];
    petnamelabel.text=[arrayfortable objectAtIndex:indexPath.row];
    petagelabel.text=[agearray objectAtIndex:indexPath.row];
    profileID=[IDarray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"profile id is %@",profileID);
    index=indexPath;
    i=indexPath.row;
     currentpetname=[arrayfortable objectAtIndex:indexPath.row];
     [self fetchforpet:currentpetname];
    NSLog(@"currentpetname is %@",currentpetname);
    [self fetchforpet:currentpetname];
    [self performSegueWithIdentifier:@"view" sender:nil];
}

- (void)tableViewdelete:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath row:(NSString *)Row {
    
    editingStyle= UITableViewCellEditingStyleDelete;
   
    NSLog(@"deleted from row");
    [tableView reloadData];
        
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *footerlabel=[[UILabel alloc]init];
    if([arrayfortable count]==0){
        footerlabel.font=[UIFont fontWithName:@"Corbert-Bold" size:17.0];
          footerlabel.text=@"         ~No Pet information added~";
    }
        else
        {
            footerlabel.text=@"";
        }
    return footerlabel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
