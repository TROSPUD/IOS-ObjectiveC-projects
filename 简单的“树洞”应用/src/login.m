//
//  login.m
//  treehole
//
//  Created by student3 on 2022/10/13.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "login.h"
#import "mine.h"
#import "dis.h"

@interface LogIn ()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *pass;
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *uuid;
@property (nonatomic,retain) UILabel *l1;
@property (nonatomic,retain) UILabel *l2;
@property (nonatomic,retain) UILabel *l3;
@property (nonatomic,retain) UITextField *t1;//账号
@property (nonatomic,retain) UITextField *t2;//密码
@property (nonatomic,retain) UITextField *t3;//验证码
@property (nonatomic,retain) UIButton *btn;//login
@property (nonatomic, retain) UIButton *vtn;//vertify

@end

@implementation LogIn

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *lo = [UIImage imageNamed:@"logo.jpg"];
    UIImageView *vlog = [[UIImageView alloc] initWithImage:lo];
    vlog.frame = CGRectMake(self.view.frame.size.width/8, self.view.frame.size.height/4, 3*self.view.frame.size.width/4, self.view.frame.size.width/5);
    vlog.layer.masksToBounds = YES;
    vlog.contentMode = UIViewContentModeScaleAspectFit;
    
    _t1.delegate = (id)self;
    _t2.delegate = (id)self;
    _t3.delegate = (id)self;
    _t1 = [[UITextField alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/4+120, self.view.frame.size.width-40, 40)];
    _t2 = [[UITextField alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/4+180, self.view.frame.size.width-40, 40)];
    _t3 = [[UITextField alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/4+240, self.view.frame.size.width-170, 40)];

    [self setUtf:_t1];
    [self setUtf:_t2];
    [self setUtf:_t3];
    _btn = [[UIButton alloc]init];
    _btn.frame = CGRectMake(20, self.view.frame.size.height/4+300, self.view.frame.size.width-40, 40);
    _btn.layer.borderWidth = 0.5;
    _btn.layer.cornerRadius = 5;
    [_btn setTitle:@"登录" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor blueColor]];
    [_btn addTarget:self action:@selector(buttonClickd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vlog];
    [self.view addSubview:_t1];
    [self.view addSubview:_t2];
    [self.view addSubview:_t3];
    [self.view addSubview:_btn];
    
    //验证码
    [self vertify];
}
- (void)setUtf:(UITextField*) utf{
    utf.layer.borderWidth = 0.5;
    utf.layer.cornerRadius = 5;
    utf.layer.borderColor = [UIColor grayColor].CGColor;
    [utf setAutocapitalizationType:UITextAutocapitalizationTypeNone];//关闭输入框首字母大写
}
- (void) vertify {
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:(id)self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://172.18.178.57:3000/prod-api/captchaImage"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"Data=%@",text);
            //转成字典
            UIImage *decodedImage = [self JsonToImage:data];
            //设成一个按钮
            self.vtn = [[UIButton alloc]init];
            self.vtn.frame = CGRectMake(self.view.frame.size.width - 120, self.view.frame.size.height/4+235, 100, 50);
            [self.vtn setImage:decodedImage forState:UIControlStateNormal];
            [self.vtn addTarget:self action:@selector(vtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.vtn];
        }
    }];
    [dataTask resume];
    //json to dict
}
- (UIImage *)JsonToImage:(NSData *)data {
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败");
    }
    else {
        NSLog(@"我是一道分割线-----------");
    }
    //取出img对应的值
    NSString *imge = [dic objectForKey:@"img"];
    _uuid = [dic objectForKey:@"uuid"];
    NSLog(@"%@",_uuid);
    
    //字符串转data
    NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:imge options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //data转图片
    UIImage *decodedImage = [UIImage imageWithData:decodedImgData];
    return decodedImage;
}
- (void)vtnClicked {
    //按下验证码刷新
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:(id)self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:@"http://172.18.178.57:3000/prod-api/captchaImage"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error == nil) {
            NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"丢");
            NSLog(@"Data=%@",text);
            //转成字典
            UIImage* decodedImage = [self JsonToImage:data];
            [self.vtn setImage:decodedImage forState:UIControlStateNormal];
            [self.vtn addTarget:self action:@selector(vtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.vtn];
        }
    }];
    [dataTask resume];
}

- (void)buttonClickd {
    _name = _t1.text;
    _pass = _t2.text;
    _code = _t3.text;
    NSLog(@"%@", self.name);
    NSLog(@"%@", self.pass);
    static NSDictionary *dict;
    NSURL *url = [NSURL URLWithString:@"http://172.18.178.57:3000/prod-api/login"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *bodystr = [[NSString alloc]initWithFormat:@"{\"code\":\"%@\",\"password\":\"%@\",\"username\":\"%@\",\"uuid\":\"%@\"}",_code,_pass,_name,_uuid];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:[bodystr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"我在登录");
        NSLog(@"Response:%@ %@\n",response,error);
        if(error == nil) {
            NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Data=%@",text);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self judge:dict];
            });
            }
    }];
    [dataTask resume];
}
- (void)judge:(NSDictionary*)dic {
    NSString *msg = [dic objectForKey:@"msg"];//记录返回信息
    NSString *toke = [dic objectForKey:@"token"];
    NSLog(@"%@",msg);
    if([msg isEqual:@"操作成功"]) {
        /*UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"title" message:@"Successfully LogIn" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert1 animated:true completion:nil];
        [alert1 dismissViewControllerAnimated:YES completion:nil];*/
        [NSThread sleepForTimeInterval:0.5];
        [self onLogin:toke];
    }
    else if([msg isEqual:@"验证码错误"]) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"验证码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK");
        }];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:true completion:nil];
    }
    else if([msg isEqual:@"验证码已失效"]) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"验证码已失效，请点击刷新" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK");
        }];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:true completion:nil];
    }
    else if([msg isEqual:@"用户不存在/密码错误"]) {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK");
        }];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:true completion:nil];
    }
    else {
        UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"用户不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"OK");
        }];
        [alert1 addAction:ok];
        [self presentViewController:alert1 animated:true completion:nil];
    }
}

- (void)onLogin:(NSString *)toke {
    UITabBarController *bar = [[UITabBarController alloc]init];
    mine *mi = [[mine alloc]init];
    UINavigationController *m1 = [[UINavigationController alloc] initWithRootViewController:mi];
    m1.title = @"mine";
    m1.tabBarItem.selectedImage = [UIImage imageNamed:@"mineicon.png"];
    m1.tabBarItem.image = [UIImage imageNamed:@"mineicon.png"];
    m1.tabBarItem.title = @"mine";
    mi.token = toke;
    [mi getInfo];
    
    Dis *di = [[Dis alloc] init];
    UINavigationController *d1 = [[UINavigationController alloc] initWithRootViewController:di];
    d1.title = @"discover";
    d1.tabBarItem.selectedImage = [UIImage imageNamed:@"disicon.png"];
    d1.tabBarItem.image = [UIImage imageNamed:@"disicon.png"];
    d1.tabBarItem.title = @"discover";
    di.token = toke;
    [di getInfo];
    bar.viewControllers = @[d1,m1];
    bar.modalPresentationStyle = 0;
    [self presentViewController:bar animated:YES completion:nil];
}
@end
