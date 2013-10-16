//
//  SettingsLoader.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsLoader : NSObject
{
    NSMutableDictionary *distributeri;
    NSMutableDictionary *kategorije;
    NSMutableDictionary *ostalo;
}

- (NSMutableDictionary*) getAllDistributeri;
- (NSMutableDictionary*) getAllKategorije;
- (NSMutableDictionary*) getAllOstalo;

- (NSArray*) getDistributeri;
- (NSArray*) getKategorije;
- (NSDictionary*) getOstalo;

- (void) saveConfWithDistributeri:(NSDictionary*)theDistributeri kategorije:(NSDictionary*)theKategorije ostalo:(NSDictionary*)theOstalo;
 
@end
