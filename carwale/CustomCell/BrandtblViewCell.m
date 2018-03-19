//
//  BrandtblViewCell.m
//  carwale
//
//  Created by Lubhna Shirvastava on 08/12/17.
//  Copyright © 2017 One Click IT Consultancy . All rights reserved.
//

#import "BrandtblViewCell.h"

@implementation BrandtblViewCell
@synthesize BrandButton1;
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
    int BoxHeight;
    int BoxWidth;
    if([[TSLanguageManager selectedLanguage] isEqualToString:@"en"])
    {
        BoxX=5,hPadding=5;
    }
    else
    {
        if(IS_IPAD)
        {
            BoxX=(DEVICE_WIDTH-(DEVICE_WIDTH/3)),hPadding=5;
        }else{
            BoxX=(DEVICE_WIDTH-(DEVICE_WIDTH/2)),hPadding=5;
        }
    }
    int Y=5;
   
    
    BoxHeight=50;
    int noOfCol;
    if(IS_IPAD)
    {
        noOfCol = 3;
         BoxWidth=DEVICE_WIDTH/3-10;
    }
    else{
        noOfCol = 2;
        BoxWidth=DEVICE_WIDTH/2-10;
    }
    ;
    
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
        UIView *box1             =[[UIView alloc] initWithFrame:CGRectMake(BoxX, Y, BoxWidth, BoxHeight-2)]; //+10
        [box1  setBackgroundColor:[UIColor clearColor]];
        [self.contentView        addSubview:box1];
        
        // int X=0, Y=0,hPadding=0;
        
        
        if(i == 0)
        {
            BrandButton1 = [[UIButton alloc] initWithFrame:CGRectMake(10,Y,box1.frame.size.width-20, 40)];
        }
        else if(i == 1)
        {
            BrandButton1 = [[UIButton alloc] initWithFrame:CGRectMake(10,Y,box1.frame.size.width-20, 40)];
        }
        else if(i == 2)
        {
            BrandButton1 = [[UIButton alloc] initWithFrame:CGRectMake(10,Y,box1.frame.size.width-20, 40)];
        }
        else if(i==3)
        {
            BrandButton1 = [[UIButton alloc] initWithFrame:CGRectMake(10,Y,box1.frame.size.width-20, 40)];
        }
        else
        {
            BrandButton1 = [[UIButton alloc] initWithFrame:CGRectMake(10,Y,box1.frame.size.width-20, 40)];
        }
        
        [BrandButton1 setTitle: [[arrTemp objectAtIndex:GalleryRow] valueForKey:@"brand_name"] forState:UIControlStateNormal];
        BrandButton1.tag = GalleryRow;
         [BrandButton1 addTarget:self.eventHandler action:@selector(selectBrand:) forControlEvents:UIControlEventTouchUpInside];
        
        if([[[arrTemp objectAtIndex:GalleryRow]valueForKey:@"isSelect"] isEqualToString:@"No"])
            {
                [BrandButton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                BrandButton1.titleLabel.font = [UIFont systemFontOfSize:10.0];
                BrandButton1.backgroundColor = [UIColor clearColor];
                BrandButton1.layer.cornerRadius = 20;
                BrandButton1.layer.borderWidth = 1.0f;
                BrandButton1.layer.borderColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1].CGColor;
                
            }
            else
            {
                [BrandButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                BrandButton1.titleLabel.font = [UIFont systemFontOfSize:10.0];
                BrandButton1.backgroundColor = [UIColor clearColor];
                BrandButton1.layer.cornerRadius = 20;
                BrandButton1.layer.borderWidth = 1;
                BrandButton1.layer.borderColor = [UIColor blackColor].CGColor;
        
            }
        [box1 addSubview:BrandButton1];
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
-(IBAction)selectBrand:(id)sender
{
    NSLog(@"hellomyapp:");
}


@end
