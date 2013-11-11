//
//  setreminderViewController.h
//  petCD
//
//  Created by Vinila Vijayakumar on 13/05/13.
//  Copyright (c) 2013 Jyothis Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSRadioButtonSetController.h"
@interface setreminderViewController : UIViewController<GSRadioButtonSetControllerDelegate>
@property(nonatomic,strong) NSString *profileid;
@property (nonatomic, strong) GSRadioButtonSetController * radioButtonSetController;
@property (nonatomic, strong) IBOutlet UIButton *minute,*hour,*day,*month,*year;
@end
