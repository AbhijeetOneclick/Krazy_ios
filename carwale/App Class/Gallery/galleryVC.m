//
//  galleryVC.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/23/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "galleryVC.h"
#import "ExteriorIMGCell.h"
#import "InteriorIMGCell.h"
#import "VideoCell.h"


@interface galleryVC ()

@end

@implementation galleryVC
@synthesize arrImgExterior,arrImgInterior,arrImgVideo;
#pragma mark - Lifecycle Class

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",arrImgExterior);
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    optionsAry = [[NSMutableArray alloc] init];
    sizeOfx = [[NSMutableArray alloc] init];
    [self headerFrame];
    [self setFrame];

    // Do any additional setup after loading the view.
}

-(void)headerFrame
{
    [navView removeFromSuperview];
    int yy = 0;
    if(IS_IPHONE_X){
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 88)];
    }
    else{
        navView = [[UIView alloc] initWithFrame:CGRectMake(0,yy,DEVICE_WIDTH , 64)];
    }
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];

    if(IS_IPHONE_X){
        yy=yy+44;
    }else{
        yy=yy+20;
    }

    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
    {
        btnback.frame=CGRectMake(0,yy, 50,44);
        [btnback setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    }else{
        btnback.frame=CGRectMake(DEVICE_WIDTH-50,yy, 50,44);
        [btnback setImage:[UIImage imageNamed:@"Back_btn_Arabic"] forState:UIControlStateNormal];
    }
    [btnback addTarget:self action:@selector(btnBackClick:) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnback];

    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-75,yy+12,150,20)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentCenter;
    lblHeader.text = @"Gallery";
    lblHeader.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    [navView addSubview:lblHeader];
    [self tabBarView];
}

-(void)tabBarView
{
    int yy;
    if(IS_IPHONE_X){
        yy=88;
    }else{
        yy=64;
    }
    optionsAry = [NSMutableArray arrayWithObjects:@"Exterior",@"Interior",@"Videos", nil];
    NSLog(@"%@", optionsAry);
    [scrolltabBar removeFromSuperview];
    scrolltabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yy,DEVICE_WIDTH , 44)];
    scrolltabBar.scrollEnabled=YES;
    self.automaticallyAdjustsScrollViewInsets= NO;
    scrolltabBar.userInteractionEnabled= YES;
    scrolltabBar.showsHorizontalScrollIndicator = NO;
    scrolltabBar.showsVerticalScrollIndicator = NO;
    scrolltabBar.delegate=self;
    scrolltabBar.backgroundColor = [UIColor colorWithRed:7/255.0 green:99/255.0 blue:150/255.0 alpha:1];
    [self.view addSubview:scrolltabBar];

    int buffer = 0;
    int xy=0;
    int buttonWidth =DEVICE_WIDTH/[optionsAry count],buttonHeight=44;

    showBoder = [[UILabel alloc] init];
    showBoder.frame =  CGRectMake(0,42,buttonWidth,2);
    showBoder.backgroundColor = [APP_DELEGATE colorWithHexString:@"FF653F"];
    [scrolltabBar addSubview:showBoder];

    for (buttonId = 0; buttonId < [optionsAry count]; buttonId++)
    {
        [sizeOfx addObject:[NSNumber numberWithInt:xy]];
        BtnCategory = [[UIButton alloc] init];
        BtnCategory=[UIButton buttonWithType:UIButtonTypeCustom];
        BtnCategory.frame     = CGRectMake(xy, 0,buttonWidth,buttonHeight );
        [BtnCategory addTarget:self action:@selector(btnTabClick:) forControlEvents:UIControlEventTouchUpInside];
        [BtnCategory setTitle: [NSString stringWithFormat:@"%@",[optionsAry objectAtIndex:buttonId]] forState:UIControlStateNormal];
        [BtnCategory setBackgroundColor:[UIColor clearColor]];
        BtnCategory.tag=buttonId;
        BtnCategory.titleLabel.textColor= [UIColor blackColor];
        BtnCategory.titleLabel.textAlignment= NSTextAlignmentCenter;
        BtnCategory.titleLabel.font= [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];

        xy = buttonWidth + xy + buffer;
        [scrolltabBar addSubview:BtnCategory];
    }
    [scrolltabBar setContentSize:CGSizeMake(xy, 0)];
}

-(void)setFrame
{
    int yy;
    if(IS_IPHONE_X){
    yy=88+44;
    }else{
    yy=64+44;
    }
    
    scrolMain =[[UIScrollView alloc] initWithFrame:CGRectMake(0, yy, DEVICE_WIDTH, DEVICE_HEIGHT-yy)];
    scrolMain.delegate=self;
    scrolMain.bounces= NO;
    scrolMain.pagingEnabled=YES;
    [self.view addSubview:scrolMain];
    scrolMain.delaysContentTouches = NO;
    [scrolMain setContentSize:CGSizeMake(DEVICE_WIDTH*3,DEVICE_HEIGHT-yy)];
    
    exteriorTbl =[[UITableView alloc]initWithFrame:CGRectMake(0,0,DEVICE_WIDTH,scrolMain.frame.size.height) style:UITableViewStyleGrouped];
    if(IS_IPHONE_X)
    {
        exteriorTbl.frame = CGRectMake(0,0,DEVICE_WIDTH,scrolMain.frame.size.height);
    }
    [exteriorTbl setBackgroundColor:[UIColor clearColor]];
    exteriorTbl.hidden = NO;
    exteriorTbl.tag = 1;
    exteriorTbl.showsVerticalScrollIndicator = NO;
    exteriorTbl.showsHorizontalScrollIndicator=NO;
    [exteriorTbl setDelegate:self];
    [exteriorTbl setDataSource:self];
    [exteriorTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scrolMain addSubview:exteriorTbl];

    interiorTbl =[[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH,0,DEVICE_WIDTH,scrolMain.frame.size.height) style:UITableViewStyleGrouped];
    if(IS_IPHONE_X)
    {
        interiorTbl.frame = CGRectMake(DEVICE_WIDTH,0,DEVICE_WIDTH,scrolMain.frame.size.height);
    }
    [interiorTbl setBackgroundColor:[UIColor clearColor]];
    interiorTbl.tag = 2;
    interiorTbl.showsVerticalScrollIndicator = NO;
    interiorTbl.showsHorizontalScrollIndicator=NO;
    [interiorTbl setDelegate:self];
    [interiorTbl setDataSource:self];
    [interiorTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scrolMain addSubview:interiorTbl];

    videoTbl =[[UITableView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*2,0,DEVICE_WIDTH,scrolMain.frame.size.height) style:UITableViewStyleGrouped];
    if(IS_IPHONE_X)
    {
        videoTbl.frame = CGRectMake(DEVICE_WIDTH*2,0,DEVICE_WIDTH,scrolMain.frame.size.height);
    }
    videoTbl.tag = 3;
    [videoTbl setBackgroundColor:[UIColor clearColor]];
    videoTbl.showsVerticalScrollIndicator = NO;
    videoTbl.showsHorizontalScrollIndicator=NO;
    [videoTbl setDelegate:self];
    [videoTbl setDataSource:self];
    [videoTbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scrolMain addSubview:videoTbl];
}


-(void)btnTabClick:(id)sender
{
    if([sender tag]==0) 
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        [UIView animateWithDuration:.5 animations:^{
            NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
            int xy = [firstNumber intValue];

            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        
        [scrolMain setContentOffset:CGPointMake(0,0) animated:YES];
        [exteriorTbl reloadData];


    }if([sender tag]==1)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        
        [scrolMain setContentOffset:CGPointMake(DEVICE_WIDTH,0) animated:YES];
        [interiorTbl reloadData];

    }if([sender tag]==2)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
        [scrolMain setContentOffset:CGPointMake(DEVICE_WIDTH*2, 0) animated:YES];
        [videoTbl reloadData];

    }
    /*if([sender tag]==3)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];

    }
    if([sender tag]==4)
    {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];

        NSNumber *firstNumber = [sizeOfx objectAtIndex:[sender tag]];
        int xy = [firstNumber intValue];

        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];

    }*/
}

#pragma mark -tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int no;
    if(tableView.tag == 1){
        if([arrImgExterior count]>0){
            if(IS_IPAD)
            {
                no =[arrImgExterior count] /3;
                return ([arrImgExterior count] %3 > 0 ? no+1 : no);

            }else{
                no =[arrImgExterior count] /2;
                return ([arrImgExterior count] %2 > 0 ? no+1 : no);
            }
        }else{
            return 0;
        }
    }
    if(tableView.tag ==2){
        if([arrImgInterior count]>0){
            if(IS_IPAD)
            {
                no =[arrImgInterior count] /3;
                return ([arrImgInterior count] %3 > 0 ? no+1 : no);

            }else{
                no =[arrImgInterior count] /2;
                return ([arrImgInterior count] %2 > 0 ? no+1 : no);
            }
        }else{
            return 0;
        }
    }else{
       if([arrImgVideo count]>0)
       {
           if(IS_IPAD)
           {
               no =[arrImgVideo count] /2;
               return ([arrImgVideo count] %2 > 0 ? no+1 : no);

           }else{
               no =[arrImgVideo count] /1;
               return ([arrImgVideo count] %1 > 0 ? no+1 : no);
           }
       }else{
           return 0;
       }
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==3)
    {
        return 226;
    }
    else
    {
        return 112;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if(tableView.tag == 1)
    {
        NSString * cellID = nil;
        ExteriorIMGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (cell != nil)
            return cell;
        cell=[[ExteriorIMGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.eventHandler=self;
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setGalleryDetail:[arrImgExterior mutableCopy]  atIndexPath:indexPath imagePath:nil];
        return cell;
    }
     if(tableView.tag == 2)
    {
        NSString * cellID = nil;
        InteriorIMGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell != nil)
            return cell;
        cell=[[InteriorIMGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.eventHandler=self;
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setGalleryDetail:[arrImgExterior mutableCopy]  atIndexPath:indexPath imagePath:nil];
        return cell;
    }
    else{
        NSString * cellID = nil;
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell != nil)
            return cell;
        cell=[[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.eventHandler=self;
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        [cell setGalleryDetail:[arrImgExterior mutableCopy]  atIndexPath:indexPath imagePath:nil];
        return cell;
        return cell;
    }
}


#pragma mark - scrollView Delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrolMain.contentOffset.x == (DEVICE_WIDTH*2)){
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];
        NSNumber *firstNumber = [sizeOfx objectAtIndex:2];
        int xy = [firstNumber intValue];
        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
    } if (scrolMain.contentOffset.x == DEVICE_WIDTH){
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];
        NSNumber *firstNumber = [sizeOfx objectAtIndex:1];
        int xy = [firstNumber intValue];
        [UIView animateWithDuration:.5 animations:^{
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
    } if (scrolMain.contentOffset.x == 0){
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:showBoder cache:YES];
        [UIView commitAnimations];
        [UIView animateWithDuration:.5 animations:^{
            NSNumber *firstNumber = [sizeOfx objectAtIndex:0];
            int xy = [firstNumber intValue];
            
            showBoder.frame=CGRectMake( xy, showBoder.frame.origin.y, BtnCategory.frame.size.width, 3);
        } completion:^(BOOL finished) {
        }];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];

    if(translation.y > 0)
    {
    } else
    {
        
    }
}

#pragma mark - button Action Method
-(void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
