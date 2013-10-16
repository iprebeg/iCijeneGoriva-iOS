//
//  GorivaViewController.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "GorivaViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface GorivaViewController ()

@end

@implementation GorivaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.view.backgroundColor = [UIColor IP_DARK];
        self.tableView.backgroundColor = [UIColor IP_DARK];
        
        _objectLoader = [[ObjectLoader alloc] init];
        goriva = [[NSMutableArray alloc] init];
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //self.tableView.layer.cornerRadius = 10;
        //self.view.layer.cornerRadius = 10;
        
        [self reloadKategorijaControl];
    }
    return self;
}

- (void) reloadKategorijaControl
{
    _settingsLoader = [[SettingsLoader alloc] init];
    NSArray *items = [_settingsLoader getKategorije];
    
    CGRect kategorijaRect = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    kategorijaControl = [[UISegmentedControl alloc] initWithItems:items];
    kategorijaControl.bounds = kategorijaRect;
    kategorijaControl.segmentedControlStyle = UISegmentedControlStyleBar;
    //kategorijaControl.tintColor = [UIColor grayColor];
    kategorijaControl.backgroundColor = [UIColor clearColor];
    
    //UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    //UIColor *color = [UIColor orangeColor];

    //NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, UITextAttributeFont, color, UITextAttributeTextColor, nil];
    
    //[kategorijaControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [kategorijaControl addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [kategorijaControl setSelectedSegmentIndex:0];
    kategorijaControl.layer.cornerRadius = 0;
    
    
    
    self.tableView.tableHeaderView = kategorijaControl;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self reloadKategorijaControl];
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)action:(id)sender
{
    //[self startLoading];
    //NSLog(@"%s",__func__);
    [self loadData];
}

- (void)refresh {
    [self loadData];
}

- (void) loadData
{
    NSString *url = [self constructUrl];
    [_objectLoader loadObjectsFromUrl:url forDelegate:self];
}

- (NSString*) constructUrl
{
    NSArray *enabledKategorije = [_settingsLoader getKategorije];
    NSArray *enabledDistributeri = [_settingsLoader getDistributeri];
    NSDictionary *ostalo = [_settingsLoader getOstalo];
    
    NSString *kategorija = [enabledKategorije objectAtIndex:kategorijaControl.selectedSegmentIndex];
    kategorija = [kategorija stringByReplacingOccurrencesOfString:@" " withString:@""];
    kategorija = [kategorija stringByReplacingOccurrencesOfString:@"ž" withString:@"z"];
    NSString *kategorijaFilter = [@"?kategorija=" stringByAppendingString:kategorija];
        
    NSString *distributeri = [enabledDistributeri componentsJoinedByString:@","];
    NSString *distributeriFilter = [@"&distributeri=" stringByAppendingString:distributeri];

    NSString *ostaloFilter = @"";
    for (NSString *key in [ostalo allKeys])
    {
        BOOL on = [[ostalo objectForKey:key] boolValue];
        
        NSString *opcija = @"&";
        opcija = [opcija stringByAppendingString:key];
        opcija = [opcija stringByAppendingString:@"="];
        opcija = [opcija stringByAppendingString:(on ? @"DA" : @"NE")];
        ostaloFilter = [ostaloFilter stringByAppendingString:opcija];
    }

    NSString *req = kURLGoriva;
    req = [req stringByAppendingString:kategorijaFilter];
    req = [req stringByAppendingString:distributeriFilter];
    req = [req stringByAppendingString:ostaloFilter];
    
    //NSLog(@"url:%@", req);
    return req;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [goriva count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GorivoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[GorivoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    Gorivo *g = [goriva objectAtIndex:[indexPath row]];

    cell.nazivLabel.text = [g naziv];
    cell.datumLabel.text = [g datum];
    cell.cijenaLabel.text = [g cijena];    
    cell.distributerIcon.image = [UIImage imageNamed:[g.distributer lowercaseString]];
    cell.autocestaIcon.hidden = ![g autocesta];

    UIView *bgView = [[UIView alloc] initWithFrame:cell.frame];
    if ([indexPath row] % 2 == 1) {
        bgView.backgroundColor = [UIColor IP_LIGHT];
    } else {
        bgView.backgroundColor = [UIColor IP_DARK];
    }
    cell.backgroundView = bgView;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

#pragma ObjectLoader delegates

- (void) didLoadObjects:(NSArray *)objects
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
    //NSLog(@"%s %d", __func__, [objects count]);
    [goriva removeAllObjects];
    [goriva addObjectsFromArray:objects];
    [self.tableView reloadData];
}

- (void) failedToLoadObjects:(NSError *)error
{
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.1];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UPOZORENJE!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
