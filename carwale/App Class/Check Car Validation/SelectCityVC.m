//
//  SelectCityVC.m
//  carwale
//
//  Created by Lubhna Shirvastava on 04/11/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "SelectCityVC.h"
#import "CheckValuationVC.h"
@interface SelectCityVC ()

@end

@implementation SelectCityVC
#pragma mark -Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self HeaderFrame];
    [self setContentFrame];
    cityNameArr =[[NSMutableArray alloc]init];
    [cityNameArr addObject:@"New Delhi"];
    [cityNameArr addObject:@"Mumbai"];
    [cityNameArr addObject:@"Ahmedabad"];
    [cityNameArr addObject:@"Pune"];
    [cityNameArr addObject:@"Banalore"];
    [cityNameArr addObject:@"Kolkata"];
    [cityNameArr addObject:@"Chennai"];
    
    // Do any additional setup after loading the view.
}

#pragma mark -Header Frame
-(void)HeaderFrame
{
    [navView removeFromSuperview];
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,DEVICE_WIDTH , 64)];
    navView.backgroundColor =[APP_DELEGATE colorWithHexString:AppHeaderColor];
    navView.userInteractionEnabled=YES;
    [self.view addSubview:navView];
    
    lblHeader = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, DEVICE_WIDTH-60, 44)];
    lblHeader.text=@"Select City";
    lblHeader.textColor = [UIColor whiteColor];
    lblHeader.textAlignment=NSTextAlignmentLeft;
    [lblHeader setFont:[UIFont systemFontOfSize:16.0]];
    lblHeader.userInteractionEnabled=YES;
    [navView addSubview:lblHeader];
    
    btnSideMenu = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [btnSideMenu setImage:[UIImage imageNamed:Icon_Menu] forState:UIControlStateNormal];
    [btnSideMenu addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnSideMenu.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [navView addSubview:btnSideMenu];
}
#pragma mark - content Frmae
-(void)setContentFrame
{
    int y=64;
    SearchField = [[UISearchBar alloc]initWithFrame:CGRectMake(0, y, DEVICE_WIDTH, 50)];
    SearchField.showsCancelButton = NO;
    SearchField.delegate = self;
    SearchField.placeholder = @"Select City";
    SearchField.tintColor = [UIColor blackColor];
    SearchField.barStyle = UIBarStyleDefault;
    [self.view addSubview:SearchField];
    
    y=y+50;
    CityTbl = [[UITableView alloc] init];
    CityTbl.frame = CGRectMake(0, y, DEVICE_WIDTH, DEVICE_HEIGHT-y);
    CityTbl.delegate =self;
    CityTbl.dataSource =self;
    [self.view addSubview:CityTbl];

}
#pragma mark -UItableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching == YES)
    {
        return searchResults.count;
    }
    else
    {
    return cityNameArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stringIdntifier = @"Cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringIdntifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringIdntifier];
    }
    if(isSearching)
    {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
        
        return cell;
    }
    else
    {
        cell.textLabel.text = [cityNameArr objectAtIndex:indexPath.row];
        return cell;
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
        [self filterContentForSearchText:searchText1];
        searchBar.showsCancelButton = YES;
        
    }
    else
    {
        SearchField.showsCancelButton = NO;
        [SearchField resignFirstResponder];
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
-(void)filterContentForSearchText:(NSString *)searchText
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
    searchResults =[[NSArray alloc] init];
    searchResults = [cityNameArr filteredArrayUsingPredicate:predicate];
    if (searchText == nil || [searchText isEqualToString:@""])
        isSearching = NO;
    else
        isSearching = YES;
    
    [CityTbl reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.text = @"";
    isSearching=NO;
    [CityTbl reloadData];
    [searchBar resignFirstResponder];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Click
-(void)btnBackClicked:(id)sender
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
