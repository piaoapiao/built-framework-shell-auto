//
//  DetailViewController.h
//  WinPhone
//
//  Created by guodong on 16/1/1.
//  Copyright © 2016年 nonobank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

