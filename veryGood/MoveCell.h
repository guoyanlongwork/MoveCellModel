//
//  MoveCell.h
//  veryGood
//
//  Created by dllo on 16/11/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveCell : UITableViewCell

- (void)cellGetImage:(NSString *)str tag:(NSInteger)tag;

- (void)cellOffsetOnTabelView:(UITableView *)tabelView;

@end
