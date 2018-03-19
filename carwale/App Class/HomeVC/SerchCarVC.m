//
//  SerchCarVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 15/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "SerchCarVC.h"
#import "CarDetailVC.h"


@interface SerchCarVC ()

@end

@implementation SerchCarVC

#pragma mark -Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self headerFrame];
    [self setContentFrame];
    searchCarArr =[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
}

#pragma mark -Header Frame
-(void)headerFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =APP_HEADER_COLOR;
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    UIButton *btnback=[UIButton buttonWithType:UIButtonTypeCustom];
    btnback.frame=CGRectMake(0,20, 50,44);
    [btnback setImage:[UIImage imageNamed:@"back-icon"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(backbtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnback.backgroundColor=[UIColor clearColor];
    [navView addSubview:btnback];
    
    lblHeader =[[UILabel alloc]initWithFrame:CGRectMake(60,20,180,44)];
    lblHeader.textColor= [UIColor whiteColor];
    lblHeader.backgroundColor=[UIColor clearColor];
    lblHeader.textAlignment=NSTextAlignmentLeft;
    lblHeader.text = @"Search Car";
    lblHeader.font = [UIFont boldSystemFontOfSize:20];
    [navView addSubview:lblHeader];
    
}
#pragma mark - content Frmae
-(void)setContentFrame
{
    int y=64;
    SearchField = [[UISearchBar alloc]initWithFrame:CGRectMake(14, y, DEVICE_WIDTH-28, 50)];
    SearchField.showsCancelButton = NO;
    SearchField.delegate = self;
    SearchField.placeholder = @"Select Cars";
    SearchField.backgroundColor = [UIColor clearColor];
    SearchField.barTintColor=[UIColor clearColor];
    SearchField.tintColor = [UIColor clearColor];
    SearchField.userInteractionEnabled = YES;
    // Searchbar.textAlignment = NSTextAlignmentLeft;
    SearchField.layer.borderColor=[UIColor clearColor].CGColor;
    SearchField.layer.borderWidth=0.0f;
    SearchField.layer.cornerRadius=0.0;
    [SearchField setBackgroundImage: [UIImage new]];
    [self.view addSubview:SearchField];

    UITextField *textField = [SearchField valueForKey:@"_searchField"];
    textField.textColor = [UIColor blackColor];
    textField.placeholder = @"Select Cars";
    textField.leftViewMode = UITextFieldViewModeNever; //hiding left view
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:18.0];
     [textField resignFirstResponder];

    UILabel *bottomline = [[UILabel alloc] init];
    bottomline.frame = CGRectMake(SearchField.frame.origin.x, y+49,SearchField.frame.size.width , 1);
    bottomline.backgroundColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0];
    [self.view addSubview:bottomline];
    
    y=y+50;
    CityTbl = [[UITableView alloc] init];
    CityTbl.frame = CGRectMake(0, y, DEVICE_WIDTH, DEVICE_HEIGHT-y);
    CityTbl.delegate =self;
    CityTbl.dataSource =self;
    CityTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:CityTbl];
    
}
#pragma mark -UItableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return searchCarArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    static NSString *stringIdntifier = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringIdntifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringIdntifier];
    }
    if(isSearching)
    {
        cell.textLabel.text = [[searchResults objectAtIndex:indexPath.row] valueForKey:@"model_name"];
        
        return cell;
    }
    else
    {
        cell.textLabel.text = [[searchCarArr objectAtIndex:indexPath.row]valueForKey:@"model_name"];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([searchCarArr count]>0)
    {
        CarDetailVC * car = [[CarDetailVC alloc] init];
        car.hidesBottomBarWhenPushed = YES;
        car.dictCar = [searchCarArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:car animated:YES];
    }
}


#pragma mark - Search Delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString;
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText1
{
 
    if ([searchText1 length]>0)
    {
        [self SearchCars:searchText1];
        searchBar.showsCancelButton = YES;
        
    }
    else
    {
        SearchField.showsCancelButton = NO;
        [SearchField resignFirstResponder];
        [searchCarArr removeAllObjects];
        isSearching = NO;
        [CityTbl reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchStr1 = [NSString stringWithFormat:@"%@",searchBar.text];
    
    if (searchStr1.length >0)
    {
        SearchField.showsCancelButton = YES;
    }
    [SearchField resignFirstResponder];
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [self prefersStatusBarHidden];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
    
}
//-(void)filterContentForSearchText:(NSString *)searchText
//{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
//    searchResults =[[NSArray alloc] init];
//    searchResults = [searchCarArr filteredArrayUsingPredicate:predicate];
//    if (searchText == nil || [searchText isEqualToString:@""])
//        isSearching = NO;
//    else
//        isSearching = YES;
//    
//    [CityTbl reloadData];
//}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.text = @"";
    isSearching=NO;
    [searchCarArr removeAllObjects];
    [CityTbl reloadData];
    [searchBar resignFirstResponder];

    
}

#pragma mark - Get Popular cars
-(void)SearchCars:(NSString*)seacrchString
{
   
    BOOL isNetAvaliable = [(AppDelegate *)[[UIApplication sharedApplication]delegate] getInternetStatus];
    NSMutableDictionary *parameter_dict = [[NSMutableDictionary alloc]init];
    if (isNetAvaliable == NO)
    {
    }else
    {
        
        [parameter_dict setObject:seacrchString forKey:@"search_item"];
        NSString * webServiceName = @"searchModel";
        NSLog(@"There IS internet connection");
        URLManager *manager = [[URLManager alloc] init];
        manager.delegate = self;
        manager.commandName = @"searchModel";
        [manager postUrlCall:[NSString stringWithFormat:@"%@%@",WEB_SERVICE_URL_MODEL,webServiceName] withParameters:parameter_dict andValidation:NO];
    }
}
#pragma mark - Search Web Services
-(void)onResult:(NSDictionary *)result
{
    NSLog(@"Data %@",result);
    if([[result valueForKey:@"commandName"] isEqualToString:@"searchModel"])
    {
        if ([[[result valueForKey:@"result"]valueForKey:@"success"]isEqualToString:@"1"])
        {
            searchCarArr = [[result valueForKey:@"result"]valueForKey:@"model_list"];
            NSLog(@"%@",searchCarArr);
            if([searchCarArr count]>0)
            {
                [CityTbl reloadData];
            }
        }
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Click
-(void)backbtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
