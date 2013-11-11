//
//  profileViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 28/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+custom.h"
#import <CoreData/CoreData.h>
#import "UICustomSwitch.h"
#import "FBCDAppDelegate.h"

@interface profileViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    NSString *segmentMF,*segmentYN,*switchspecies;
    UIImage *image;
    UIImagePickerController *imagepick;
    BOOL pic;
    NSMutableDictionary *details;
    NSString *user;
    int profileIDcount;
    int ID;
    UICustomSwitch *gender,*Neutered,*species;
    UITapGestureRecognizer *Taprecognize;
    NSDate *petdob;
    UIView *dateview;
    FBCDAppDelegate *appDelegate;
    UIButton *addphoto;
    int editedprofile;
    
   // NSMutableArray *breednames;
  //  NSMutableArray *breednamescomplete;
   
  //  UITableView *autocomplete;
    
}
@property (nonatomic,retain)IBOutlet UIImageView *imageview;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic,retain) NSString *user,*ProfileID,*fromedit;
@property(nonatomic,retain) IBOutlet UITextField *Dogname,*Breed,*Dob, *weight,*microchipnumber;
@property(nonatomic,retain) IBOutlet UIView *mainview;
@property(nonatomic,retain) UIImagePickerController *imagepick;
@property(nonatomic,retain) IBOutlet UIImageView *profilepic;
@property(nonatomic,retain) NSMutableArray *titleArray;//,*breednames,*breednamescomplete;
@property(nonatomic,retain) NSMutableArray *results;
@property(nonatomic,retain) IBOutlet UIButton *upload;
//@property(nonatomic,retain) UITableView *autocomplete;


-(IBAction)upload:(id)sender;


@end
