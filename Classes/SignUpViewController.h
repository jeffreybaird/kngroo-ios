//
//  SignUpViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/1/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudViewController.h"


@interface SignUpViewController : HudViewController <RKObjectLoaderDelegate> {
    
    IBOutlet UITextField* firstName;
    IBOutlet UITextField* lastName;

    NSString* email;
    NSString* password;
    
}

@property (retain) UITextField* firstName;
@property (retain) UITextField* lastName;
@property (retain) NSString* email;
@property (retain) NSString* password;

@end
