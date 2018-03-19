//
//  LoacalDealarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 01/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "LoacalDealarVC.h"
#import "LocateDealerCell.h"
@interface LoacalDealarVC ()

@end

@implementation LoacalDealarVC

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrame];
    [self headerFrame];
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
}

#pragma mark - header Frame
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DEVICE_WIDTH, 44)];
    lblHeader.text=@"Locate Dealer";
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

#pragma mark - Content Frame
-(void)setFrame
{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3-30,30);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.headerReferenceSize = CGSizeMake(0.0,5.0);
    brandNameCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,64, DEVICE_WIDTH,DEVICE_HEIGHT-64 )collectionViewLayout:layout];
    [brandNameCollectionView setDataSource:self];
    [brandNameCollectionView setDelegate:self];
    [brandNameCollectionView registerClass:[LocateDealerCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [brandNameCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:brandNameCollectionView];
}

#pragma mark - Button Action
-(void)btnSideMenuClicked:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HistoryNotification" object:nil];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

#pragma mark - UICollectionview Delegate Methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrCar.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LocateDealerCell *cell = (LocateDealerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.brandLogoImg.image = [UIImage imageNamed:[[arrCar objectAtIndex:indexPath.row]objectForKey:@"carImg"]];
    cell.brandNameLbl.text=[[arrCar objectAtIndex:indexPath.row]objectForKey:@"carName"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat picDimension = (self.view.frame.size.width-30) / 3;
    return CGSizeMake(picDimension, picDimension);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,10,0,10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
