//
//  BodyTypeTableCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 07/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "BodyTypeTableCell.h"
#import "CarBarndAndTypeCell.h"
#import "CarBrandAndTypeFlowlayout.h"
@implementation BodyTypeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIView  *lineBottom = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.contentView.frame.size.height-1,DEVICE_WIDTH, 1.0f)];
        lineBottom.hidden=NO;
        lineBottom.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        lineBottom.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        [self.contentView addSubview:lineBottom];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
-(void) setGalleryDetail:(NSArray *) arrTemp atIndexPath:(NSIndexPath *) indexPath imagePath:(NSString *) imagePath
{
    //    NSLog(@"arrTemp==%@",arrTemp);
    int BoxX,hPadding;
    int BoxWidth;
    if(IS_IPAD){
        BoxWidth=DEVICE_WIDTH/5;
    }else{
        BoxWidth=DEVICE_WIDTH/3;
    }
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        BoxX=5,hPadding=5;
    }
    else
    {
        BoxX=((DEVICE_WIDTH)-BoxWidth),hPadding=5;
    }
    int Y=5;
    
    
    int BoxHeight=80;
    
    
    int noOfCol;
    if(IS_IPAD)
    {
        noOfCol = 5;
    }else
    {
        noOfCol = 3;
    }
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
        
        UIView *box1             =[[UIView alloc] initWithFrame:CGRectMake(BoxX, Y, BoxWidth, BoxHeight)]; //+10
        [box1  setBackgroundColor:[UIColor clearColor]];
        [self.contentView        addSubview:box1];
        
       // int X=0, Y=0,hPadding=0;
        UIImageView *imgGallery1;
        
        if(i == 1)
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22,0,44, 44)];
        }
        else if(i == 2)
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22,0,44, 44)];
        }
        else
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22,0,44, 44)];
        }
        imgGallery1.clipsToBounds = YES;
       
        [imgGallery1 setContentMode:UIViewContentModeScaleAspectFit];
        [box1 addSubview:imgGallery1];
        
        UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-40, 50, 80, 20)];
        lblType.text = [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"body_type_name"];
        lblType.textAlignment =NSTextAlignmentCenter;
        lblType.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        if([[[arrTemp objectAtIndex:GalleryRow]valueForKey:@"isSelect"] isEqualToString:@"No"])
        {
            lblType.textColor = [UIColor lightGrayColor];
            imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Body_type_image_unselected"]];
        }
        else
        {
            lblType.textColor = [UIColor blackColor];
             imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Body_type_image_selected"]];
        
        }
        [box1 addSubview:lblType];
        
        UIButton *btnSelectBodyType = [[UIButton alloc] initWithFrame:CGRectMake(BoxX, Y, BoxWidth, BoxHeight)];
        btnSelectBodyType.backgroundColor = [UIColor clearColor];
        [btnSelectBodyType addTarget:self.eventHandler action:@selector(selectBodyType:) forControlEvents:UIControlEventTouchUpInside];
        btnSelectBodyType.tag = GalleryRow;
        [self.contentView addSubview:btnSelectBodyType];
        
        if([[TSLanguageManager selectedLanguage]isEqualToString:@"en"])
        {
            BoxX=BoxX + BoxWidth+hPadding;
        }
        else
        {
            BoxX= BoxX - BoxWidth-hPadding;
        }
    }
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(IBAction)selectBodyType:(id)sender
{
    NSLog(@"hellomyapp:");
}




@end
