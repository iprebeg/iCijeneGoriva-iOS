//
//  ObjectParser.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "ObjectParser.h"

@implementation ObjectParser

- (BOOL)checkForSubstring:(NSString*)substring inString:(NSString*)string
{
    return [string rangeOfString:substring].location == NSNotFound ? NO : YES;
}

- (void) parse:(NSData*)xml forDelegate:(NSObject<ObjectParserProtocol>*)parserDelegate
{
    _parserDelegate = parserDelegate;
    
    NSString *xmlStr = [[NSString alloc]initWithData:xml encoding:NSUTF8StringEncoding];

    //NSLog(xmlStr);
    
    if ([self checkForSubstring:@"<h1>Software error:</h1>" inString:xmlStr])
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Pogreška pri procesiranju zahtjeva na poslužitelju!", NSLocalizedDescriptionKey, nil];
        NSError *error = [[NSError alloc] initWithDomain:@"any" code:-1 userInfo:dict];
        [_parserDelegate failedToParseObjects:error];
        return;
    }
    
    if (goriva != nil)
        [goriva removeAllObjects];
    
    NSXMLParser *xmlParser =  [[NSXMLParser alloc] initWithData:xml];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ( [elementName isEqualToString:@"cjenik"]) {
        if (!goriva)
            goriva = [[NSMutableArray alloc] init];
        return;
    }
    
    if ( [elementName isEqualToString:@"gorivo"] ) {
        currentGorivo = [[Gorivo alloc] init];
        return;
    }
    
    if ([elementName isEqualToString:@"distributer"] ||
        [elementName isEqualToString:@"kategorija"] ||
        [elementName isEqualToString:@"naziv"] ||
        [elementName isEqualToString:@"cijena"] ||
        [elementName isEqualToString:@"datum"] ||
        [elementName isEqualToString:@"autocesta"] ) {
        currentStringValue = [[NSMutableString alloc] init];
        return;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([elementName isEqualToString:@"cjenik"]) {
        [_parserDelegate didParseObjects:goriva];
        //NSLog(@"%s %d", __func__,   [goriva count]);
        return;
    }

    if ( [elementName isEqualToString:@"gorivo"] ) {
        [goriva addObject:currentGorivo];
        return;
    }
    
    if ([elementName isEqualToString:@"distributer"])  {
        [currentGorivo setDistributer:currentStringValue];
        return;
    }
    
    if ([elementName isEqualToString:@"kategorija"])  {
        [currentGorivo setKategorija:currentStringValue];
        return;
    }
    
    if ([elementName isEqualToString:@"naziv"])  {
        [currentGorivo setNaziv:currentStringValue];
        return;
    }
    
    if ([elementName isEqualToString:@"cijena"])  {
        [currentGorivo setCijena:currentStringValue];
        return;
    }
    
    if ([elementName isEqualToString:@"datum"])  {
        [currentGorivo setDatum:currentStringValue];
        return;
    }
    
    if ([elementName isEqualToString:@"autocesta"])  {
        if ([currentStringValue isEqualToString:@"YES"])
            [currentGorivo setAutocesta:YES];
        else
            [currentGorivo setAutocesta:NO];
        return;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentStringValue) {
        currentStringValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentStringValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [_parserDelegate failedToParseObjects:parseError];
}

@end
