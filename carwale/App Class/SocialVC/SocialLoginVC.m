//
//  SocialLoginVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 7/31/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "SocialLoginVC.h"
#import "LoginVC.h"
#import "RegisterVC.h"

@interface SocialLoginVC ()

@end

@implementation SocialLoginVC



#pragma mark - Viewcontroller Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    /*---Header Frame---/8*/
    
    [APP_DELEGATE showProcessHud];
    [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(stopHud) userInfo:nil repeats:nil];
    // Do any additional setup after loading the view.
}
-(void)stopHud
{
    [APP_DELEGATE hideProcessHud];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
