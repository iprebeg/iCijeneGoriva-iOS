//
//  ObjectLoader.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectParser.h"

@protocol ObjectLoaderProtocol <NSObject>

- (void) didLoadObjects:(NSArray*)objects;
- (void) failedToLoadObjects:(NSError*)error;

@end

@interface ObjectLoader : NSObject<NSURLConnectionDelegate, ObjectParserProtocol>
{
    NSMutableData *_receivedData;
    NSObject<ObjectLoaderProtocol> *_loaderDelegate;
    ObjectParser *_parser;
}

- (void) loadObjectsFromUrl:(NSString*)url forDelegate:(NSObject<ObjectLoaderProtocol>*)loaderDelegate;

@end
