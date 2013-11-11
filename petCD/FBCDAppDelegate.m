//
//  FBCDAppDelegate.m
//  petCD
//
//  Created by Vinila Vijayakumar on 24/01/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import "FBCDAppDelegate.h"
#import "firstpageViewController.h"
#import "profileViewController.h"
#import "Pet.h"

@implementation FBCDAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize catarray,categoryarray,dogarray,productarray,headingarray,titleArray,producttable,manufacturearray,extraarray;
@synthesize dosearray,dosearray2,dosearray3,dosearray4,dosetoadmin,extradic,sectionsarray,vaccinationmicrochipping1,vaccinationmicrochipping2,vaccinationmicrochipping3;

-(void)initializeStoryBoardBasedOnScreenSize {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {    // The iOS device = iPhone or iPod Touch
        
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        if (iOSDeviceScreenSize.height == 480)
        {
            UIStoryboard *iPhone35Storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UIViewController *initialViewController = [iPhone35Storyboard instantiateInitialViewController];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController  = initialViewController;
            [self.window makeKeyAndVisible];
            
        }
        
        if (iOSDeviceScreenSize.height == 568)
        {  
            UIStoryboard *iPhone4Storyboard = [UIStoryboard storyboardWithName:@"Storyboard_iphone5" bundle:nil];
            UIViewController *initialViewController = [iPhone4Storyboard instantiateInitialViewController];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController  = initialViewController;
            [self.window makeKeyAndVisible];
        }
        
    }/* else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
        
    {   // The iOS device = iPad
        
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
        
    }*/
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeStoryBoardBasedOnScreenSize];
    profileViewController *controller=[[profileViewController alloc]init];
    controller.managedObjectContext = self.managedObjectContext;
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        NSLog(@"no managed object");
    }
   NSString * csvPath = [[NSBundle mainBundle]pathForResource:@"Pet Planner Spreadsheet - 2" ofType:@"csv"];
    [self readTitleFromCSVcomma:csvPath AtColumn:0];
      return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
 
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)saveContext
{
   
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        NSLog(@"saved in persistant store");
    }
}

#pragma mark - Core Data stack


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"petCD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"petCD.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"cannot store the data in persistant store");
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory


- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


-(void)readTitleFromCSVcomma:(NSString*)path AtColumn:(int)column

{
     categoryarray=[[NSMutableArray alloc]init];
     productarray=[[NSMutableArray alloc]init];
     headingarray=[[NSMutableArray alloc]init];
    
    NSString *fileDataString=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
   
    NSArray *linesArray=[fileDataString componentsSeparatedByString:@",,\n"];
   
    
    int k=0;
        
    for (id string in linesArray)
    {
        if(k<[linesArray count]-1)
        {
            NSString *lineString=[linesArray objectAtIndex:k];
           // lineString = [[lineString componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
          //  doNotWant = [NSCharacterSet characterSetWithCharactersInString:@",,\n"];
          //  lineString = [[lineString componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""]
          //  ;
            
            // doNotWant = [NSCharacterSet characterSetWithCharactersInString:@",,\n"];
            // lineString = [[lineString componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
           
            
            
            if(k==0 || k==120)
                
            {
                [headingarray addObject:lineString];
            }
           
            if(lineString.length>150 && lineString.length!=500)
            {
                [productarray addObject:lineString];
            }
           
            NSString *searchstring=[[NSString alloc]init];
            searchstring=@"Prevention:";
            if ([lineString rangeOfString:searchstring].location != NSNotFound) {
               
               
              /*  NSCharacterSet *illegalCharSet = [[NSCharacterSet characterSetWithCharactersInString:@""""] invertedSet];
                NSString *convertedStr = [[lineString componentsSeparatedByCharactersInSet:illegalCharSet] componentsJoinedByString:@""];*/
                NSString *removepunc=lineString;
               removepunc=[removepunc stringByReplacingOccurrencesOfString:@":\"" withString:@""];
                              
                removepunc=[removepunc stringByReplacingOccurrencesOfString:@"\\" withString:@"\n"];

            //     removepunc=[removepunc stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                [categoryarray addObject:removepunc];
               // categoryarray=[lineString componentsSeparatedByString:@":  "];
                // [singleproduct replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [singleproduct length])];
            }
        }
        
        k++;
    }
      for (int i =0; i<[categoryarray count]; i++) {
     NSString *mString=[categoryarray objectAtIndex:i];
     NSString *newStr = [mString substringWithRange:NSMakeRange(8, [mString length]-8)];
          newStr=[newStr stringByReplacingOccurrencesOfString:@"," withString:@""];
          newStr=[newStr stringByReplacingOccurrencesOfString:@":" withString:@""];
     
     [categoryarray replaceObjectAtIndex:i withObject:newStr];
     
     }
     NSLog(@"product array %i %@",[productarray count],productarray);
   // NSLog(@"category array %i %@",[categoryarray count],categoryarray);
    Productdic=[[NSMutableDictionary alloc]init ];
     extradic=[[NSMutableDictionary alloc]init];
    sectionsarray=[[NSMutableArray alloc]init];
    NSArray *tempry;
    NSMutableArray *temperary;
    int l=0;
   
     for(int j=0;j<[productarray count];j++,l++)
    {
        NSString *singleproduct=[productarray objectAtIndex:j];
       
        if([singleproduct length]>0)
        {
            singleproduct=[singleproduct stringByReplacingOccurrencesOfString:@", " withString:@"|"];
            tempry=[singleproduct componentsSeparatedByString:@","];

        }
        temperary=[[NSMutableArray alloc]initWithArray:tempry];
        for (int i=0;i<[temperary count];i++)
        {
            NSString *string=[[NSString alloc]init];
            string=[temperary objectAtIndex:i];
            string=[string stringByReplacingOccurrencesOfString:@"|" withString:@", "];
            [temperary replaceObjectAtIndex:i withObject:string];
        }
        
        [Productdic setObject:temperary forKey:[NSNumber numberWithInt:l]];
      //  [Productdic setObject:tempry forKey:[NSString stringWithFormat:@"%i",l]];
        
    }////93 94 //95 //97 //98 //100 //148 //149 150 //152 //153 //155
    NSArray *removekeys=[[NSArray alloc]init];
    removekeys=[NSArray arrayWithObjects:[NSNumber numberWithInt:93],[NSNumber numberWithInt:94],[NSNumber numberWithInt:95],[NSNumber numberWithInt:97],[NSNumber numberWithInt:98],[NSNumber numberWithInt:100],[NSNumber numberWithInt:148],[NSNumber numberWithInt:149],[NSNumber numberWithInt:150],[NSNumber numberWithInt:152],[NSNumber numberWithInt:153],[NSNumber numberWithInt:155],nil];
    for(int i =0; i<[removekeys count];i++){
        [extradic setObject:[Productdic objectForKey:[removekeys objectAtIndex:i]] forKey:[NSNumber numberWithInt:i]];
    }
    
  //  NSLog(@"nnnnn %i %@ ppppp %i %@",[Productdic count], Productdic,[extradic count],extradic);
   
    NSArray *catarray1=[[NSArray alloc]init];
    for (int i=0;i<[categoryarray count];i++)
    {
        catarray1=[[categoryarray objectAtIndex:i] componentsSeparatedByString:@": "];
    }
   
    [self CheckArray:categoryarray WithString:@"""Step"""];
      NSLog(@"categoryyyy %@",categoryarray);
    dogarray=[[NSMutableArray alloc]init];
   catarray=[[NSMutableArray alloc]init];
    for(int i=0;i<5;i++)
    {
        [dogarray addObject:[categoryarray objectAtIndex:i]];
    }
    [dogarray addObject:@"Vaccination"];
    [dogarray addObject:@"Microchipping & Desexing"];
     [dogarray addObject:@"Other Health Care Reminders"];
    for(int i=5;i<10;i++)
    {
        [catarray addObject:[categoryarray objectAtIndex:i]];
    }
    [catarray addObject:@"Vaccination"];
    [catarray addObject:@"Microchipping & Desexing"];
    [catarray addObject:@"Other Health Care Reminders"];
    headingsarray=[productarray objectAtIndex:0];
    int i=0;
    while(i<[productarray count])
    {
        if ([[productarray objectAtIndex:i] isEqualToString:headingsarray]) {
            [productarray removeObjectAtIndex:i];
       }
        i++;
   }
      
     
    [self getproductnames];
}

-(void)getproductnames
{
    producttable=[[NSMutableArray alloc]init];
    manufacturearray=[[NSMutableArray alloc]init];
    vaccinationmicrochipping1=[[NSMutableArray alloc]init];
    vaccinationmicrochipping2=[[NSMutableArray alloc]init];
    vaccinationmicrochipping3=[[NSMutableArray alloc]init];
    dosearray=[[NSMutableArray alloc]init];
    dosearray2=[[NSMutableArray alloc]init];
    dosearray3=[[NSMutableArray alloc]init];
    dosearray4=[[NSMutableArray alloc]init];
    for (int t=0;t<[Productdic count]; t++)
    {
        
        NSArray *temp=[Productdic objectForKey:[NSNumber numberWithInt:t]];
        if (![[temp objectAtIndex:0] isEqualToString:@""])
        {
       [producttable addObject:[temp objectAtIndex:0]];
            if([[temp objectAtIndex:1] isEqualToString:@""])
            {
                if([[temp objectAtIndex:5] isEqualToString:@""])
                {
                    [manufacturearray addObject:@"-"];
                    [dosearray addObject:[temp objectAtIndex:2]];
                    [dosearray2 addObject:[temp objectAtIndex:2]];
                    [dosearray3 addObject:[temp objectAtIndex:3]];
                    [dosearray4 addObject:[temp objectAtIndex:4]];
                }
                else{
                    [manufacturearray addObject:@"-"];
                    [dosearray addObject:[temp objectAtIndex:2]];
                    [dosearray2 addObject:[temp objectAtIndex:3]];
                    [dosearray3 addObject:[temp objectAtIndex:4]];
                    [dosearray4 addObject:[temp objectAtIndex:5]];
                }
            }
            else
            { [manufacturearray addObject:[temp objectAtIndex:1]];
              [dosearray addObject:[temp objectAtIndex:2]];
              [dosearray2 addObject:[temp objectAtIndex:3]];
              [dosearray3 addObject:[temp objectAtIndex:4]];
              [dosearray4 addObject:[temp objectAtIndex:5]];
            }
        }
    else
    NSLog(@"dont add");
    }
    for(int j=0;j<[extradic count];j++)
    {
        if(j!=5 && j!=11)
        {
         NSArray *temp=[extradic objectForKey:[NSNumber numberWithInt:j]];
        [vaccinationmicrochipping1 addObject:[temp objectAtIndex:2]];
        [vaccinationmicrochipping2 addObject:[temp objectAtIndex:3]];
        [vaccinationmicrochipping3 addObject:[temp objectAtIndex:4]];
        }
    }
           dosetoadmin =[NSMutableDictionary dictionaryWithDictionary:Productdic];
    NSArray *removekeys=[[NSArray alloc]init];
    removekeys=[NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:54],[NSNumber numberWithInt:154],[NSNumber numberWithInt:35],[NSNumber numberWithInt:99],[NSNumber numberWithInt:80],[NSNumber numberWithInt:143],[NSNumber numberWithInt:147],[NSNumber numberWithInt:120],[NSNumber numberWithInt:92],[NSNumber numberWithInt:124],[NSNumber numberWithInt:101],[NSNumber numberWithInt:151],[NSNumber numberWithInt:96],[NSNumber numberWithInt:128],[NSNumber numberWithInt:59],/*                    [NSNumber numberWithInt:93],[NSNumber numberWithInt:94],[NSNumber numberWithInt:95],[NSNumber numberWithInt:97],[NSNumber numberWithInt:98],[NSNumber numberWithInt:100],[NSNumber numberWithInt:148],[NSNumber numberWithInt:149],[NSNumber numberWithInt:150],[NSNumber numberWithInt:152],[NSNumber numberWithInt:153],[NSNumber numberWithInt:155],*/nil];
    for(int i =0; i<[removekeys count];i++){
        [dosetoadmin removeObjectForKey:[removekeys objectAtIndex:i]];}
    
    [self CheckArray:producttable WithString:@"\"  Reminder Frequency:"];
    [self CheckArray:manufacturearray WithString:@"\"Dose to be Administered:"];
    [self CheckArray:dosearray WithString:@"\"Exclusions:"];
    [self CheckArray:dosearray2 WithString:@"\"Warnings:"];
    [self CheckArray:dosearray3 WithString:@"\"Next Step - Go To:"];
    [self CheckArray:dosearray4 WithString:@"\"Recommendations:"];
    NSLog(@"product names %i %@ product table %i %@ manufacture array %i %@ dosearray %i %@",[dosetoadmin count],dosetoadmin,[producttable count], producttable,[manufacturearray count],manufacturearray,[dosearray count],dosearray);
   
}

-(void)CheckArray:(NSMutableArray *)Array WithString:(NSString *)String
{
    for(int i=0;i<[Array count];i++)
    {
    NSString *check=[Array objectAtIndex:i];
    if ([String rangeOfString:check].location != NSNotFound)
    {
        [Array removeObjectAtIndex:i];
    }
    }
}


@end
