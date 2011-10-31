//
//  HudViewController.h
//  Kngroo
//
//  Created by Aubrey Goodman on 10/30/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface HudViewController : UIViewController <MBProgressHUDDelegate> {
    
    MBProgressHUD* hud;
    
}

@property (retain) MBProgressHUD* hud;

-(void)showHud:(NSString*)aMessage;
-(void)hideHud;

@end
