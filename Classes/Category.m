//
//  Category.m
//  Kngroo
//
//  Created by Aubrey Goodman on 10/27/11.
//  Copyright (c) 2011 Migrant Studios. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize categoryId, title, icon;

+ (void)initObjectLoader
{
    RKObjectMapping* tCategoryMapping = [RKObjectMapping mappingForClass:[Category class]];
    [tCategoryMapping mapKeyPath:@"id" toAttribute:@"categoryId"];
    [tCategoryMapping mapKeyPath:@"title" toAttribute:@"title"];
    [tCategoryMapping mapKeyPath:@"icon" toAttribute:@"icon"];
    
    [[RKObjectManager sharedManager].mappingProvider setMapping:tCategoryMapping forKeyPath:@"category"];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@ - %@",title,icon];
}

@end
