//
//  LogInClicked.m
//  test
//
//  Created by student3 on 2022/9/22.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogInClicked.h"
#import "mine.h"

@interface LogInClicked ()

@end

@implementation LogInClicked

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Mine";
    UIImage *head = [UIImage imageNamed:@"head.JPG"];
    UIImageView *header = [[UIImageView alloc] initWithImage:head];
    header.frame = CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/7, self.view.frame.size.width/3, self.view.frame.size.width/3);
    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = header.layer.frame.size.width/2;
    header.contentMode = UIViewContentModeScaleAspectFit;
    header.backgroundColor = [UIColor whiteColor];
    
    UILabel *details = [[UILabel alloc]init];
    details.frame = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/3, self.view.frame.size.width/2, self.view.frame.size.height/4);
    details.numberOfLines = 5;
    details.text = @" Username\n\n Mail\n\n Tel";
    details.layer.masksToBounds = YES;
    details.font = [UIFont systemFontOfSize:16];
    details.layer.borderColor = [UIColor blackColor].CGColor;
    
    UILabel *about = [[UILabel alloc] init];
    about.frame = CGRectMake(self.view.frame.size.width/7, 7*self.view.frame.size.height/12+20, 200,20);
    about.text = @"About:";
    about.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    
    UILabel *more = [[UILabel alloc] init];
    more.frame = CGRectMake(self.view.frame.size.width/6, 7*self.view.frame.size.height/12+50, 3*self.view.frame.size.width/4, self.view.frame.size.height/4);
    more.layer.borderWidth = 0.5;
    more.numberOfLines = 7;
    more.text = @"  Version\n\n  Private And Cookie\n\n  Clear Cookie\n\n  Synchronization";
    more.layer.masksToBounds = YES;
    more.font = [UIFont systemFontOfSize:16];
    more.layer.borderColor = [UIColor whiteColor].CGColor;
    more.textColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:1];
    
    
    
    [self.view addSubview:header];
    [self.view addSubview:details];
    [self.view addSubview:about];
    [self.view addSubview:more];
    NSLog(@"make it");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
}

- (void)dismiss {
    mineVC *backmine = [[mineVC alloc]init];
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs removeObjectAtIndex:0];
    [vcs addObject:backmine];
    [self.navigationController setViewControllers:vcs animated:YES];
}

@end

