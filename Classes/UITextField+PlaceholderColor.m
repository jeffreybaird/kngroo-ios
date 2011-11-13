//
//  UITextField+PlaceholderColor.m
//  Kngroo
//
//  Created by Aubrey Goodman on 11/13/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "UITextField+PlaceholderColor.h"

@implementation UITextField (PlaceholderColor)

- (void)drawPlaceholderInRect:(CGRect)rect 
{
    [[UIColor colorWithWhite:0.9 alpha:1.0] setFill];
    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeClip alignment:self.textAlignment];
}

@end
