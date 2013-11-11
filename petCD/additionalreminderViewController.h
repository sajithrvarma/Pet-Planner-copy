//
//  additionalreminderViewController.h
//  Pet Planner
//
//  Created by Vinila Vijayakumar on 19/07/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+custom.h"
#import <CoreData/CoreData.h>
#import "FBCDAppDelegate.h"

@interface additionalreminderViewController : UIViewController<UITextFieldDelegate>
{
FBCDAppDelegate *appDelegate;
}

@property(nonatomic,strong)IBOutlet UIImageView *petimage;
@property(nonatomic,strong)IBOutlet UITextField *petname,*productname,*manufname,*amountdosage,*frequencydosge;
@property(nonatomic,strong) NSString *profileID;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
