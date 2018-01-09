//
//  LQViewController.m
//  LQTools
//
//  Created by 563096676@qq.com on 01/06/2018.
//  Copyright (c) 2018 563096676@qq.com. All rights reserved.
//

#import "LQViewController.h"
#import "LQTools.h"
#import <Messages/Messages.h>

@interface LQViewController ()

@property (nonatomic,copy) NSString *name;
@end

@implementation LQViewController

-(NSString *)description{
    
    return [NSString stringWithFormat:@"name:%@",_name];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //测试混合图片
    UIButton *testBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn3.frame = CGRectMake(50,190,200,40);
    [testBtn3 setBackgroundColor:[UIColor lqRGBWithColor:LQRBGMake(1, 255, 255) alpha:1]];
    [testBtn3 setTitle:@"浏览混合图片" forState:UIControlStateNormal];
    [testBtn3 addTarget:self action:@selector(test3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn3];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)test3:(UIButton *)sender{
    LQPhotoBrowserVC *browser = [[LQPhotoBrowserVC alloc]init];
    browser.photoSourceArr = @[@"http://pic.58pic.com/58pic/15/14/14/18e58PICMwt_1024.jpg",[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],@"http://old.bz55.com/uploads/allimg/150509/139-150509111427.jpg",@"http://fd.topitme.com/d/a8/1d/11315383988791da8do.jpg",[UIImage imageNamed:@"5"]].mutableCopy;
    browser.downLoadNeeded = YES;
    [self.navigationController pushViewController:browser animated:YES];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
