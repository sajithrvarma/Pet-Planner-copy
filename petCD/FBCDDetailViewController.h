//
//  FBCDDetailViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 24/01/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "MarqueeLabel.h"
#import <CoreData/CoreData.h>
#import "FBCDAppDelegate.h"

@interface FBCDDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *headerline,*productcatid,*title,*dispheader;
    FBCDAppDelegate *appDelegate;
    NSMutableArray *displayarray,*manufacturearray,*indexfromCD,*list;
    int retcount,startingpoint,productnumber,doseposition,dosetoadminindex;
    NSString *fromselect,*fromconti,*numconti;
    int checkmark,tablenumber,profileidint;
    UIButton *check;
    NSMutableArray *listthem,*namearray,*manufarray,*selectedindexarray,*indexarray,*additionalproducts;
    NSUserDefaults *numsave;
    NSString *productname;
    NSArray *productnames,*fetchedObjects,*fetchedadditions;
    BOOL fromedit,toadd;
    NSUserDefaults *warnings;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain,nonatomic) NSMutableArray *displayarray;
@property (strong, nonatomic) id detailItem;
@property (nonatomic,retain)NSString *num,*tablenum;
@property (nonatomic,retain) IBOutlet UITableView *detailtable;
@property(nonatomic,strong)NSString *speciesofpet,*petname,*user,*profileid,*headerfordosage;

@end
