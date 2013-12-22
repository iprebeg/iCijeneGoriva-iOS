//
//  InfoViewController.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 9/22/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor IP_DARK];
        
        SettingsLoader *_settingsLoader = [[SettingsLoader alloc] init];
        NSDictionary *dists = [_settingsLoader getAllDistributeri];
        
        NSUInteger index = 0;
        NSUInteger perLine = 3;
        
        CGFloat inset = 20;

        CGFloat verticalInterspace = 25;
        CGFloat horizontalInterspace = 10;
        
        CGFloat columnWidth = ((self.view.frame.size.width - 2*inset) - (perLine - 1)*verticalInterspace) / perLine;
        CGFloat lineHeight = columnWidth;
        
        CGFloat labelHeight = 12;
        CGFloat labelSpace = 5;
                
        for (NSString *dist in [dists allKeys])
        {
            NSUInteger row =  (index / perLine);
            NSUInteger column = index % perLine;
                        
            index++;
            
            CGRect distributerIconRect = CGRectMake(inset + column * (columnWidth + verticalInterspace),
                                                    inset + (row+1) * (lineHeight + labelSpace + labelHeight + horizontalInterspace),
                                                    columnWidth, columnWidth);
            UIImageView *distributerIcon = [[UIImageView alloc] initWithFrame:distributerIconRect];
            distributerIcon.backgroundColor = [UIColor whiteColor];
            distributerIcon.layer.cornerRadius = 5;
            distributerIcon.layer.masksToBounds = YES;
            
            distributerIcon.layer.shadowColor = [UIColor blackColor].CGColor;
            distributerIcon.layer.shadowOpacity = 0.7f;
            distributerIcon.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
            distributerIcon.layer.shadowRadius = 5.0f;
            distributerIcon.layer.masksToBounds = NO;
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:distributerIcon.bounds];
            distributerIcon.layer.shadowPath = path.CGPath;
            
            distributerIcon.image = [UIImage imageNamed:[dist lowercaseString]];
            
            [self.view addSubview:distributerIcon];
            
            UILabel *urlLabel = [[UILabel alloc] initWithFrame:
            CGRectMake(distributerIconRect.origin.x,
                       distributerIconRect.origin.y + distributerIconRect.size.height + labelSpace,
                       distributerIconRect.size.width,
                       labelHeight)];
            
            urlLabel.backgroundColor = [UIColor clearColor];
            urlLabel.textColor = [UIColor darkGrayColor];
            urlLabel.textAlignment = NSTextAlignmentCenter;
            urlLabel.font = [UIFont fontWithName:@"Helvetica" size:7.0f];
            urlLabel.text = [NSString stringWithFormat:@"%@.hr", [dist lowercaseString]];
            if ([[dist lowercaseString] isEqualToString:@"crodux"])
            {
                urlLabel.text = [NSString stringWithFormat:@"%@-derivati.hr", [dist lowercaseString]];
            }
            
            [self.view addSubview:urlLabel];
            
        }
    }
    return self;
}

@end
