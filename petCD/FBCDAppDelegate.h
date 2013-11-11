//
//  FBCDAppDelegate.h
//  petCD
//
//  Created by Vinila Vijayakumar on 24/01/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBCDAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableDictionary *Productdic;
    NSString *headingsarray;
    NSMutableArray *producttable;
    NSMutableArray *manufacturearray;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,retain) NSMutableArray *productarray,*producttable,*manufacturearray,*dosearray,*dosearray2,*dosearray3,*dosearray4,*headingarray,*catarray,*dogarray,*titleArray,*categoryarray,*extraarray,*sectionsarray,*vaccinationmicrochipping1,*vaccinationmicrochipping2,*vaccinationmicrochipping3;
@property(nonatomic,retain) NSMutableDictionary *dosetoadmin,*extradic;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
