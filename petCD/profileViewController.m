//
//  profileViewController.m
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "profileViewController.h"
#import "userprofileViewController.h"
#import "PetProfile.h"
#import "FBCDAppDelegate.h"
#import "Pet.h"
#import "UICustomSwitch.h"
#define kOFFSET_FOR_KEYBOARD_iphone 320.0
#define kOFFSET_FOR_KEYBOARD 320.0

@interface profileViewController ()

@end

@implementation profileViewController
@synthesize Dogname,Breed,Dob,weight,imagepick,profilepic,titleArray,user,managedObjectContext,results,imageview,ProfileID,fromedit,microchipnumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
     
    appDelegate = (FBCDAppDelegate *)[[UIApplication sharedApplication]delegate];
    profileIDcount=1;
    NSLog(@"user is %@",user);
    self.Dogname.delegate=self;
    self.Dob.delegate=self;
    self.Breed.delegate=self;
    self.weight.delegate=self;
    self.microchipnumber.delegate=self;
    details=[[NSMutableDictionary alloc]init];
    self.upload.enabled=YES;
    self.upload.hidden=NO;
    self.Dogname.backgroundColor=[UIColor clearColor];
    self.Dob.backgroundColor=[UIColor clearColor];
    self.Breed.backgroundColor=[UIColor clearColor];
    self.weight.backgroundColor=[UIColor clearColor];
    self.microchipnumber.backgroundColor=[UIColor clearColor];
   /* addphoto=[[UIButton alloc]initWithFrame:CGRectMake(50, 150, 83, 50)];
    [addphoto setTitle:@"Add Photo" forState:UIControlEventTouchUpInside];
    [addphoto addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];*/
    [self.view addSubview:addphoto];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backbuttonaction)];

    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    
    species=[UICustomSwitch switchWithLeftText:@"Dog" andRight:@"Cat"];
    
    gender=[UICustomSwitch switchWithLeftText:@"Male" andRight:@"Female"];
           Neutered=[UICustomSwitch switchWithLeftText:@"Yes" andRight:@"No"];
    if ([[UIScreen mainScreen] bounds].size.height==568) {
        species.frame=CGRectMake(20.0f,430.0f,90.0f,28.0f);
        gender.frame=CGRectMake(119.0f,430.0f,90.0f,28.0f);
        Neutered.frame=CGRectMake(222.0f,430.0f,90.0f,28.0f);
    }
    else
    {   species.frame=CGRectMake(20.0f,385.0f,90.0f,28.0f);
        gender.frame=CGRectMake(119.0f,385.0f,90.0f,28.0f);
        Neutered.frame=CGRectMake(222.0f,385.0f,90.0f,28.0f);}
    
    
    [self.mainview addSubview:gender];
    [self.mainview addSubview:Neutered];
    [self.mainview addSubview:species];
    if ([fromedit isEqualToString:@"Yes"]) {
        [self populateedit];
        self.navigationItem.title=@"Edit pet profile";
    }
    else
        self.navigationItem.title=@"Create pet profile";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
    // create custom button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 163, 106, 53);
    doneButton.adjustsImageWhenHighlighted = NO;
    [doneButton setImage:[UIImage imageNamed:@"DoneUp.png"] forState:UIControlStateNormal];
    [doneButton setImage:[UIImage imageNamed:@"DoneDown.png"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    UIView* keyboard;
    for(int i=0; i<[tempWindow.subviews count]; i++) {
        keyboard = [tempWindow.subviews objectAtIndex:i];
        // keyboard view found; add the custom button to it
        if([[keyboard description] hasPrefix:@"UIKeyboard"] == YES)
            [keyboard addSubview:doneButton];
    }
}


- (void)doneButton:(id)sender {
    NSLog(@"Input: %@", weight.text);
    [weight resignFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    fromedit=@"No";
}


-(void)backbuttonaction
{
   
    if([fromedit isEqualToString:@"Yes"])
    {
        UIAlertView *noback=[[UIAlertView alloc]initWithTitle:nil message:@"Please submit the details" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [noback show];
    }
    else
    { [self.navigationController popViewControllerAnimated:YES];}
}

-(void)populateedit
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"PetProfile"
                inManagedObjectContext:context];
    [request setEntity:entity];
    
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"profileID ==%@", ProfileID];
    
    [request setEntity:[NSEntityDescription entityForName:@"PetProfile" inManagedObjectContext:context]];
    [request setPredicate:predicate];
    NSError *error = nil;
    results =[[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
    
    NSLog(@"results from fetchdata%@",results);
    for(PetProfile *petdet in results)
    {
        editedprofile=[petdet.profileID intValue];
        NSLog(@"profileid to edit is %i",editedprofile);
        user=petdet.username;
        Dogname.text=petdet.dogname;
        switchspecies=petdet.species;
        Breed.text=petdet.breed;
        weight.text=petdet.weight;
        petdob=petdet.dob;
        microchipnumber.text=petdet.microchipnum;
       // self.profilepic.image=[UIImage imageWithData:petdet.image];
        [self dobtext:petdob];
        [context deleteObject:petdet];
    }
    
}

-(IBAction)submit:(id)sender
{
    
    if ([gender isOn]==YES) {
        segmentMF=@"Male";
    }
    else{segmentMF=@"Female";}
    if ([Neutered isOn]==YES) {
        segmentYN=@"Yes";
    }
    else{segmentYN=@"No";}
    if ([species isOn]==YES) {
        switchspecies=@"Dog";
    }
    else{switchspecies=@"Cat";}
    int n=0;
    if([switchspecies isEqualToString:@"Dog"])
        n=100;
    else n=12;
    
    if([microchipnumber.text isEqualToString:@""])
    {microchipnumber.text=@"NA";}
    
    if([Dogname.text isEqualToString:@""] || [Breed.text isEqualToString:@""] || [weight.text isEqualToString:@""] || [Dob.text isEqualToString:@""])
    {
        UIAlertView *incomplete=[[UIAlertView alloc]initWithTitle:@"Incomplete Submision" message:@"You have not filled all the required fields. Please fill in the details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [incomplete show];
    }
 
    else if([weight.text intValue]>n)
    { UIAlertView *wrongweight=[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"Your pet's weight cannot be more than %i",n] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [wrongweight show];}

    else if (pic==NO)
    {
        UIAlertView *picture=[[UIAlertView alloc]initWithTitle:nil message:@"Please upload the picture of your pet" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [picture show];
        
    }
        else
        
        {
            
       [[NSNotificationCenter defaultCenter] removeObserver:self];
            UIAlertView *complete=[[UIAlertView alloc]initWithTitle:nil message:@"All the data has been submitted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [complete show];
            
            
            UIImage *myimage=[[UIImage alloc]init];
            myimage=self.imageview.image;
            NSData *data= [NSData dataWithData:UIImagePNGRepresentation(myimage)];
            
            NSArray *keys=[NSArray arrayWithObjects:@"Name",@"Species",@"Breed",@"Weight",@"Date",@"Gender",@"Neutered",@"Microchip", nil];
            NSArray *objects=[NSArray arrayWithObjects:Dogname.text,switchspecies,Breed.text,weight.text,petdob,segmentMF,segmentYN,microchipnumber.text, nil];
            details=[NSDictionary dictionaryWithObjects:objects forKeys:keys];
            NSLog(@"dict is %@",details);
            
            NSUserDefaults *profileID=[NSUserDefaults standardUserDefaults];
                if (![profileID integerForKey:@"profileID"]) {
                [profileID setInteger:profileIDcount forKey:@"profileID"];
                NSLog(@"entered here");
            }else{
                if([fromedit isEqualToString:@"Yes"])
                
                {   profileIDcount=editedprofile;
                   // editedprofile=nil;
                }
                else{
                profileIDcount=[profileID integerForKey:@"profileID"]+1;
                    NSLog(@"temp%i",profileIDcount);}
                [profileID setInteger:profileIDcount forKey:@"profileID"];
            }
            [profileID synchronize];
            ID=[profileID integerForKey:@"profileID"];
            NSLog(@"profileid this time is %i",[profileID integerForKey:@"profileID"]);
            
        
            
            
            /*  id delegate = [[UIApplication sharedApplication] delegate];
             self.managedObjectContext = [delegate managedObjectContext];
             NSManagedObjectContext *context = [self managedObjectContext];
             PetProfile *profiledetails=[NSEntityDescription
             insertNewObjectForEntityForName:@"PetProfile"
             inManagedObjectContext:context];
             
             profiledetails.userName=user;
             profiledetails.dogname=Dogname.text;
             profiledetails.species=Species.text;*/
            
        
            NSManagedObjectContext *context = [self managedObjectContext];
            context = [appDelegate managedObjectContext];
            PetProfile *petprofile = [NSEntityDescription
                                           insertNewObjectForEntityForName:@"PetProfile"
                                           inManagedObjectContext:context];
            petprofile.profileID=[NSNumber numberWithInt:ID];
            [petprofile setValue:user forKeyPath:@"username"];
            [petprofile setValue:Dogname.text forKeyPath:@"dogname"];
            [petprofile setValue:switchspecies forKeyPath:@"species"];
            [petprofile setValue:Breed.text forKeyPath:@"breed"];
            [petprofile setValue:petdob forKeyPath:@"dob"];
            [petprofile setValue:weight.text forKeyPath:@"weight"];
            [petprofile setValue:microchipnumber.text forKey:@"microchipnum"];
            [petprofile setValue:data forKeyPath:@"image"];
            Pet *pettable=[NSEntityDescription insertNewObjectForEntityForName:@"Pet" inManagedObjectContext:context];
            int catid=0;
            if([switchspecies isEqualToString:@"Dog"])
            {catid=1;}
            else if ([switchspecies isEqualToString:@"Cat"])
            {catid=2;}
            pettable.catID=[NSNumber numberWithInt:catid];
            pettable.details=petprofile;
           // petprofile.profile=pettable;
            NSError *error;
            
            if (![context save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            NSLog(@"saved");
            [appDelegate saveContext];
            [self performSegueWithIdentifier:@"table" sender:nil];
            self.Dogname.text=nil;
            self.Dob.text=nil;
            self.Breed.text=nil;
            self.weight.text=nil;
            segmentMF=nil;
            segmentYN=nil;
            switchspecies=nil;
            self.profilepic.image=nil;
            self.microchipnumber.text=nil;
            
            [species setOn:YES];

        }
    [self fetchdata];
    }
-(void)fetchdata
{
   
    NSManagedObjectContext *context = [self managedObjectContext];
    context = [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"PetProfile"
                inManagedObjectContext:context];
    [request setEntity:entity];
    
   // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username LIKE[c] '%@'", user];
    
    [request setEntity:[NSEntityDescription entityForName:@"PetProfile" inManagedObjectContext:context]];
   // [request setPredicate:predicate];
    NSError *error = nil;
    results =[[NSMutableArray alloc]initWithArray:[context executeFetchRequest:request error:&error]];
    
    NSLog(@"results from fetchdata%@",results);
 //   Pet *givedetails;
    for(PetProfile *petdet in results)
    {
        NSLog(@"Profileid is %@",petdet.profileID);
      //  NSSet *detailstogive=petdet.profile;
     //   NSArray *detailsto=[[NSArray alloc]init];
     //   detailsto=[detailstogive allObjects];
       // givedetails=[detailsto objectAtIndex:0];
    }
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




-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Upload your image
    NSLog(@"%@",image);
    profilepic.image=image;
    pic=YES;
    self.upload.enabled=NO;
    self.upload.hidden=YES;
    //[picker dismissModalViewControllerAnimated:NO];
    [[picker presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)upload:(id)sender
{
    self.imagepick = [[UIImagePickerController alloc] init];
    self.imagepick.editing = YES;
    self.imagepick.delegate = self;
    self.imagepick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagepick animated:YES completion:nil];
}

-(IBAction)adddate:(id)sender
{
     [Dob resignFirstResponder];
    dateview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIDatePicker *pickdate;//=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,210,280, 216)];
    UILabel *datelabel;//=[[UILabel alloc]initWithFrame:CGRectMake(dateview.frame.origin.x,195, dateview.frame.size.width, 45)];
    UIButton *closebutton;//=[[UIButton alloc]initWithFrame:CGRectMake(278,205, 33, 32)];
    if ([[UIScreen mainScreen] bounds].size.height==568) {
        pickdate=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,260,280, 216)];
        datelabel=[[UILabel alloc]initWithFrame:CGRectMake(dateview.frame.origin.x,245, dateview.frame.size.width, 45)];
        closebutton=[[UIButton alloc]initWithFrame:CGRectMake(278,255, 33, 32)];
    }
    else
    {
        pickdate=[[UIDatePicker alloc]initWithFrame:CGRectMake(0,210,280, 216)];
        datelabel=[[UILabel alloc]initWithFrame:CGRectMake(dateview.frame.origin.x,195, dateview.frame.size.width, 45)];
        closebutton=[[UIButton alloc]initWithFrame:CGRectMake(278,205, 33, 32)];
    }
    
    pickdate.datePickerMode=UIDatePickerModeDate;
    pickdate.maximumDate=[NSDate date];
    [pickdate addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
   
    [datelabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"datepick_label.png"]]];
        [closebutton addTarget:self action:@selector(closebutton) forControlEvents:UIControlEventTouchUpInside];
    
    [closebutton setImage:[UIImage imageNamed:@"datepick_close.png"] forState:UIControlStateNormal];
    [closebutton setImage:[UIImage imageNamed:@"datepick_close_press.png"] forState:UIControlStateHighlighted];
    [dateview addSubview:pickdate];
    [dateview addSubview:datelabel];
    [dateview addSubview:closebutton];
    [self.view addSubview:dateview];
}

-(void)closebutton
{
    [dateview removeFromSuperview];
}


- (NSDate *)pickerChanged:(id)sender
{
    NSLog(@"value: %@",[sender date]);
    NSDate *selecteddate=[sender date];
    [self dobtext:selecteddate];
    return selecteddate;
}

-(void)dobtext:(NSDate *)Date
{
    NSCalendar *calendar=[NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                                   fromDate:Date];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    petdob = [calendar dateFromComponents:dateComps];
    Dob.text=[NSString stringWithFormat:@"%i-%i-%i",dateComps.day,dateComps.month,dateComps.year];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"table"])
    {
        userprofileViewController *tabledata=[[userprofileViewController alloc]init];
        tabledata = [segue destinationViewController];
        tabledata.arrayfortable=results;
        tabledata.usernameprofile=user;
        NSLog(@"array here sent %@",results);
        
    }
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
