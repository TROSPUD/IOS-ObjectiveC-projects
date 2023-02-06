//
//  customCell.h
//  test
//
//  Created by student3 on 2022/10/1.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#ifndef customCell_h
#define customCell_h
#import <UIKit/UIKit.h>

@interface customCell : UITableViewCell

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;

- (void) setlabel1Text:(NSString *)text1
         setlabel2Text:(NSString *)text2
         setlabel3Text:(NSString *)text3;
- (void) setLabel;
@end

#endif /* customCell_h */
