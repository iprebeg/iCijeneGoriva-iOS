//
//  SettingsLoader.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "SettingsLoader.h"

@implementation SettingsLoader

- (id) init {
    self = [super init];
    if (self) {
        [self loadSettings];
    }
    return self;
}

- (void) loadSettings
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath =
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                         NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"Settings.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Settings"
                                                    ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager]
                        contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@", errorDesc);
    }
    
    kategorije = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"kategorije"]];
    distributeri = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"distributeri"]];
    ostalo = [NSMutableDictionary dictionaryWithDictionary:[temp objectForKey:@"ostalo"]];
}

- (NSMutableDictionary*) getAllDistributeri
{
    return distributeri;
}

- (NSMutableDictionary*) getAllKategorije
{
    return kategorije;
}

- (NSDictionary*) getAllOstalo
{
    return ostalo;
}

- (NSArray*) getDistributeri
{
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    for (NSString *k in [distributeri allKeys])
    {
        if ([[distributeri objectForKey:k] boolValue])
        {
            [ar addObject:k];
        }
    }
    
    return ar;
}

- (NSArray*) getKategorije
{
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    for (NSString *k in [kategorije allKeys])
    {
        if ([[kategorije objectForKey:k] boolValue])
        {
            [ar addObject:k];
        }
    }
    
    return ar;
}

- (NSMutableDictionary*) getOstalo
{
    return ostalo;
}

- (void) saveConfWithDistributeri:(NSDictionary*)theDistributeri kategorije:(NSDictionary*)theKategorije ostalo:(NSDictionary*)theOstalo
{
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
    NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Settings.plist"];
     
     
    NSDictionary *plistDict = [NSDictionary
                               dictionaryWithObjects: [NSArray arrayWithObjects:theDistributeri, theKategorije, theOstalo, nil]
                               forKeys:[NSArray arrayWithObjects:@"distributeri", @"kategorije", @"ostalo", nil]];
    
    NSData *plistData = [NSPropertyListSerialization
                         dataFromPropertyList:plistDict
                         format:NSPropertyListXMLFormat_v1_0
                         errorDescription:&error];
    
    if(plistData)
    {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else
    {
        NSLog(@"%@", error);
    }
}


@end
