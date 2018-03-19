//
//  UpcomingCarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "UpcomingCarVC.h"
#import "UpcomingCarCell.h"
@interface UpcomingCarVC ()

@end

@implementation UpcomingCarVC

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetFrame];
    [self headerFrame];
 
     UpcomingCarDataTbl.separatorColor = [UIColor clearColor];
    self.view.backgroundColor=[UIColor whiteColor];
    dictCar1 = [[NSMutableDictionary alloc]init];
    [dictCar1 setObject:@"demo1.jpg" forKey:@"carImg"];
    [dictCar1 setObject:@"Car Name" forKey:@"carName"];
    [dictCar1 setObject:@"13,36,544" forKey:@"carPrice"];
    
    dictCar2 = [[NSMutableDictionary alloc]init];
    [dictCar2 setObject:@"demo1.jpg" forKey:@"carImg"];
    [dictCar2 setObject:@"Car Name" forKey:@"carName"];
    [dictCar2 setObject:@"13,36,544" forKey:@"carPrice"];
    arrCar = [[NSMutableArray alloc] initWithObjects:dictCar1,dictCar2, nil];
    // Do any additional setup after loading the view.
}

#pragma mark - Header Frame
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    lblHeader.text=@"Upcoming Car";
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

#pragma mark -Content Frame
-(void)SetFrame
{
    UpcomingCarDataTbl = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH,DEVICE_HEIGHT-64) style:UITableViewStylePlain];
    UpcomingCarDataTbl.delegate = self;
    UpcomingCarDataTbl.dataSource = self;
    UpcomingCarDataTbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:UpcomingCarDataTbl];
}

#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
-(void)btnFindCarClicked:(id)sender
{
    
}

#pragma mark - UItableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=nil;
    UpcomingCarCell *cell = [theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[UpcomingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.carImg.image = [UIImage imageNamed:[[arrCar objectAtIndex:indexPath.row]objectForKey:@"carImg"]];
    cell.carNameLbl.text=[[arrCar objectAtIndex:indexPath.row]objectForKey:@"carName"];
//    cell.carPriceLbl.text=[[arrCar objectAtIndex:indexPath.row]objectForKey:@"carPrice"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEVICE_HEIGHT/2-64;
}

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
