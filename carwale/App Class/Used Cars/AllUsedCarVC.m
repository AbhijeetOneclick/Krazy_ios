//
//  AllUsedCarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "AllUsedCarVC.h"

@interface AllUsedCarVC ()

@end

@implementation AllUsedCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
        [self setframeContent];
    [self headerFrame];

    self.view.backgroundColor=[UIColor whiteColor];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    lblHeader.text=@"Used Cars";
    lblHeader.textColor = [UIColor whiteColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    [lblHeader setFont:[UIFont systemFontOfSize:16.0]];
    lblHeader.userInteractionEnabled=YES;
    [navView addSubview:lblHeader];
    
    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnSideMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSideMenu.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [navView addSubview:btnSideMenu];
    
    
}
-(void)setframeContent
{
    UIScrollView *scrlContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , DEVICE_HEIGHT*2)];
    scrlContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrlContent];
    
    UIScrollView *CarImageScrolling = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH ,DEVICE_HEIGHT/2-100 )];

    carIamgeArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"demo1.jpg"], nil];
    for(int i=0;i<=[carIamgeArray count];i++)
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.frame = CGRectMake(100*i, 0, 100, CarImageScrolling.frame.size.height);
        imgView.image = [carIamgeArray objectAtIndex:i];
        [CarImageScrolling addSubview:imgView];
    }
    CarImageScrolling.contentSize = CGSizeMake(CarImageScrolling.frame.size.width * carIamgeArray.count, CarImageScrolling.frame.size.height);
    [scrlContent addSubview:CarImageScrolling];
    
}


#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
@end
