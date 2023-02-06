//
//  share.m
//  test
//
//  Created by student3 on 2022/9/27.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "share.h"

@interface share ()

@end

@implementation share

-(id)init {
    if(self = [super init]) {
        self->_datalist = [[NSMutableArray alloc] init];
    }
    return self;
}
+(instancetype)sharedInstance {
    static share *myInstance = nil;
    if(myInstance == nil) {
        myInstance = [[share alloc]init];
    }
    return myInstance;
}

@end
