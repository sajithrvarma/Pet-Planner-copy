//
//  nextstepViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 19/04/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FBCDAppDelegate.h"

@interface nextstepViewController : UIViewController<UIAlertViewDelegate>
{
    NSMutableArray *possiblesteps;
    NSMutableArray *dupliarray,*displayarray;
    NSString *tosearch;
    BOOL novacci;
    FBCDAppDelegate *appDelegate;
}
@property(strong,nonatomic) NSMutableArray *steps;
@property(nonatomic,strong)NSString *speciesofpet,*petname,*user,*profileID;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
