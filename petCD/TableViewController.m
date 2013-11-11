//
//  TableViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 06/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "TableViewController.h"
#import "PetProfile.h"
#import "additionalreminderViewController.h"


@interface TableViewController ()

@end

@implementation TableViewController

@synthesize titleArray,table,speciesofpet,dogname,user,profileid;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
 self.navigationItem.rightBarButtonItem=nil;

}- (void)viewDidLoad
{
    [super viewDidLoad];
   
    appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication] delegate];

    table.delegate=self;
    table.dataSource=self;
    
    NSLog(@"speciesofpet is %@",speciesofpet);
  if([speciesofpet isEqualToString:@"Dog"])
  { tablenumber=1;}
    else
    {
    tablenumber=2;
    }
    
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

}




-(NSMutableArray *)readTitleFromCSV:(NSString*)path AtColumn:(int)column
{
    titleArray=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@"\n"];
    
    
    int k=0;
    for (id string in linesArray)
        if(k<[linesArray count]-1){
            
            NSString *lineString=[linesArray objectAtIndex:k];
            NSArray *columnArray=[lineString componentsSeparatedByString:@","];
            [titleArray addObject:[columnArray objectAtIndex:column]];
            k++;
            
        }
    
    NSLog(@"titlearray %@",titleArray);
    return titleArray;
    
}




#pragma mark - Table View

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
 {
 return [[self.fetchedResultsController sections] count];
 }*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[appDelegate dogarray] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITextView *header=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    header.backgroundColor=[UIColor blueColor];
    header.font=[UIFont boldSystemFontOfSize:20];
    header.textColor=[UIColor whiteColor];
    header.editable=NO;
    if(tablenumber==1)
    {
    header.text=@"          Pet Planner For Dogs";
    }
    else
        header.text=@"          Pet Planner For Cats";
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
    }
   if(indexPath.row==0 || indexPath.row>4)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font=[ UIFont fontWithName: @"Helvetica" size: 17.0];
   if (tablenumber==1)
    {
        
        cell.textLabel.text=[[appDelegate dogarray] objectAtIndex:indexPath.row];
                     
    }
      else if(tablenumber==2)
    {
                
        cell.textLabel.text=[[appDelegate catarray] objectAtIndex:indexPath.row];
       
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ||  indexPath.row>4)
    {
    stringtodetail=[NSString stringWithFormat:@"%i",indexPath.row];
    NSLog(@"table string is %@ %i",stringtodetail,indexPath.row);
    [self performSegueWithIdentifier:@"Detail" sender:nil];
    }
   }

-(void)fromcontinue
{
    NSUserDefaults *numsave=[NSUserDefaults standardUserDefaults];
    if([numsave integerForKey:@"num"])
    {
        NSLog(@"got here %i",[numsave integerForKey:@"num"]);
        stringtodetail=[NSString stringWithFormat:@"%i",[numsave integerForKey:@"num"]];
        [numsave removeObjectForKey:@"num"];
        [self performSegueWithIdentifier:@"Detail" sender:nil];    }

}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        
    NSLog(@"called prepare for segue");
    FBCDDetailViewController *give=[[FBCDDetailViewController alloc]init];
    if ([[segue identifier] isEqualToString:@"Detail"])
    {
        give=[segue destinationViewController];
        give.num=stringtodetail;
        give.tablenum=[NSString stringWithFormat:@"%d",tablenumber];
        give.speciesofpet=speciesofpet;
        give.petname=dogname;
        give.user=user;
        give.profileid=profileid;
        NSLog(@"give.num=%@, %@",give.num,give.tablenum);
    }
    
}

@end
