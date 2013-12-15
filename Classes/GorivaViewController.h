//
//  GorivaViewController.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GorivoTableViewCell.h"
#import "ObjectLoader.h"
#import "SettingsLoader.h"

@interface GorivaViewController : UITableViewController /*UITableViewController*/<ObjectLoaderProtocol>

@property (nonatomic, strong) NSMutableArray *goriva;
@property (nonatomic, strong) UISegmentedControl *kategorijaControl;
@property (nonatomic, strong) ObjectLoader *objectLoader;
@property (nonatomic, strong) SettingsLoader *settingsLoader;
@property (nonatomic, strong) UIRefreshControl *refreshControlView;

@end
