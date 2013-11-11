//
//  firstpageViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface firstpageViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *namearray;
    NSString *name;
    
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,retain) IBOutlet UIButton *create, *signin, *createprofile,*viewprofile;
@property(nonatomic,retain) IBOutlet UILabel *label;
@property(nonatomic,retain) IBOutlet UITextField *username;
@property(nonatomic,retain) IBOutlet UIImageView *background;
@property (nonatomic,retain) IBOutlet UIView *myview;
@end
