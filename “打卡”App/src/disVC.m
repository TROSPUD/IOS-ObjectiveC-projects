//
//  disVC.m
//  test
//
//  Created by student3 on 2022/9/20.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "disVC.h"
#import "share.h"
#import "detail.h"
#import "customCell.h"

@interface disVC () <UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating>
@property (strong, nonatomic) UILabel *label1;
@property (strong, nonatomic) UILabel *label2;
@property (strong, nonatomic) UILabel *label3;
@property (strong, nonatomic) UITextView *textview;
@property (strong, nonatomic) UIView *viewww;
@property (strong, nonatomic) UIImageView *v;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *search;
@property (nonatomic, strong) NSMutableArray *result;//搜素结果数组

@property (copy, nonatomic) NSMutableArray *ls;
@property (assign, nonatomic) int number;
@property (assign, nonatomic) int count;

@property (strong,nonatomic) UIAlertAction *ok;
@property (strong,nonatomic) UIAlertAction *cancel;

@end

@implementation disVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _count = 0;
    self.title = @"Discover";
    /*if([share sharedInstance].datalist.count == 0) {
        [share sharedInstance].datalist = [@[@{@"date":@"2019/08/30",
                                               @"place":@"America",
                                               @"name":@"Norman Fucking Rockwell",
                                               @"comments":@"Released by Lana Del Rey"
                                               },
                                             @{@"date":@"2017/06/16",
                                               @"place":@"New Zealand",
                                               @"name":@"Melodrama",
                                               @"comments":@"Released by Lorde"
                                               }
        ]mutableCopy];
    }*/
}
- (void)viewWillAppear:(BOOL)animated {
    [self makeTable];
    [self doSearch];
    
}
- (NSMutableArray *)result {
    if(_result == nil) {
        _result = [NSMutableArray arrayWithCapacity:0];
    }
    return _result;
}
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)doSearch {
    self.search = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.search.searchResultsUpdater = self;
    self.search.obscuresBackgroundDuringPresentation = NO;
    [self.search.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.search.searchBar;
}
/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}*/
-(void)makeBackground{
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.colors = @[(__bridge id)[UIColor lightGrayColor].CGColor,(__bridge id)[UIColor whiteColor].CGColor ];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    layer.frame = self.view.bounds;
    [self.view.layer addSublayer:layer];//很重要！！！！如果没有addsubview将会出现背景为上一个tableview的情况
}

- (void)makeTable {
    //按照时间排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"date" ascending:NO];
    [[share sharedInstance].datalist sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    //设置背景渐变
    [self makeBackground];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.search.active)
        return self.result.count;
    return [share sharedInstance].datalist.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    customCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[customCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.numberOfLines = 3;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = UIColor.whiteColor;
    if(self.search.active) {
        [cell setlabel1Text:self.result[indexPath.section][@"date"]
              setlabel2Text:self.result[indexPath.section][@"place"]
              setlabel3Text:self.result[indexPath.section][@"name"]];
    }
    else {
        [cell setlabel1Text:[share sharedInstance].datalist[indexPath.section][@"date"]
              setlabel2Text:[share sharedInstance].datalist[indexPath.section][@"place"]
              setlabel3Text:[share sharedInstance].datalist[indexPath.section][@"name"]];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputstr = searchController.searchBar.text;
    if(self.result.count >0) {
        [self.result removeAllObjects];
    }
    for(NSDictionary *dic in [share sharedInstance].datalist) {
        NSString *temp1 = dic[@"date"];
        NSString *temp2 = dic[@"place"];
        NSString *temp3 = dic[@"name"];
        temp1 = [temp1 stringByAppendingString:temp2];
        temp1 = [temp1 stringByAppendingString:temp3];
        if ([temp1.lowercaseString rangeOfString:inputstr.lowercaseString].location != NSNotFound) {
            [self.result addObject:dic];
        }
    }
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    int screenWidth = screenFrame.size.width;
    int screenheight = screenFrame.size.height;
    details *newpage = [[details alloc]init];
    newpage.label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, screenheight/10, 100, 60)];
    newpage.label1.text = [share sharedInstance].datalist[indexPath.section][@"date"];
    newpage.label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, screenheight/10+30, 100, 60)];
    newpage.label2.text = [share sharedInstance].datalist[indexPath.section][@"place"];
    newpage.label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, screenheight/10+60, 100, 60)];
    newpage.label3.text = [share sharedInstance].datalist[indexPath.section][@"name"];
    newpage.textview = [[UITextView alloc]initWithFrame:CGRectMake(27, screenheight/10+110, screenWidth/6 *5, screenheight/3)];
    [newpage.textview setText:[share sharedInstance].datalist[indexPath.section][@"comment"]];
    newpage.viewww =[[UIView alloc] init];
    NSMutableArray *ma = [share sharedInstance].datalist[indexPath.section][@"image"];
    for(UIImage *img in ma) {
        UIImageView *t = [[UIImageView alloc] initWithFrame:CGRectMake(40+105*(_count%3)-10, screenheight/2, 100, 100)];
        _count++;
        t.image = img;
        [newpage.viewww addSubview:t];
    }
    _count = 0;
    [self Donghua:@"cube" controller:newpage];
    
}

//尝试删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger row = [indexPath section];
        NSLog(@"%ld",row);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
        _ok = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[share sharedInstance].datalist removeObjectAtIndex:row];
            [_tableView reloadData];
        }];
        _cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancl");
        }];
        [alert addAction:_ok];
        [alert addAction:_cancel];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void) Donghua:(NSString *)type
      controller:(details *)view {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = type;
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
