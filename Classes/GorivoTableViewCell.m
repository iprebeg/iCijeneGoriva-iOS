//
//  GorivoTableViewCell.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "GorivoTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation GorivoTableViewCell

@synthesize nazivLabel, datumLabel, cijenaLabel, distributerIcon, autocestaIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat inset = 5;
        
        CGRect nazivRect = CGRectMake(CELL_HEIGHT + inset, inset, self.frame.size.width - CELL_HEIGHT - 3*inset, 20);
        nazivLabel = [[UILabel alloc] initWithFrame:nazivRect];
        nazivLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        nazivLabel.textColor = [UIColor darkGrayColor];
        nazivLabel.backgroundColor = [UIColor redColor];
        nazivLabel.backgroundColor = [UIColor clearColor];
        nazivLabel.numberOfLines = 1;
        nazivLabel.textAlignment = NSTextAlignmentLeft;
        nazivLabel.adjustsFontSizeToFitWidth = YES;
        nazivLabel.minimumScaleFactor = 12.0f;
        [self addSubview:nazivLabel];
        
        CGRect datumRect = CGRectMake(80, CELL_HEIGHT - 30, 100, 20);
        datumLabel = [[UILabel alloc] initWithFrame:datumRect];
        datumLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        datumLabel.backgroundColor = [UIColor yellowColor];
        datumLabel.backgroundColor = [UIColor clearColor];
        datumLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:datumLabel];
        
        //CGRect cijenaRect = CGRectMake(260, CELL_HEIGHT - 30, 50, 20);
        CGRect cijenaRect = CGRectMake(240, CELL_HEIGHT - 30, 70, 30);
        cijenaLabel = [[UILabel alloc] initWithFrame:cijenaRect];
        cijenaLabel.textAlignment = NSTextAlignmentCenter;
        cijenaLabel.backgroundColor = [UIColor darkGrayColor];
        cijenaLabel.backgroundColor = [UIColor clearColor];
        //cijenaLabel.layer.cornerRadius = 5;
        cijenaLabel.font = [UIFont fontWithName:@"DBLCDTempBlack" size:25.0f];
        cijenaLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:cijenaLabel];
        
        CGRect distributerIconRect = CGRectMake(inset, inset, CELL_HEIGHT - 2*inset, CELL_HEIGHT - 2*inset);
        distributerIcon = [[UIImageView alloc] initWithFrame:distributerIconRect];
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
        
        [self addSubview:distributerIcon];
        
        CGRect autocestaIconRect = CGRectMake(35, 33, 25, 25);
        autocestaIcon = [[UIImageView alloc] initWithFrame:autocestaIconRect];
        autocestaIcon.backgroundColor = [UIColor blackColor];
        autocestaIcon.backgroundColor = [UIColor clearColor];
        autocestaIcon.layer.cornerRadius = 5;
        autocestaIcon.layer.masksToBounds = YES;
        autocestaIcon.image = [UIImage imageNamed:@"autocesta"];
        autocestaIcon.hidden = TRUE;
        
        autocestaIcon.layer.shadowColor = [UIColor blackColor].CGColor;
        autocestaIcon.layer.shadowOpacity = 0.4f;
        autocestaIcon.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        autocestaIcon.layer.shadowRadius = 2.0f;
        autocestaIcon.layer.masksToBounds = NO;
        UIBezierPath *path2 = [UIBezierPath bezierPathWithRect:autocestaIcon.bounds];
        autocestaIcon.layer.shadowPath = path2.CGPath;
        
        [self addSubview:autocestaIcon];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
