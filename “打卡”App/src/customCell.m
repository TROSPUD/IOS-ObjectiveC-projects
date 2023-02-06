//
//  customCell.m
//  test
//
//  Created by student3 on 2022/10/1.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "customCell.h"
@interface customCell ()

@end
@implementation customCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self setLabel];
    }
    return self;
}
- (void) setlabel1Text:(NSString *)text1
         setlabel2Text:(NSString *)text2
         setlabel3Text:(NSString *)text3 {
    _label1.text = text1;
    _label2.text = text2;
    _label3.text = text3;
}
- (void)setLabel {
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, self.frame.size.height/3 + 5)];
    _label1.text = @"None";
    [self.contentView addSubview:_label1];
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+self.frame.size.height/3, 100, self.frame.size.height/3 + 5)];
    _label2.text = @"None";
    [self.contentView addSubview:_label2];
    _label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 25+2*self.frame.size.height/3, 100, self.frame.size.height/3 + 5)];
    _label3.text = @"None";
    [self.contentView addSubview:_label3];
}

@end
