//
//  mine.h
//  treehole
//
//  Created by student3 on 2022/10/25.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#ifndef mine_h
#define mine_h


#import <UIKit/UIKit.h>

@interface mine : UIViewController

@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *usrname;
- (void)getInfo;

@end
#endif /* mine_h */
