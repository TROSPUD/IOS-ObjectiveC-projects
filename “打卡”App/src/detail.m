//
//  detail.m
//  test
//
//  Created by student3 on 2022/9/29.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "detail.h"

@interface details ()


@end

@implementation details



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self information];
    _textview.font = [UIFont systemFontOfSize: 16.0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)information {
    [self.view addSubview:_label1];
    [self.view addSubview:_label2];
    [self.view addSubview:_label3];
    [self.view addSubview:_textview];
    [self.view addSubview:_viewww];
    [self.view addSubview:_v];
}

@end
