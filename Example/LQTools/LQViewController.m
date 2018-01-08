//
//  LQViewController.m
//  LQTools
//
//  Created by 563096676@qq.com on 01/06/2018.
//  Copyright (c) 2018 563096676@qq.com. All rights reserved.
//

#import "LQViewController.h"
#import <LQTools/LQCalculateStrHeight.h>
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
    unsigned int count = 0;
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
