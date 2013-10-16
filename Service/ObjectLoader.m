//
//  ObjectLoader.m
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import "ObjectLoader.h"

@implementation ObjectLoader

- (id) init
{
    self = [super init];
    if (self) {
        _parser = [[ObjectParser alloc] init];
    }
    return self;
}

- (void) loadObjectsFromUrl:(NSString*)url forDelegate:(NSObject<ObjectLoaderProtocol>*)loaderDelegate
{
    _loaderDelegate = loaderDelegate;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:45.0];
	NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
	if (con) {
		_receivedData = [[NSMutableData alloc] init];
	} else {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"Konekcija nije uspjela!", NSLocalizedDescriptionKey, nil];
        NSError *error = [[NSError alloc] initWithDomain:@"any" code:-1 userInfo:dict];
		[_loaderDelegate failedToLoadObjects:error];
	}

}

#pragma NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"%s", __func__);
	[_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"%s", __func__);
	[_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"%s", __func__);
    [_loaderDelegate failedToLoadObjects:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"%s", __func__);
    [_parser parse:_receivedData forDelegate:self];
}

#pragma ObjectParser delegates

- (void) didParseObjects:(NSArray *)objects
{
    //NSLog(@"%s", __func__);
    [_loaderDelegate didLoadObjects:objects];
}

- (void) failedToParseObjects:(NSError *)error
{
    //NSLog(@"%s", __func__);
    [_loaderDelegate failedToLoadObjects:error];
}

@end
