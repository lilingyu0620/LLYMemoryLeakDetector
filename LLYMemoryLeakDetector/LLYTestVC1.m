//
//  LLYTestVC1.m
//  LLYMemoryLeakDetector
//
//  Created by lly on 2018/7/19.
//  Copyright © 2018年 lly. All rights reserved.
//

#import "LLYTestVC1.h"
#import "LLYTestVC2.h"

@interface LLYTestVC1 ()

@property (nonatomic, strong) NSTimer *mTimer;

@end

@implementation LLYTestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"TestVC1";
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClicked)];
    self.navigationItem.leftBarButtonItem = back;
    
    self.mTimer  = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self test];
    }];
    
}

- (void)test{
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.mTimer invalidate];
//    self.mTimer = nil;
}

- (void)backBtnClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBtnClicked:(id)sender {
    
    LLYTestVC2 *vc = [[LLYTestVC2 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
