//
//  share.h
//  test
//
//  Created by student3 on 2022/9/27.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#ifndef share_h
#define share_h

#import <UIKit/UIKit.h>

@interface share : NSObject

@property(nonatomic, strong)NSMutableArray *datalist;
+(instancetype)sharedInstance;

@end
#endif /* share_h */
