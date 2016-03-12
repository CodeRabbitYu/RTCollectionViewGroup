//
//  GroupSection.h
//  RTCollectionViewGroup
//
//  Created by Rabbit on 16/3/12.
//  Copyright © 2016年 Rabbit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupSection : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *sectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;
@end
