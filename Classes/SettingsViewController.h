//
//  SettingsViewController.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 9/22/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsLoader.h"

@interface SettingsViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *ostalo;
@property (nonatomic, strong) NSMutableDictionary *kategorije;
@property (nonatomic, strong) NSMutableDictionary *distributeri;
@property (nonatomic, strong) SettingsLoader *settingsLoader;

@end
