//
//  ViewController.m
//  LLYMemoryLeakDetector
//
//  Created by lly on 2018/7/19.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "ViewController.h"
#import "LLYTestVC1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBtnClicked:(id)sender {
    
    LLYTestVC1 *vc = [[LLYTestVC1 alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

@end
