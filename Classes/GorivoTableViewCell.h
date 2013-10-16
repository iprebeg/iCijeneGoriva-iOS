//
//  GorivoTableViewCell.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GorivoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nazivLabel;
@property (nonatomic, strong) UILabel *datumLabel;
@property (nonatomic, strong) UILabel *cijenaLabel;
@property (nonatomic, strong) UIImageView *distributerIcon;
@property (nonatomic, strong) UIImageView *autocestaIcon;

@end
