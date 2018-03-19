//
//  FuleTypeTableViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 08/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "FuleTypeTableViewCell.h"

@implementation FuleTypeTableViewCell

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
        NSLog(@"arrTemp==%@",arrTemp);
    int BoxX,hPadding;
    int BoxWidth;
    if(IS_IPAD)
    {
        BoxWidth=DEVICE_WIDTH/5;
    }else{
        BoxWidth=DEVICE_WIDTH/3;
    }
    int BoxHeight=80;
    
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
    BoxX=5,hPadding=5;
    }
    else
    {
        NSLog(@"%f",DEVICE_WIDTH);
        NSLog(@"%f",self.contentView.frame.size.width);
       
        BoxX=DEVICE_WIDTH-BoxWidth;
        hPadding=5;
    }

    int Y=5;
    
  
    
    int noOfCol;
    
    if(IS_IPAD)
    {
        noOfCol = 5;
    }else{
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
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22, 0,44, 44)];
        }
        else
        {
            imgGallery1 = [[UIImageView alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-22, 0,44, 44)];
        }
        imgGallery1.clipsToBounds = YES;
//        NSURL *image = [NSURL URLWithString: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Fule_type_image"]];
       
        [imgGallery1 setContentMode:UIViewContentModeScaleAspectFit];
        [box1 addSubview:imgGallery1];
        
        UILabel *lblType = [[UILabel alloc] initWithFrame:CGRectMake(box1.frame.size.width/2-40, 50, 80, 20)];
        lblType.text = [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Fule_name"];
        lblType.textAlignment =NSTextAlignmentCenter;
        lblType.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        
        if([[[arrTemp objectAtIndex:GalleryRow]valueForKey:@"isSelect"] isEqualToString:@"No"])
        {
            lblType.textColor = [UIColor lightGrayColor];
             imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Fule_type_image"]];
            NSLog(@"Goingin==>");
            
        }
        else
        {
            lblType.textColor = [UIColor blackColor];
            lblType.font = [UIFont boldSystemFontOfSize:12.0];
             imgGallery1.image = [UIImage imageNamed: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"Selected_Fule_type_image"]];
            NSLog(@"Goinginout==>");

        }
        [box1 addSubview:lblType];
        
        UIButton *btnSelectFuleType = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, box1.frame.size.width, box1.frame.size.height)];
        btnSelectFuleType.backgroundColor = [UIColor clearColor];
        btnSelectFuleType.tag = GalleryRow;
        [btnSelectFuleType addTarget:self.eventHandler action:@selector(selectFuleType:) forControlEvents:UIControlEventTouchUpInside];
        [box1 addSubview:btnSelectFuleType];
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
-(IBAction)selectFuleType:(id)sender
{
    
    NSLog(@"hellomyapp:");
}

@end
