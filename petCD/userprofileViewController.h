//
//  userprofileViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface userprofileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, NSFetchedResultsControllerDelegate>
{
    NSString *usernameprofile,*currentpetname,*species,*petsname,*profileID;
    NSMutableArray *results;
    UIImage *petimage;
    NSMutableArray *dataarray,*IDarray,*agearray;
    NSIndexPath *index;
    int i,editfor;
   
}
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,retain)NSString *usernameprofile;
@property(nonatomic,retain) IBOutlet UILabel *hilabel;
@property(nonatomic,retain) NSMutableArray *arrayfortable;
@property(nonatomic,retain) IBOutlet UITableView *table;
@property(nonatomic,retain) IBOutlet UIImageView *background;




@end
