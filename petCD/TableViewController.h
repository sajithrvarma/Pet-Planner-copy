//
//  TableViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 06/02/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FBCDAppDelegate.h"
#import "FBCDDetailViewController.h"

@interface TableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *categoryarray;
    NSMutableArray *headingarray;
    NSMutableDictionary *Productdic;
    NSMutableArray *productarray;
    NSMutableArray *catarray;
    NSMutableArray *dogarray;
    int tablenumber;
    NSString *stringtodetail;
    FBCDAppDelegate *appDelegate;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,retain) NSMutableArray *titleArray;
@property (nonatomic,retain) IBOutlet UITableView *table;
@property(nonatomic,strong)NSString *speciesofpet,*dogname,*user,*profileid;

@end
