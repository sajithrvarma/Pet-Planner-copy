//
//  Additional.h
//  Pet Planner
//
//  Created by Vinila Vijayakumar on 24/07/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Additional : NSManagedObject

@property (nonatomic, retain) NSString * amount;
@property (nonatomic, retain) NSString * dosage;
@property (nonatomic, retain) NSString * manufacturername;
@property (nonatomic, retain) NSNumber * petProfileID;
@property (nonatomic, retain) NSString * productname;

@end
