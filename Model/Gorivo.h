//
//  Gorivo.h
//  CijeneGoriva
//
//  Created by Ivor Prebeg on 8/18/12.
//  Copyright (c) 2012 Ivor Prebeg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gorivo : NSObject

@property (nonatomic, copy) NSString *distributer;
@property (nonatomic, copy) NSString *kategorija;
@property (nonatomic, copy) NSString *naziv;
@property (nonatomic, copy) NSString *cijena;
@property (nonatomic, copy) NSString *datum;
@property (nonatomic) BOOL autocesta;

@end
