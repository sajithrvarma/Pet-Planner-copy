//
//  showDosageViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 17/04/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showDosageViewController : UIViewController
{
    int productnumber;
    int dose;
    int weight;
    NSDate* birthday;
}
@property(nonatomic,strong) NSString* producttoshow,*dosetoshow,*headerhere;
@property(nonatomic,strong) IBOutlet UITextView *information,*information2;
@property(nonatomic,strong)NSString *speciesofpet,*petname,*user,*profileID,*productcatid;
@property (nonatomic,strong) IBOutlet UILabel *hwp,*ticks,*flea,*header,*inclusions;
@property (nonatomic,strong)  NSMutableArray *nextsteptogo;
@property(nonatomic,retain) IBOutlet UIImageView *background;
@end
