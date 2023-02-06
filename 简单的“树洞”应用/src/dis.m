//
//  dis.m
//  treehole
//
//  Created by student3 on 2022/10/13.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dis.h"
//#import "customcell.h"
@interface Dis () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UIActivityIndicatorView* indicate;
@property (nonatomic,strong) NSMutableArray *imgarr;
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) NSMutableArray *test;
@property (nonatomic,strong) UIImage* imag1;


@end

@implementation Dis

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.098f green:0.098f blue:0.439f alpha:1];
    self.title = @"Image";
    _name = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/5-5, self.view.frame.size.height/9+25, 4*self.view.frame.size.width/5, self.view.frame.size.height/9)];
    _name.text = @"comment";
    _name.textColor = [UIColor whiteColor];
    _name.font = [UIFont fontWithName:@"Helvetica-Bold" size:60.0];
    [self.view addSubview:_name];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 2*self.view.frame.size.height/3) style:UITableViewStylePlain];
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
    _tableView.rowHeight = 120;
    /*_tableView.sectionHeaderHeight = 45;
    _tableView.sectionFooterHeight = 45;*/
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        _tableView.layoutMargins = UIEdgeInsetsZero;
    }
    [self.view addSubview:_tableView];
    //三个按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Load" style:UIBarButtonItemStyleDone target:self action:@selector(getImag)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleDone target:self action:@selector(clear)];
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
    if (_imgarr.count == 0) {
        cell.imageView.image = _imag1;
        cell.textLabel.text = @"test";
        cell.detailTextLabel.text = @"text";
    }
    else {
        //将图片重设为相同尺寸
        UIImage *im = [UIImage imageWithContentsOfFile:[_imgarr objectAtIndex:indexPath.section]];
        CGSize itemSize = CGSizeMake(110, 110);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
        [im drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.textLabel.text = [[self.dataList objectAtIndex:indexPath.section]objectForKey:@"pinglun"];
        //截取发布时间年月日
        cell.detailTextLabel.text = [[[self.dataList objectAtIndex:indexPath.section]objectForKey:@"time"]substringWithRange:NSMakeRange(0, 10)];}

    return cell;
}

- (UITableViewCell*)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.imgarr.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)getInfo {
    _dataList = [[NSMutableArray alloc]init];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:(id)self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://172.18.178.57:3000/prod-api/yuan/comment/list"];
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
            NSMutableArray *dota = [dict objectForKey:@"data"];
            for(NSInteger i=0;i<=dota.count-1&&dota.count;i++) {
                NSLog(@"%ld",i);
                [self processDic:[dota objectAtIndex:i]:i];
                
            }

        }
        
    }];
    [dataTask resume];
}
//网络
- (void)processDic:(NSDictionary*)dic
                  :(NSInteger)cnt{
    
    NSString *com = [dic objectForKey:@"content"];
    NSString *me1 = [dic objectForKey:@"media1"];
    NSString *time = [dic objectForKey:@"createTime"];
    NSString *head = @"http://172.18.178.57:3000/prod-api";
    NSString *mediaURL = [head stringByAppendingString:me1];
    NSLog(@"%@五金批发%@",com,mediaURL);
    
    NSDictionary *temp = [[NSDictionary alloc] init];
    NSString *cout = [[NSNumber numberWithInteger:cnt]stringValue];
    NSString *back = @".jpg";
    NSString *name = [cout stringByAppendingString:back];
    temp = @{@"pinglun":com,
             @"imgURL":mediaURL,
             @"name":name,
             @"time":time
    };
    NSLog(@"%@",temp);
    [self->_dataList addObject:temp];
    NSLog(@"%lu",self->_dataList.count);
}
//本地
- (void)getImag {
    NSString *cach = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    NSLog(@"根目录 为%@",cach);
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *arr = [fm contentsOfDirectoryAtPath:cach error:nil];
    _imgarr = [[NSMutableArray alloc]init];
    NSInteger *cnt = 0;
    for (id key in arr) {
        NSString *tempStr = key;
        if([tempStr rangeOfString:@".jpg"].location!= NSNotFound) {
            cnt++;
            NSString *temp = [[NSString alloc]init];
            temp = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
            temp = [temp stringByAppendingPathComponent:key];
            NSLog(@"%@",temp);
            [_imgarr addObject:temp];
        }
    }
    if (cnt == 0) {
        NSLog(@"空空空坎坎坷坷看坎坎坷坷");
        [self load];}
    else {
        NSLog(@"哈哈哈哈哈哈哈哈");
    }
    [self.tableView reloadData];
}
- (void)clear {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Clear" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* clearlist = [UIAlertAction actionWithTitle:@"Clear List" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self clearLi];
    }];
    UIAlertAction* clearcache = [UIAlertAction actionWithTitle:@"Clear Cache" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self clearCa];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"算了");
    }];
    [alert addAction:clearlist];
    [alert addAction:clearcache];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)clearLi {
    [_imgarr removeAllObjects];
    [_tableView reloadData];
}
- (void)clearCa {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray* array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = array[0];
    NSEnumerator *fileEnum = [[fm subpathsAtPath:path]objectEnumerator];
    NSString *filepath;
    while ((filepath = [fileEnum nextObject])!=nil) {
        NSString *str = [path stringByAppendingPathComponent:filepath];
        [fm removeItemAtPath:str error:nil];
    }
    [_imgarr removeAllObjects];
    [_tableView reloadData];
}
- (void)load {
    _indicate = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-15, self.view.frame.size.height/2-15, 30, 30)];
    _indicate.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
    _indicate.color = [UIColor lightGrayColor];
    [self.view addSubview:_indicate];
    [_indicate startAnimating];
    
    [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
        NSLog(@"下载中。。。。。");
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSArray* array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = array[0];
            NSFileManager * existmanager = [NSFileManager defaultManager];
            NSLog(@"%@",path);
            for(NSInteger i=0;i<=self->_dataList.count-1&&self->_dataList.count;i++) {
                NSString *imageFilePath = [path stringByAppendingPathComponent:[[self->_dataList objectAtIndex:i] objectForKey:@"name"]];
                NSString *url = [[self->_dataList objectAtIndex:i] objectForKey:@"imgURL"];
                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL  URLWithString:url]];
                UIImage *image1 = [[UIImage alloc]init];
                image1 = [UIImage imageWithData:data1];
                NSLog(@"cunrupath:%@",imageFilePath);
                NSFileManager *fm = [NSFileManager defaultManager];
                bool a = [fm createFileAtPath:imageFilePath contents:nil attributes:nil];
                NSLog(@"%d",a);
                [UIImagePNGRepresentation(image1) writeToFile:imageFilePath  atomically:YES];
            }
            
            [NSThread sleepForTimeInterval:0.5];
            [self->_indicate stopAnimating] ;
            [self getImag];
                        }];
    }];
    
}

@end
