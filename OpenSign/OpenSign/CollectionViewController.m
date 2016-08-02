//
//  CollectionViewController.m
//  OpenSign
//
//  Created by Alexander Chai on 3/5/16.
//  Copyright © 2016 chaikon. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"


@interface CollectionViewController ()

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

bool loadedPlist=false;

NSMutableArray *toplevel;

NSArray *nameArray;

NSMutableArray *focList;


-(NSArray *)fetchPlistArray{

    NSString *str = [[NSBundle mainBundle] pathForResource:@"locations.plist" ofType:nil];
    
    NSURL *url= [NSURL fileURLWithPath:str];
    toplevel = [[NSMutableArray alloc] initWithContentsOfURL:url];
    
    loadedPlist=true;
    return NULL;
}

-(int)timeFromString:(NSString *)str{
    NSArray *arr = [str componentsSeparatedByString:@":"];
    int hours = [[arr objectAtIndex:0] intValue];
    int min = [[arr objectAtIndex:1] intValue];
    return hours*60+min;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    if (!loadedPlist){
        [self fetchPlistArray];
    }
    
    if ([self.title isEqual:@"dining"]){
        focList = [toplevel objectAtIndex:0];
    }
    else{
        focList = [toplevel objectAtIndex:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MAX([focList count], 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int today = 0;
    NSDateFormatter* Weekformatter = [[NSDateFormatter alloc] init];
    [Weekformatter setDateFormat: @"EEEE"];
    NSString *weekdaystring = [Weekformatter stringFromDate:[NSDate date]];
                               
    if([weekdaystring isEqual:@"Sunday"]){
        today=0;
    }
    else if([weekdaystring isEqual:@"Monday"]){
        today=1;
    }
    else if([weekdaystring isEqual:@"Tuesday"]){
        today=2;
    }
    else if([weekdaystring isEqual:@"Wednesday"]){
        today=3;
    }
    else if([weekdaystring isEqual:@"Thursday"]){
        today=4;
    }
    else if([weekdaystring isEqual:@"Friday"]){
        today=5;
    }
    else if([weekdaystring isEqual:@"Saturday"]){
        today=6;
    }
    
    NSString *desctex;
    CollectionViewCell *cell;
    
    
    if ([[[focList objectAtIndex:indexPath.row] objectAtIndex:today] isEqual:@"x"]){
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"closedCell" forIndexPath:indexPath];
        desctex=@"Closed Today";
        
        
    }
    else{
        
        NSString *openTimeStr;
        NSString *closeTimeStr;
    
        NSArray *timeArray = [[[focList objectAtIndex:indexPath.row] objectAtIndex:today] componentsSeparatedByString:@"-"];
        openTimeStr = [timeArray objectAtIndex:0];
        closeTimeStr = [timeArray objectAtIndex:1];
        
        NSDateFormatter *timFormatter = [[NSDateFormatter alloc] init];
        [timFormatter setDateFormat:@"HH:mm"];
        NSString *nowString = [timFormatter stringFromDate:[NSDate date]];
//        nowString=@"20:33";
        
        
        int opentime = [self timeFromString:openTimeStr];
        int closetime = [self timeFromString:closeTimeStr];
        int nowint = [self timeFromString:nowString];

        
        if (closetime<=opentime){
            closetime=closetime+1440;
        }
        
        if (nowint<opentime){
            nowint+=1440;
        }
            
        BOOL open =true;
            
        
        
        if ((nowint<closetime)&&(nowint>opentime)){
            open=TRUE;
        }
        else{
            open=FALSE;
        }

        
        
        
        
        if (open){
            
            cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"openCell" forIndexPath:indexPath];
            desctex=[@"Closes at " stringByAppendingString:closeTimeStr];
        }
        
        else{
            
            cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"closedCell" forIndexPath:indexPath];
            desctex=[@"Opens at " stringByAppendingString:openTimeStr];
            
        }
    }
    
    
    // Configure the cell
    
    
    if (indexPath.row<[focList count]){
        NSString *labtex = [[focList objectAtIndex:indexPath.row] objectAtIndex:7];
    
        [cell setLab:labtex withDesc:desctex];
        
    }


    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)switchList:(id)sender {
    focList = [toplevel objectAtIndex:self.switchTab.selectedSegmentIndex];
    [self.collectionView reloadData];
}
- (IBAction)reload:(id)sender {
    
    if ([self.title isEqual:@"dining"]){
        focList = [toplevel objectAtIndex:0];
    }
    else{
        focList = [toplevel objectAtIndex:1];
    }
    
    [self.collectionView reloadData];
}
@end
