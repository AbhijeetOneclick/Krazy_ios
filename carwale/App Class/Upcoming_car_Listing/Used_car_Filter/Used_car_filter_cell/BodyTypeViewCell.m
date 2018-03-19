//
//  BodyTypeViewCell.m
//  carwale
//
//  Created by One Click IT Consultancy  on 1/5/18.
//  Copyright © 2018 One Click IT Consultancy . All rights reserved.
//

#import "BodyTypeViewCell.h"

@implementation BodyTypeViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [self  setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self                       setBackgroundColor:[UIColor colorWithRed:223.0/265.0 green:224.0/265.0 blue:224.0/265.0 alpha:0.5]];
        [self.contentView           setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath
{
    NSLog(@"arrTemp==%@",arrTemp);
    int BoxX=10,hPadding=4;
    int Y=4;
    
    int BoxWidth=DEVICE_WIDTH/3-8;
    int BoxHeight=80;
    
    int noOfCol = IS_IPAD ?3:3;
    
    //    float BoxWidth=DEVICE_WIDTH/3;
    //    float BoxHeight=50;
    //
    //    int noOfCol = IS_IPAD ?2:3;
    int GalleryRow =((indexPath.row)* noOfCol);
    //int BoxX=0;
    for (int i=0; i<noOfCol; i++,GalleryRow++)
    {
        if (GalleryRow >= [arrTemp count]) {
            return;
        }
        
        UIView *box1             =[[UIView alloc] initWithFrame:CGRectMake(BoxX, Y, BoxWidth, BoxHeight-4)]; //+10
        [box1  setBackgroundColor:[UIColor whiteColor]];
        [self.contentView        addSubview:box1];
        
        // int X=0, Y=0,hPadding=0;
        UIImageView *imgGallery1;
        
        if(i == 1)
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22,5,44, 44)];
        }
        else if(i == 2)
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22, 5,44, 44)];
        }
        else
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22, 5,44, 44)];
        }
        imgGallery1.clipsToBounds = YES;
        //        NSURL *image = [NSURL URLWithString: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Fule_type_image"]];
        
        [imgGallery1 setContentMode:UIViewContentModeScaleAspectFit];
        [box1 addSubview:imgGallery1];
        
        UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-40, 55, 80, 20)];
        lblType.text = [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"body_type_name"];
        lblType.textAlignment =NSTextAlignmentCenter;
        lblType.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        
        if([[[arrTemp objectAtIndex:GalleryRow]valueForKey:@"isSelect"] isEqualToString:@"No"])
        {
            lblType.textColor = Label_title_color;
            imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Body_type_image_unselected"]];
            NSLog(@"Goingin==>");
            
        }
        else
        {
            lblType.textColor = [UIColor blackColor];
            lblType.font = [UIFont boldSystemFontOfSize:12.0];
            imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Body_type_image_selected"]];
            NSLog(@"Goinginout==>");
            
        }
        [box1 addSubview:lblType];
        
        UIButton *btnSelectFuleType = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, box1.frame.size.width, box1.frame.size.height)];
        btnSelectFuleType.backgroundColor = [UIColor clearColor];
        btnSelectFuleType.tag = GalleryRow;
        [btnSelectFuleType addTarget:self.eventHandler action:@selector(selectBodyType:) forControlEvents:UIControlEventTouchUpInside];
        [box1 addSubview:btnSelectFuleType];
        
        BoxX=BoxX + BoxWidth+hPadding;
    }
}
-(IBAction)selectBodyType:(id)sender
{
    
    NSLog(@"hellomyapp:");
}

@end
