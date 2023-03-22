//
//  ZJViewController.m
//  ZJFPSMonitor
//
//  Created by BboyZJ on 03/23/2023.
//  Copyright (c) 2023 BboyZJ. All rights reserved.
//

#import "ZJViewController.h"
#import <ZJFPSMonitor/ZJFPSMonitor.h>

@interface ZJViewController ()

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [ZJFPSMonitor.shareInstance startMonitor];
    ZJFPSMonitor.shareInstance.FPSMonitorBlock = ^(NSInteger fps) {
        NSLog(@"%ld",fps);
    };
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
