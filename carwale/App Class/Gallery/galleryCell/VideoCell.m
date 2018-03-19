//
//  VideoCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/24/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "VideoCell.h"

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [self  setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self                       setBackgroundColor:[UIColor clearColor]];
        [self.contentView           setBackgroundColor:[UIColor clearColor]];

    }
    return self;
}
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath
{
    int BoxX,hPadding;
    int BoxHeight;
    int BoxWidth;

    BoxX=14,hPadding=10;

    int Y=4;


    BoxHeight=224;
    int noOfCol;
    if(IS_IPAD)
    {
        noOfCol = 2;
        BoxWidth=DEVICE_WIDTH/2-21;

    }
    else{
        noOfCol = 1;
         BoxWidth=DEVICE_WIDTH-28;
    }

    int GalleryRow =((indexPath.row)* noOfCol);
    //int BoxX=0;

    for (int i=0; i<noOfCol; i++,GalleryRow++)
    {
        if (GalleryRow >= [arrTemp count]) {
            return;
        }
        UIView *box1 =[[UIView alloc] initWithFrame:CGRectMake(BoxX, Y, BoxWidth, BoxHeight)];
        [box1  setBackgroundColor:[UIColor clearColor]];
        box1.layer.shadowColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        box1.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        box1.layer.shadowOpacity = 0.16f;
        box1.layer.borderWidth = 1.0;
        box1.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        [self.contentView addSubview:box1];

        UIImageView *imgGallery1;
        imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,box1.frame.size.width, box1.frame.size.height-39)];
        NSURL *url = [NSURL URLWithString:[arrTemp objectAtIndex:GalleryRow]];
        imgGallery1.imageURL =url ;
        imgGallery1.clipsToBounds = YES;
        [imgGallery1 setContentMode:UIViewContentModeScaleAspectFill];
        [box1 addSubview:imgGallery1];
        
        UILabel *lblVideoDetail = [[UILabel alloc] initWithFrame:CGRectMake(0,imgGallery1.frame.size.height+12,box1.frame.size.width ,15)];
        lblVideoDetail.text = @"Test";
        lblVideoDetail.textAlignment =NSTextAlignmentLeft;
        [box1 addSubview:lblVideoDetail];
       
        
       /* UIButton *btnSelectFuleType = [[UIButton alloc]initWithFrame:CGRectMake(0,0,imgGallery1.frame.size.width, box1.frame.size.height) ];
        btnSelectFuleType.backgroundColor = [UIColor clearColor];
        btnSelectFuleType.tag = GalleryRow;
        [btnSelectFuleType addTarget:self.eventHandler action:@selector(btnExteriorImgClicked:) forControlEvents:UIControlEventTouchUpInside];
        [box1 addSubview:btnSelectFuleType];*/
        if(IS_IPAD)
        {
        BoxX=BoxX + BoxWidth+hPadding;
        }else{

        }
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
