//
//  ObjectParser.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gorivo.h"

@protocol ObjectParserProtocol <NSObject>

- (void) didParseObjects:(NSArray*)objects;
- (void) failedToParseObjects:(NSError*)error;

@end

@interface ObjectParser : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *goriva;
    Gorivo *currentGorivo;
    NSMutableString *currentStringValue;
    NSObject<ObjectParserProtocol>* _parserDelegate;
}

- (void) parse:(NSData*)xml forDelegate:(NSObject<ObjectParserProtocol>*)parserDelegate;

@end
