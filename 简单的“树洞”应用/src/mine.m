//
//  mine.m
//  treehole
//
//  Created by student3 on 2022/10/25.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mine.h"

/*static NSString *dept = @"";
static NSString *phone = @"";
static NSString *email = @"";*/
@interface mine ()

@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) NSString *dept;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *result;

@end

@implementation mine

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.098f green:0.098f blue:0.439f alpha:1];
    self.title = @"mine";
    NSLog(@"%@",_token);
    //[self getInfo];
    _result = [[NSMutableArray alloc]init];
    NSDictionary *temp1 = [[NSDictionary alloc] init];
    temp1 = @{@"key":@"Department",
             @"value":_dept
    };
    NSLog(@"dict:%@",temp1);
    [_result addObject:temp1];
    NSDictionary *temp2 = [[NSDictionary alloc] init];
    temp2 = @{@"key":@"Email",
             @"value":_email
    };
    NSLog(@"dict:%@",temp2);
    [_result addObject:temp2];
    NSDictionary *temp3 = [[NSDictionary alloc] init];
    temp3 = @{@"key":@"PhoneNumber",
              @"value":_phone
    };
    NSLog(@"dict:%@",temp3);
    [_result addObject:temp3];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 2*self.view.frame.size.height/3) style:UITableViewStylePlain];
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
    _tableView.rowHeight = 45;
    /*_tableView.sectionHeaderHeight = 45;
    _tableView.sectionFooterHeight = 45;*/
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _tableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.view addSubview:_tableView];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    /*cell.layer.cornerRadius = 10;
    cell.backgroundColor = UIColor.whiteColor;*/
    cell.textLabel.text = _result[indexPath.section][@"key"];
    cell.detailTextLabel.text = _result[indexPath.section][@"value"];
    return cell;
}
- (UITableViewCell*)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (void)getInfo{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:(id)self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://172.18.178.57:3000/prod-api/system/user/profile"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:_token forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"Response:%@ %@\n",response,error);
        if(error == nil) {
            NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            if([NSThread isMainThread]) {
                NSLog(@"main");
            }
            else
            {
                NSLog(@"not main");
            }
            NSLog(@"丢");
            NSLog(@"Data=%@",text);
            //转成字典
            NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *data = [dict objectForKey:@"data"];
            self->_usrname = [data objectForKey:@"userName"];
            self->_dept = [[data objectForKey:@"dept"] objectForKey:@"deptName"];
            self->_email = [data objectForKey:@"email"];
            self->_phone = [data objectForKey:@"phonenumber"];
            self->_name = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4+5, self.view.frame.size.height/9+25, 4*self.view.frame.size.width/5, self.view.frame.size.height/9)];
            self->_name.text = self->_usrname;
            self->_name.textColor = [UIColor whiteColor];
            self->_name.font = [UIFont fontWithName:@"Helvetica-Bold" size:60.0];
            [self.view addSubview:self->_name];
        }
    }];
    [dataTask resume];
}



@end
