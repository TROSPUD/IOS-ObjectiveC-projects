//
//  Clockin.m
//  test
//
//  Created by student3 on 2022/9/20.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClockinVC.h"
#import "share.h"

@interface ClockinVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property NSInteger cnt;//上传图片数量
@property (nonatomic, strong) UIImageView* imagView;//显示图片
@property (copy, nonatomic) NSMutableArray *imagList;//图片数组
@property (nonatomic, strong) UIImagePickerController *imagPicker;////图像选择器
@property (nonatomic, strong) UITextView *t1;//输入框
@property (nonatomic, strong) UITextView *t2;
@property (nonatomic, strong) UITextView *t3;
@property (nonatomic, strong) UITextView *t4;
@property (nonatomic, strong) UIButton *add;//添加图片按钮
@end

@implementation ClockinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Clock In";
    _cnt = 0;
    _imagList = [[NSMutableArray alloc]init];
    NSLog(@"扑街");
}
    
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submit];
- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    [self addText];
    NSLog(@"丢");
}

- (void)addText{
    //输入框
    UILabel *L1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/11, 2*self.view.frame.size.width/9, 100, 20)];
    UILabel *L2 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/11, 3*self.view.frame.size.width/9, 100, 20)];
    UILabel *L3 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/11, 4*self.view.frame.size.width/9, 100, 20)];
    UILabel *L4 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/11, 5*self.view.frame.size.width/9, 100, 20)];
    UILabel *L5 = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/11, 7*self.view.frame.size.width/9+20, 100, 20)];
    L1.text = @"Date";
    L2.text = @"Place";
    L3.text = @"Name";
    L4.text = @"Coment";
    L5.text = @"Post";
    [self.view addSubview:L1];
    [self.view addSubview:L2];
    [self.view addSubview:L3];
    [self.view addSubview:L4];
    [self.view addSubview:L5];
    
    _t1.delegate = (id)self;//不加id自定义分类使用协议时出现与父类协议冲突
    _t2.delegate = (id)self;
    _t3.delegate = (id)self;
    _t4.delegate = (id)self;
    _t1 = [[UITextView alloc]initWithFrame:CGRectMake(3*self.view.frame.size.width/10, 2*self.view.frame.size.width/9, 5*self.view.frame.size.width/9, 25)];
    _t2 = [[UITextView alloc]initWithFrame:CGRectMake(3*self.view.frame.size.width/10, 3*self.view.frame.size.width/9, 5*self.view.frame.size.width/9, 25)];
    _t3 = [[UITextView alloc]initWithFrame:CGRectMake(3*self.view.frame.size.width/10, 4*self.view.frame.size.width/9, 5*self.view.frame.size.width/9, 25)];
    _t4 = [[UITextView alloc]initWithFrame:CGRectMake(3*self.view.frame.size.width/10, 5*self.view.frame.size.width/9, 5*self.view.frame.size.width/9, 70)];
    _t1.layer.borderWidth = 0.5;
    _t2.layer.borderWidth = 0.5;
    _t3.layer.borderWidth = 0.5;
    _t4.layer.borderWidth = 0.5;
    _t1.layer.cornerRadius = 5;
    _t2.layer.cornerRadius = 5;
    _t3.layer.cornerRadius = 5;
    _t4.layer.cornerRadius = 5;
    _t1.layer.borderColor = [UIColor grayColor].CGColor;
    _t2.layer.borderColor = [UIColor grayColor].CGColor;
    _t3.layer.borderColor = [UIColor grayColor].CGColor;
    _t4.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.view addSubview:_t1];
    [self.view addSubview:_t2];
    [self.view addSubview:_t3];
    [self.view addSubview:_t4];
    
    //添加图片按钮
    _add = [[UIButton alloc] init];
    [_add setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    _add.frame = CGRectMake(3*self.view.frame.size.width/10, 7*self.view.frame.size.width/9+20, 50, 50);
    _add.layer.borderWidth = 0.5;
    _add.layer.borderColor = [UIColor grayColor].CGColor;
    _add.layer.cornerRadius = 25;
    [_add addTarget:self action:@selector(Addpics) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_add];
    
    //发布按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Update" style:UIBarButtonItemStyleDone target:self action:@selector(Fabu:)];

    
    
    
}
-(void)Addpics {
    self.imagPicker = [[UIImagePickerController alloc]init];
    self.imagPicker.delegate = (id)self;
    self.imagPicker.allowsEditing = YES;
    
    UIAlertController *actions = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];//弹框
    
    UIAlertAction *shoot = [UIAlertAction actionWithTitle:@"Shoot" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagPicker.sourceType
            = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagPicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *selectPic = [UIAlertAction actionWithTitle:@"Choose" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagPicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Cancel");
    }];
    
    [actions addAction:shoot];
    [actions addAction:selectPic];
    [actions addAction:cancel];
    [self presentViewController:actions animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获得添加的图片
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImageView *temp = [[UIImageView alloc] init];
    //一排三张图片
    temp.frame = CGRectMake(3*self.view.frame.size.width/10+75*(self.cnt%3), 7*self.view.frame.size.width/9+20+75*(self.cnt/3), 70, 70);
    temp.image = img;
    [_imagList addObject:img];
    [self.view addSubview:temp];
    _cnt++;
    NSLog(@"succeed");
    
    //添加图片按钮往后移动
    self.add.frame = CGRectMake(3*self.view.frame.size.width/10+80*(self.cnt%3), 7*self.view.frame.size.width/9+20, 50, 50);
    if (_cnt >= 3)
        self.add.enabled = false;
}

- (void) imagPickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)Fabu: (UIButton*) btn {
    NSDictionary *temp = [[NSDictionary alloc] init];
    temp = @{@"date":_t1.text,
             @"place":_t2.text,
             @"name":_t3.text,
             @"comment":_t4.text,
             @"image":_imagList.mutableCopy
        
    };
    [[share sharedInstance].datalist addObject:temp];
    NSLog(@"我发");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"title" message:@"Successfully Updated" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    self.tabBarController.selectedIndex = 0;//跳转到导航栏的第0页
    _cnt = 0;
    [_imagList removeAllObjects];
    [NSThread sleepForTimeInterval:0.5];
    [self loadView];
}
@end
