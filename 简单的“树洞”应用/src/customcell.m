//
//  customcell.m
//  treehole
//
//  Created by student3 on 2022/10/26.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customcell.h"
@interface customcell ()


@end
@implementation customcell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setLabel];
    }
    return self;
}
- (void)setLabel {
    _commont = [[UILabel alloc] initWithFrame:CGRectMake(2*self.frame.size.width/3, 5, 100, self.frame.size.height/3 + 5)];
    _commont.text = @"None";
}
- (void)setImg:(UIImage*)img {
    _pic = [[UIImageView alloc]initWithImage:img];
    _pic.frame = CGRectMake(self.frame.size.width/6, 5, 2*self.frame.size.width/3, 2*self.frame.size.width/3);
}
@end
