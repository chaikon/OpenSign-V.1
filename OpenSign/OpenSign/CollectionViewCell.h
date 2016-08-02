//
//  CollectionViewCell.h
//  OpenSign
//
//  Created by Alexander Chai on 3/6/16.
//  Copyright © 2016 chaikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

-(void)setLab:(NSString *)label withDesc:(NSString *)desclab;

@end
