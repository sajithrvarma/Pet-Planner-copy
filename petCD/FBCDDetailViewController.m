//
//  FBCDDetailViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 24/01/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "FBCDDetailViewController.h"
#import "FBCDAppDelegate.h"
#import "Pet.h"
#import "showDosageViewController.h"
#import "MarqueeLabel.h"
#import "additionalreminderViewController.h"
#import "Additional.h"

@interface FBCDDetailViewController ()
//- (void)configureView;
@end

@implementation FBCDDetailViewController
@synthesize num,detailtable,displayarray,tablenum,speciesofpet,petname,user,profileid,headerfordosage;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialsetup];
}
-(void)initialsetup{

    
    appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"checking %@ %@",petname,speciesofpet);
    NSLog(@"%@num ",num);
    toadd=NO;
    
    detailtable.delegate=self;
    detailtable.dataSource=self;
    namearray=[[NSMutableArray alloc]init];
    manufarray=[[NSMutableArray alloc]init];
    listthem=[[NSMutableArray alloc]init];
    //productnumber=0;
    fromselect=[[NSString alloc]init];
    fromconti=[[NSString alloc]init];
    indexarray=[[NSMutableArray alloc]init];
    indexfromCD=[[NSMutableArray alloc]init];
    profileidint=[profileid intValue];
    
    productnames=[[NSArray alloc]initWithObjects:@"Gastrointestinal Worm Prevention",@"Heartworm Prevention",@"Tapeworm Prevention",@"Flea Prevention",@"Tick Prevention",@"Vaccination",@"Microchipping & Desexing",@"Other Health Care Reminders", nil];
    
    warnings=[NSUserDefaults standardUserDefaults];
    [warnings setValue:@"If your pet is not responding to this prophylactic health regime, please consult your Veterinary Surgeon for advice." forKey:@"Firstwarning"];
    
    [warnings setValue:@"For dogs at risk or with high environmental infestations of worms, more frequent treatments may be required. Please seek the advice of a Veterinary Surgeon." forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:0]]];
    
    [warnings setValue:@"For dogs that have not previously received HWP or have not received HWP for more than 15days past their required date, administering Heartworm Preventative can cause serious and adverse reactions if your dog is infected with Heartworm. If this warning applies to your dog, please seek the advice of a Veterinary Surgeon." forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:1]]];
    
    [warnings setValue:@"For dogs at risk or with high environmental infestations of hydatid tapeworms, more frequent treatments may be required. Please seek the advice of a Veterinary Surgeon. " forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:2]]];
    
    [warnings setValue:@"During Summer time and periods of high flea activity, an Integrated Flea Control Program is recommended for optimum flea control. Please seek the advice of a Veterinary Surgeon. " forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:3]]];
    
    [warnings setValue:@"During summer, high risk seasons and in high risk environments, Paralysis Tick prevention may require more frequent treatments as well as daily checking. Please seek the advice of a Veterinary Surgeon to decide an optimum paralysis tick prevention for your pet." forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:4]]];
    
    [warnings setValue:@"For dogs that have not previously received HWP or have not received HWP for more than 15days past their required date, administering Heartworm Preventative can cause serious and adverse reactions if your dog is infected with Heartworm. If this warning applies to your dog, please seek the advice of a Veterinary Surgeon." forKey:[NSString stringWithFormat:@"%@2",[productnames objectAtIndex:5]]];
    
    [warnings setValue:@"Pets at high risk or living in high risk environments may require more frequent or varying treatments. Please seek the advice of a Veterinary Surgeon to determine an optimum vaccination protocol for your pet" forKey:@"vacciwarning"];
    
    /* numsave=[NSUserDefaults standardUserDefaults];
     if([numsave integerForKey:@"num"])
     {
     NSLog(@"got here %i",[numsave integerForKey:@"num"]);
     num=[NSString stringWithFormat:@"%i",[numsave integerForKey:@"num"]];
     [numsave removeObjectForKey:@"num"];
     }*/
    
    [self getarray];
    NSLog(@"product number now is %i",productnumber);
    productcatid=[[NSString alloc]init];
    productcatid=[NSString stringWithFormat:@"%i",productnumber];
    
    
    if([num intValue]==7)
    {
        self.navigationItem.rightBarButtonItems=nil;
        NSLog(@"add other1111111111%@", self.navigationItem.rightBarButtonItems);
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addrem)];
        self.navigationItem.rightBarButtonItem.enabled=YES;
        
        NSLog(@"add other222222222%@", self.navigationItem.rightBarButtonItem.title);    }
    else{
        
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]initWithTitle:@"Select" style:UIBarButtonItemStylePlain target:self action:@selector(selectitem)];
        self.navigationItem.rightBarButtonItem.enabled=NO;
    }
    
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productID == %@ && petprofileID==%@",[NSNumber numberWithInt:productnumber],[NSNumber numberWithInt:profileidint]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Pet *getdetails in fetchedObjects) {
        [indexfromCD addObject:getdetails.indexnumber];
    }
    
    
    if([fetchedObjects count]!=0)
    {NSLog(@"item here");
        listthem=indexfromCD;
    NSLog(@"add other3333333333%@", self.navigationItem.rightBarButtonItem.title);
//[self loadView];
    }
    else
    {NSLog(@"no item.. create.. ");
        listthem=nil;}
    
    if([listthem count]!=0){
        fromselect=@"No";
        [self getthearraytobedisplayed];
    }
    else{fromselect=@"Yes";}
    checkmark=0;
    if([num intValue]<7){
        if([fromselect isEqualToString:@"Yes"])
        {
            
            namearray=displayarray;
            manufarray=manufacturearray;
            // self.navigationItem.rightBarButtonItem.enabled=YES;
            UIAlertView *select=[[UIAlertView alloc]initWithTitle:nil message:@"Please select the product you prefer" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
            [select show];
        }}
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];


}
-(void)viewWillAppear:(BOOL)animated
{[detailtable reloadData];}

-(void)backbuttonaction
{
    self.navigationItem.rightBarButtonItems=nil;

    [self.navigationController popViewControllerAnimated:YES];
}


-(void)fromcontinue
{
    numsave=[NSUserDefaults standardUserDefaults];
    if([numsave integerForKey:@"num"])
    {
        NSLog(@"got here %i",[numsave integerForKey:@"num"]);
        num=[NSString stringWithFormat:@"%i",[numsave integerForKey:@"num"]];
        [numsave removeObjectForKey:@"num"];
        fromconti=@"Yes";
    }
    else{fromconti=@"No";}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)getarray
{
    list=[[NSMutableArray alloc]init];
    appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication] delegate];
    if([fromconti isEqualToString:@"Yes"])
    {num=numconti;}
    NSLog(@"string we got here is %@",num);
    NSLog(@"the last digit is %i",([num intValue]));
   
    if ([tablenum intValue]==2)
    {
        list=[appDelegate catarray];
    }
    else if([tablenum intValue]==1)
    {
        list=[appDelegate dogarray];
    }
    headerline=[list objectAtIndex:[num intValue]];
    headerline = [headerline stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"""\n:"]];
    if ([tablenum intValue]==1) {
        switch([num intValue])
        {
            case 0:
                retcount=34;//no:of vaccination under the category
                startingpoint=0;//the postion of the vaccine name in the list of products
                productnumber=0;//the number of the category of vaccinations(eg: heartworm)
                productname=[productnames objectAtIndex:0];//name of the product (eg: ambex)
                dosetoadminindex=1;//till 34
                break;
                
            case 1:
                retcount=18;
                startingpoint=34;
                productnumber=1;
                productname=[productnames objectAtIndex:1];
                dosetoadminindex=36;//till 53
                break;
            
            case 2:
                retcount=4;
                startingpoint=52;
                productnumber=2;
                productname=[productnames objectAtIndex:2];
                dosetoadminindex=55;//till 58
                break;
            
            case 3:
                retcount=20;
                startingpoint=56;
                productnumber=3;
                productname=[productnames objectAtIndex:3];
                dosetoadminindex=60;//till 79
                break;
            
            case 4:
                retcount=11;
                startingpoint=76;
                productnumber=4;
                productname=[productnames objectAtIndex:4];
                dosetoadminindex=81;//till 91
                break;
            
            case 5:
                retcount=3;
                NSLog(@"newbie");
                startingpoint=87;
                productnumber=10;//10;
                productname=[productnames objectAtIndex:5];
                dosetoadminindex=93;//till 95
                break;
            
            case 6:
              retcount=2;
                startingpoint=90;
                productnumber=12;//10;
                productname=[productnames objectAtIndex:6];
                dosetoadminindex=97;//and 98
                break;
                
            case 7:
                NSLog(@"its user enter details");
                toadd=YES;
                self.navigationItem.rightBarButtonItem =
                [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addrem)];
                self.navigationItem.rightBarButtonItem.enabled=YES;
                [self loadView];
                break;
        }}
    else  if ([tablenum intValue]==2) {
        
        switch([num intValue])
        {
                
            case 0:
                retcount=17;
                startingpoint=93;
                productnumber=5;
                productname=[productnames objectAtIndex:0];
                dosetoadminindex=102;//till 119
                break;
            
            case 1:
                retcount=3;
                startingpoint=111;
                productnumber=6;
                productname=[productnames objectAtIndex:1];
                dosetoadminindex=121;//till 123
                break;
            
            case 2:
                retcount=3;
                startingpoint=114;
                productnumber=7;
                productname=[productnames objectAtIndex:2];
                dosetoadminindex=125;//till 127
                break;
            
            case 3:
                retcount=14;
                startingpoint=117;
                productnumber=8;
                productname=[productnames objectAtIndex:3];
                dosetoadminindex=129;//till 142
                break;
            
            case 4:
                retcount=3;
                startingpoint=131;
                productnumber=9;
                productname=[productnames objectAtIndex:4];
                dosetoadminindex=144;//till 146
                break;
            
            case 5:
                retcount=3;
                NSLog(@"newbie2");
                startingpoint=134;
                productnumber=11;//10;
                productname=[productnames objectAtIndex:5];
                dosetoadminindex=148;//till 150
                break;
    
            case 6:
                retcount=2;
                startingpoint=137;
                productnumber=13;//10;
                productname=[productnames objectAtIndex:6];
                dosetoadminindex=152;//and 153
                break;

            case 7:
                NSLog(@"its user enter details");
                toadd=YES;
                self.navigationItem.rightBarButtonItem =
                [[UIBarButtonItem alloc]initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addrem)];
                self.navigationItem.rightBarButtonItem.enabled=YES;
                [self loadView];
                break;
        }
        
    }
    if(!toadd)
    {
    //  doseposition=retcount+startingpoint;
    NSLog(@"retcount is %i %i %i",retcount,dosetoadminindex,startingpoint);
    NSMutableArray *testarray=[[NSMutableArray alloc]init];
    NSMutableArray *manuarray=[[NSMutableArray alloc]init];
    for(int i=startingpoint;i<startingpoint+retcount;i++)
    {
        [testarray addObject:[[appDelegate producttable]objectAtIndex:i]];
        [manuarray addObject:[[appDelegate manufacturearray]objectAtIndex:i]];
    }
    displayarray=[NSMutableArray arrayWithArray:testarray];
    manufacturearray=[NSMutableArray arrayWithArray:manuarray];
    NSLog(@"display array %@ manu array %@",displayarray,manufacturearray);
    NSString *boolee=@"No";
    for(int i=0;i<[displayarray count];i++)
    {
        [indexarray addObject:boolee];
    }
    }
   else
   {
       NSManagedObjectContext *context = [self managedObjectContext];
       context = [appDelegate managedObjectContext];
       
       
       NSPredicate *predicate = [NSPredicate predicateWithFormat:@"petProfileID==%@",[NSNumber numberWithInt:profileidint]];
       NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
       NSEntityDescription *entity = [NSEntityDescription entityForName:@"Additional"
                                                 inManagedObjectContext:context];
       [fetchRequest setEntity:entity];
       [fetchRequest setPredicate:predicate];
       NSError *error = nil;
       fetchedadditions = [context executeFetchRequest:fetchRequest error:&error];
       additionalproducts=[[NSMutableArray alloc]init];
       for (Additional *getdetails in fetchedadditions) {
           NSLog(@"got something here");
           [additionalproducts addObject:getdetails.productname];
       }
       NSLog(@"additional products is %@",additionalproducts);
   }
       
}

-(void)selectitem
{
    if(productnumber<12){
    NSString *warningtext;
    if(productnumber<=9)
    {warningtext=[warnings stringForKey:@"Firstwarning"];
    }else if (productnumber==10 || productnumber==11){warningtext=[warnings stringForKey:@"vacciwarning"];}
    UIAlertView *warning1=[[UIAlertView alloc]initWithTitle:@"WARNING" message:warningtext delegate:self cancelButtonTitle:@"ACCEPT" otherButtonTitles: nil];
    warning1.tag=1;
    [warning1 show];
    }
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
    fromselect=@"No";
    NSLog(@"index array is %@",indexarray);
    self.navigationItem.rightBarButtonItem.enabled=NO;
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for (int j=0; j<[indexarray count]; j++)
    {
        if([[indexarray objectAtIndex:j]isEqualToString:@"Yes"])
        {
            [array addObject:[NSString stringWithFormat:@"%i",j]];
            Pet *savedetails = [NSEntityDescription
                                insertNewObjectForEntityForName:@"Pet"
                                inManagedObjectContext:context];
            savedetails.petprofileID=[NSNumber numberWithInt:profileidint];
            savedetails.productID=[NSNumber numberWithInt:productnumber];
            savedetails.indexnumber=[NSNumber numberWithInt:j];
            savedetails.productname=productname;
            NSError *error;
            
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            NSLog(@"saved");
            [appDelegate saveContext];
        }
    }
    
    
    
    
    listthem=[NSMutableArray arrayWithArray:array];
    
    
    NSLog(@"list them %@ ",listthem);
    
    
    
[self getthearraytobedisplayed];
    [detailtable reloadData];
    //[self loadView];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==1)
    {
        if(productnumber<10){
        if (buttonIndex == 0) {UIAlertView *warning2=[[UIAlertView alloc]initWithTitle:@"WARNING" message:[warnings stringForKey:[NSString stringWithFormat:@"%@2",productname]] delegate:nil cancelButtonTitle:@"ACCEPT" otherButtonTitles: nil];
            [warning2 show];}}
    }
}



-(void)addrem
{
[self performSegueWithIdentifier:@"addreminder" sender:nil];
}

-(void)getthearraytobedisplayed
{
    [namearray removeAllObjects];
    [manufarray removeAllObjects];
    
    
    for (int i=0;i<[displayarray count];i++)
    {
        for(int j=0;j<[listthem count];j++)
        {
            if(i==[[listthem objectAtIndex:j]intValue])
            {
                [namearray addObject:[displayarray objectAtIndex:i]];
                [manufarray addObject:[manufacturearray objectAtIndex:i]];
            }
        }
    }
    
    [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    self.navigationItem.rightBarButtonItem.enabled=YES;
    [self.navigationItem.rightBarButtonItem setAction:@selector(edit)];
}


-(void)edit
{
    NSLog(@"started editing");
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productID == %@ && petprofileID==%@",[NSNumber numberWithInt:productnumber],[NSNumber numberWithInt:profileidint]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pet"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (Pet *getdetails in fetchedObjects) {
        [context deleteObject:getdetails];
    }
    fromselect=nil;
    listthem=nil;
    [self getarray];
   
[self initialsetup];
     [detailtable reloadData];
    // [self viewDidLoad];
//[self loadView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(toadd)
    {return [additionalproducts count];}
    else
    if([fromselect isEqualToString:@"Yes"])
    {
        [self getarray];
        return retcount;
    }
    
    else
        return [namearray count];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{  return 1;}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITextView *header=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, headerline.length)];
    header.backgroundColor=[UIColor blueColor];
    header.font=[UIFont boldSystemFontOfSize:18];
    header.textColor=[UIColor whiteColor];
    header.editable=NO;
    header.text=headerline;
    NSLog(@"header %@",header.text);
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int height;
    if([fromselect isEqualToString:@"Yes"])
        height= 44;
    else
        height=60;
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UILabel *footerlabel=[[UILabel alloc]init];
    if(toadd){
        footerlabel.font=[UIFont fontWithName:@"Corbert-Bold" size:17.0];
        if([additionalproducts count]==0)
        {
            footerlabel.text=@"              No product is added yet";
        }
        else
        {
            footerlabel.text=@"";
        }}
    return footerlabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UILabel *detailted;
    MarqueeLabel *tapToScrollLabel;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        tapToScrollLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width-20, 27) rate:30.0f andFadeLength:10.0f];
        tapToScrollLabel.marqueeType = MLContinuous;
        tapToScrollLabel.continuousMarqueeSeparator = @"     |";
        tapToScrollLabel.animationCurve = UIViewAnimationOptionCurveLinear;
        tapToScrollLabel.numberOfLines = 1;
        tapToScrollLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        tapToScrollLabel.textAlignment = NSTextAlignmentLeft;
        tapToScrollLabel.textColor = [UIColor blackColor];
        tapToScrollLabel.backgroundColor = [UIColor clearColor];
        tapToScrollLabel.font =[ UIFont fontWithName: @"Helvetica" size: 17.0];
        tapToScrollLabel.opaque=YES;
        tapToScrollLabel.enabled=NO;
        [tapToScrollLabel setTag:100];
        [cell.contentView addSubview:tapToScrollLabel];
        
        
        detailted = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x+10, cell.contentView.frame.origin.y+27, cell.contentView.frame.size.width-20, 15)];
        detailted.numberOfLines = 1;
        detailted.textAlignment = NSTextAlignmentLeft;
        detailted.textColor = [UIColor grayColor];
        detailted.backgroundColor = [UIColor clearColor];
        detailted.font = [ UIFont fontWithName: @"Helvetica" size: 13.0];
        [detailted setTag:200];
        [cell.contentView addSubview:detailted];
        if(!toadd){
        if([fromselect isEqualToString:@"No"])
        { cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if
            ([fromselect isEqualToString:@"Yes"])
        { cell.accessoryType=UITableViewCellAccessoryNone;}}
        else if(toadd)
        {cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;}
        
    }
    if(!toadd){
    if
        ([fromselect isEqualToString:@"Yes"]){
            if([[indexarray objectAtIndex:indexPath.row] isEqualToString:@"Yes"])
            {cell.accessoryType = UITableViewCellAccessoryCheckmark;}
            else if([[indexarray objectAtIndex:indexPath.row] isEqualToString:@"No"])
            {cell.accessoryType = UITableViewCellAccessoryNone;}
        }}
    
    tapToScrollLabel = (MarqueeLabel *) [cell viewWithTag:100];
    detailted= (UILabel *) [cell viewWithTag:200];
    if(toadd)
    {if([additionalproducts count]==0)
    {
        tapToScrollLabel.text=@"No Additional products added yet";
        cell.accessoryType=UITableViewCellAccessoryNone;}
        else{tapToScrollLabel.text=[additionalproducts objectAtIndex:indexPath.row];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }}
    else{
    tapToScrollLabel.text=[namearray objectAtIndex:indexPath.row];
    detailted.text=[manufarray objectAtIndex:indexPath.row];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (toadd) {
        
    }
    else{
    NSString *boolee=@"Yes";
    NSString *boolee2=@"No";
    int count=0;
    selectedindexarray=[[NSMutableArray alloc]init];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if([fromselect isEqualToString:@"Yes"])
    {
        if([indexarray objectAtIndex:indexPath.row]){
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
                
                // [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
                
                // [indexarray removeObjectAtIndex:[NSString stringWithFormat:@"%i",indexPath.row]];
                [indexarray replaceObjectAtIndex:indexPath.row withObject:boolee2];
                [selectedindexarray addObject:[NSString stringWithFormat:@"%i",indexPath.row]];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                count--;
                //   [indexarray addObject:[NSString stringWithFormat:@"%i",indexPath.row]];
                
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [indexarray replaceObjectAtIndex:indexPath.row withObject:boolee];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                count++;
            }
        }
        if (count>0) {
            self.navigationItem.rightBarButtonItem.enabled=YES;
        }
        else
        {
            self.navigationItem.rightBarButtonItem.enabled=NO;
        }
    }
    else if([fromselect isEqualToString:@"No"])
    {
        NSLog(@"index are now %@ selected index %@",indexarray,selectedindexarray);
        NSLog(@"indexpath here is %d",indexPath.row);
        doseposition=indexPath.row;
        headerfordosage=[[NSString alloc]init];
        headerfordosage=[namearray objectAtIndex:indexPath.row];
        
        productnumber=dosetoadminindex+[[listthem objectAtIndex:indexPath.row]intValue];
        //  productnumber=productnumber+startingpoint+indexPath.row+1;
        NSLog(@"productnumber %i and product %@ and header %@",productnumber,[namearray objectAtIndex:indexPath.row],headerfordosage);
        [self performSegueWithIdentifier:@"dosage" sender:nil];
        
    }}
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if([[segue identifier]isEqualToString:@"addreminder"])
    {
        additionalreminderViewController *add=[[additionalreminderViewController alloc]init];
        add=segue.destinationViewController;
        add.profileID=profileid;
    }
  else{
    showDosageViewController *show=[[showDosageViewController alloc]init];
    show=segue.destinationViewController;
    show.producttoshow=[NSString stringWithFormat:@"%i",productnumber];
    show.dosetoshow=[NSString stringWithFormat:@"%i",doseposition+startingpoint];
    show.speciesofpet=speciesofpet;
    show.petname=petname;
    show.user=user;
    show.headerhere=headerfordosage;
    show.profileID=profileid;
    show.productcatid=productcatid;
  }
}

@end
