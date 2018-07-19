//
//  LLYTestVC2.m
//  LLYMemoryLeakDetector
//
//  Created by lly on 2018/7/19.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYTestVC2.h"

@interface LLYTestVC2 ()

@property (nonatomic, strong) NSTimer *mTimer;

@end

@implementation LLYTestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"LLYTestVC2";
    
    self.mTimer  = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self test];
    }];
    
}

- (void)test{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
