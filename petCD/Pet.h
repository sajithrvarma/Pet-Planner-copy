//
//  Pet.h
//  petCD
//
//  Created by Vinila Vijayakumar on 17/05/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PetProfile.h"

@class PetProfile;

@interface Pet : PetProfile

@property (nonatomic, retain) NSNumber * catID;
@property (nonatomic, retain) NSNumber * indexnumber;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSNumber * petprofileID;
@property (nonatomic, retain) NSNumber * productID;
@property (nonatomic, retain) NSString * productname;
@property (nonatomic, retain) NSString * reminderFrequency;
@property (nonatomic, retain) PetProfile *details;

@end
