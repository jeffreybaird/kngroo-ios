//
//  MediaGridCell.m
//  RedHawk
//
//  Created by Aubrey Goodman on 10/7/11.
//  Copyright 2011 Red Hawk Interactive, Inc. All rights reserved.
//
//  Derived from:
/*
 * ImageDemoFilledCell.m
 * Classes
 * 
 * Created by Jim Dovey on 18/4/2010.
 * 
 * Copyright (c) 2010 Jim Dovey
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * 
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 
 * Neither the name of the project's author nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "StampCell.h"


@implementation StampCell

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );
    
    _imageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    _title = [[UILabel alloc] initWithFrame: CGRectZero];
    _title.highlightedTextColor = [UIColor whiteColor];
    _title.numberOfLines = 2;
    _title.lineBreakMode = UILineBreakModeWordWrap;
    _title.font = [UIFont boldSystemFontOfSize: 12.0];
    _title.adjustsFontSizeToFitWidth = YES;
    _title.minimumFontSize = 10.0;
    _title.textAlignment = UITextAlignmentLeft;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    _imageView.backgroundColor = self.backgroundColor;
    _title.backgroundColor = self.backgroundColor;
    _title.textColor = [UIColor colorWithWhite:1 alpha:1];
    
    [self.contentView addSubview: _imageView];
    [self.contentView addSubview: _title];
    
    return ( self );
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _reuseIdentifier = @"MediaGridCell";
}

- (void) dealloc
{
    [_imageView release];
    [_title release];
    [super dealloc];
}

- (UIImage *) image
{
    return ( _imageView.image );
}

- (void) setImage: (UIImage *) anImage
{
    _imageView.image = anImage;
    [self setNeedsLayout];
}

- (NSString *) title
{
    return ( _title.text );
}

- (void) setTitle: (NSString *) title
{
    _title.text = title;
    [self setNeedsLayout];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = CGRectInset( self.contentView.bounds, 10.0, 10.0 );
    
    [_imageView sizeToFit];
    CGRect frame = _imageView.frame;
    frame.size.width = bounds.size.width;
    frame.size.height = frame.size.width;
    frame.origin.x = bounds.origin.x;
    frame.origin.y = bounds.origin.y;
    _imageView.frame = frame;

    [_title sizeToFit];
    frame = _title.frame;
    frame.size.width = bounds.size.width;
    frame.size.height = frame.size.height * 2;
    frame.origin.y = _imageView.frame.size.height + 15;
    frame.origin.x = bounds.origin.x;
    _title.frame = frame;
}

@end
