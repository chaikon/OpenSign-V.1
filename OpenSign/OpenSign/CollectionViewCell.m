//
//  CollectionViewCell.m
//  OpenSign
//
//  Created by Alexander Chai on 3/6/16.
//  Copyright © 2016 chaikon. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

-(void)setLab:(NSString *)label withDesc:(NSString *)desclab{
    self.titleLabel.text = label;
    self.descLabel.text = desclab;
}



@end
