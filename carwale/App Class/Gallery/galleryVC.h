//
//  galleryVC.h
//  carwale
//
//  Created by One Click IT Consultancy  on 1/23/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface galleryVC : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView * navView;
    UILabel * lblHeader;
    UIButton *btnSideMenu;
    UIView *showTabbar;
    UIScrollView *scrolContent;
    UIScrollView *scrolltabBar;
    UIScrollView *scrolMain;
    int buttonId;
    UIButton *BtnCategory;
    UILabel *showBoder;
    NSMutableArray *optionsAry;
    NSMutableArray *sizeOfx;
    UITableView *exteriorTbl ,*interiorTbl,*videoTbl;

}
@property (nonatomic,strong) NSMutableArray *arrImgExterior;
@property (nonatomic,strong) NSMutableArray *arrImgInterior;
@property (nonatomic,strong) NSMutableArray *arrImgVideo;
@end
