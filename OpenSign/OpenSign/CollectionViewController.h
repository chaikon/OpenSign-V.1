//
//  CollectionViewController.h
//  OpenSign
//
//  Created by Alexander Chai on 3/5/16.
//  Copyright © 2016 chaikon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
- (IBAction)switchList:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchTab;
- (IBAction)reload:(id)sender;

@end
