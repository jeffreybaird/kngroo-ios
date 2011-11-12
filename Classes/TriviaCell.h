//
//  TriviaCell.h
//  Kngroo
//
//  Created by Aubrey Goodman on 11/12/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TriviaCell : UITableViewCell {
    
    IBOutlet UILabel* answerText;
    IBOutlet UIImageView* optionImage;
    IBOutlet UIImageView* backgroundImage;
    
}

@property (retain) UILabel* answerText;
@property (retain) UIImageView* optionImage;
@property (retain) UIImageView* backgroundImage;

@end
