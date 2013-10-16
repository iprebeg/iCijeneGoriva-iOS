//
//  SettingsViewController.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 9/22/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController

@synthesize kategorije;
@synthesize distributeri;
@synthesize ostalo;
@synthesize settingsLoader;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        settingsLoader = [[SettingsLoader alloc] init];
        distributeri = [settingsLoader getAllDistributeri];
        kategorije = [settingsLoader getAllKategorije];
        ostalo = [settingsLoader getAllOstalo];
    }
    return self;
}

- (void) viewDidLoad
{
    //self.tableView.backgroundColor = [UIColor IP_DARK];
    UIView *bgView = [[UIView alloc] initWithFrame:self.tableView.frame];
    bgView.backgroundColor = [UIColor IP_DARK];
    self.tableView.backgroundView = bgView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeader = nil;
    
    if (section == 0)
        sectionHeader = @"Goriva";
    else if (section == 1)
        sectionHeader = @"Distributeri";
    else if (section == 2)
        sectionHeader = @"Ostalo";
    
    return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return [kategorije count];
    }
    else if (section == 1)
    {
        return [distributeri count];
    }
    else if (section == 2)
    {
        return [ostalo count];
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSString *key = nil;
    BOOL value = false;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
	static NSString *CellIdentifier = @"CellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
    [cell setSelectionStyle:UITableViewCellEditingStyleNone];
    [cell setBackgroundColor:[UIColor IP_LIGHT]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    
    if (section == 0)
    {
        key = [[kategorije allKeys] objectAtIndex:row];
        value = [[kategorije objectForKey:key] boolValue];
    }
    else if (section == 1)
    {
        key = [[distributeri allKeys] objectAtIndex:row];
        value = [[distributeri objectForKey:key] boolValue];
    }
    else if (section == 2)
    {
        key = [[ostalo allKeys] objectAtIndex:row];
        value = [[ostalo objectForKey:key] boolValue];
    }
    
	cell.textLabel.text = key;
    
    if (value)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
	return cell;
}

- (BOOL) canDisableAnotherFieldInDict:(NSMutableDictionary*)dict
{
    NSInteger count = [self countEnabledFieldsInDict:dict];
    if (dict == kategorije)
    {
        if (count > 1)
            return true;
        else
            return false;
    }
    else if (dict == distributeri)
    {
        if (count > 1)
            return true;
        else
            return false;
    }
    
    return false;
    
}

- (NSInteger) countEnabledFieldsInDict:(NSMutableDictionary*)dict
{
    NSInteger count = 0;
 
    for (NSString *key in [dict allKeys])
    {
        if ([[dict objectForKey:key] boolValue])
            count++;
    }
    
    return count;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *key = nil;
    BOOL value = false;
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0)
    {
        key = [[kategorije allKeys] objectAtIndex:row];
        value = [[kategorije objectForKey:key] boolValue];
    }
    else if (section == 1)
    {
        key = [[distributeri allKeys] objectAtIndex:row];
        value = [[distributeri objectForKey:key] boolValue];
    }
    else if (section == 2)
    {
        key = [[ostalo allKeys] objectAtIndex:row];
        value = [[ostalo objectForKey:key] boolValue];
    }
    
    BOOL disabling = value;
    value = !value;
    
    if (section == 0)
    {
        if (disabling && ![self canDisableAnotherFieldInDict:kategorije])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"UPOZORENJE!" message:@"Nije moguće isključiti sve kategorije!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
            [alert show];
            return;
        }
        else
        {
            [kategorije setObject:[NSNumber numberWithBool:value] forKey:key];
        }
    }
    else if (section == 1)
    {
        if (disabling && ![self canDisableAnotherFieldInDict:distributeri])
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"UPOZORENJE!" message:@"Nije moguće isključiti sve distributere!" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
            [alert show];
            return;
        }
        else
        {
            [distributeri setObject:[NSNumber numberWithBool:value] forKey:key];
        }
    }
    else if (section == 2)
    {
        [ostalo setObject:[NSNumber numberWithBool:value] forKey:key];
    }
    
    [self saveConf];
    
    NSArray *idxPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:idxPaths withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void) saveConf
{
    [settingsLoader saveConfWithDistributeri:distributeri kategorije:kategorije ostalo:ostalo];
}


@end
