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
#import "PullRefreshTableViewController.h"

@interface GorivaViewController : PullRefreshTableViewController /*UITableViewController*/<ObjectLoaderProtocol>
{
    NSMutableArray *goriva;
    UISegmentedControl *kategorijaControl;
    ObjectLoader *_objectLoader;
    SettingsLoader *_settingsLoader;
}
@end
