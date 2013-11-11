//
//  PetProfile.h
//  Pet Planner
//
//  Created by Vinila Vijayakumar on 16/07/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pet;

@interface PetProfile : NSManagedObject

@property (nonatomic, retain) NSString * breed;
@property (nonatomic, retain) NSDate * dob;
@property (nonatomic, retain) NSString * dogname;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * profileID;
@property (nonatomic, retain) NSString * species;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * microchipnum;
@property (nonatomic, retain) Pet *profile;

@end
