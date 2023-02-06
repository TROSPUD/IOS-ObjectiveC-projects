//
//  mine.m
//  test
//
//  Created by student3 on 2022/9/20.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mine.h"
#import "LogInClicked.h"


@interface mineVC ()

@end

@implementation mineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Mine";
    //设置渐变背景
    [self setBackground];
    //登录按钮
    UIButton *SignIN = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 150, 150)];
    //按钮居中
    SignIN.center = CGPointMake(self.view.center.x, self.view.center.y);
    SignIN.backgroundColor = [UIColor whiteColor];
    [SignIN showsTouchWhenHighlighted];
    SignIN.layer.cornerRadius =  SignIN.layer.frame.size.width/2;
    SignIN.layer.borderColor = [UIColor colorWithRed:28/255.0 green:56/255.0 blue:121/255.0 alpha:1].CGColor;
    [SignIN.layer setBorderWidth:2];
    [SignIN setTitle:@"LogIn" forState:UIControlStateNormal];
    [SignIN setTitleColor:[UIColor colorWithRed:28/255.0 green:56/255.0 blue:121/255.0 alpha:1] forState:UIControlStateNormal];
    [SignIN addTarget:self action:@selector(logInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignIN];
}

- (void) logInBtn:(UIButton *)btn {
    LogInClicked *nextvc = [[LogInClicked alloc] init];
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs removeObjectAtIndex:0];
    [vcs addObject:nextvc];
    [self.navigationController setViewControllers:vcs animated:YES];
}
//生成渐变背景图
- (UIImage *)gradient:(NSArray*) colors {
    CGSize imgSize = self.view.frame.size;
    NSMutableArray *array = [NSMutableArray array];
    for (UIColor *color in colors)
        [array addObject:(id)color.CGColor];
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gra = CGGradientCreateWithColors(colorSpace, (CFArrayRef) array, NULL);
    CGPoint center = CGPointMake(imgSize.width/2, imgSize.height/2);
    CGFloat radius = MAX(imgSize.width/2, imgSize.height/2) * sqrt(2);
    CGContextDrawRadialGradient(context, gra, center, 0, center, radius, 0);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gra);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return img;
}
- (void)setBackground {
    //int c1 = 0x607EAA, c2= 0x1C3879;
    UIColor *c1 = [UIColor lightGrayColor];
    UIColor *c2 = [UIColor whiteColor];
    NSArray* array = @[c1,c2];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self gradient:array]];
}
@end
