//
//  NewsVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 8/4/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden=YES;
    
    [self headerFrame];

}
#pragma mark - HeaderFrame
//-(void)headerFrame
//{
//    [navView removeFromSuperview];
//    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
//    //    navView.backgroundColor =[APP_DELEGATE colorWithHexString:GlobalHeaderBackgroundColor];
//    navView.userInteractionEnabled=YES;
//    [self.view addSubview:navView];
//    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:navView.bounds];
//    navView.layer.masksToBounds = NO;
//    navView.layer.shadowColor = [UIColor blackColor].CGColor;
//    navView.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);
//    navView.layer.shadowOpacity = 0.2f;
//    navView.layer.shadowPath = shadowPath.CGPath;
//    
//    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
//    lblHeader.text=@"News screen";
//    //  lblHeader.textColor = [APP_DELEGATE colorWithHexString:GlobalHeaderFontColor];
//    lblHeader.textAlignment=NSTextAlignmentCenter;
//    [lblHeader setFont:[UIFont systemFontOfSize:16.0]];
//    lblHeader.userInteractionEnabled=YES;
//    [navView addSubview:lblHeader];
//    
//    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
//    //    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
//    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
//    btnSideMenu.titleLabel.font = [UIFont systemFontOfSize:16.0];
//    [navView addSubview:btnSideMenu];
//    
//}
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
//    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
//    lblHeader.text=@"News";
//    lblHeader.textColor = [UIColor whiteColor];
//    lblHeader.textAlignment=NSTextAlignmentCenter;
//    [lblHeader setFont:[UIFont systemFontOfSize:16.0]];
//    lblHeader.userInteractionEnabled=YES;
//    [navView addSubview:lblHeader];
    
    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSideMenu.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [navView addSubview:btnSideMenu];
    
    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(60,20,150,44)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentLeft;
    lblHeader.text = @"News";
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
    
}
#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];

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
