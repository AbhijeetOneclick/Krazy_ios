//
//  ExteriorIMGCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/23/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "ExteriorIMGCell.h"

@implementation ExteriorIMGCell

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

    BoxX=2,hPadding=2;

    int Y=4;


    BoxHeight=110;
    int noOfCol;
    if(IS_IPAD)
    {
        noOfCol = 3;
        BoxWidth=DEVICE_WIDTH/3-4;
    }
    else{
        noOfCol = 2;
        BoxWidth=DEVICE_WIDTH/2-4;
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
        imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,box1.frame.size.width, box1.frame.size.height)];
        NSURL *url = [NSURL URLWithString:[arrTemp objectAtIndex:GalleryRow]];
        imgGallery1.imageURL =url ;
        imgGallery1.clipsToBounds = YES;
        [imgGallery1 setContentMode:UIViewContentModeScaleAspectFill];
        [box1 addSubview:imgGallery1];

        UIButton *btnSelectFuleType = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, box1.frame.size.width, box1.frame.size.height)];
        btnSelectFuleType.backgroundColor = [UIColor clearColor];
        btnSelectFuleType.tag = GalleryRow;
        [btnSelectFuleType addTarget:self.eventHandler action:@selector(btnExteriorImgClicked:) forControlEvents:UIControlEventTouchUpInside];
        [box1 addSubview:btnSelectFuleType];

        BoxX=BoxX + BoxWidth+hPadding;
    }
    
    
}
-(IBAction)btnExteriorImgClicked:(id)sender{

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
