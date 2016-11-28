//
//  MoveCell.m
//  veryGood
//
//  Created by dllo on 16/11/22.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "MoveCell.h"
#import "UIView+Frame.h"

#define SCellHeight 150

#define BCellHeight 230

//普通字体大小
#define FontSize 16

@interface MoveCell ()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *label;

@end
@implementation MoveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //取消cell点击的效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SCellHeight)];
        [self.contentView addSubview:self.imageV];

        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, SCellHeight)];
        self.label.numberOfLines = 0;
        self.label.font = [UIFont systemFontOfSize:FontSize];
        self.label.textAlignment =  NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        self.label.text = @"改变字体大小";
        
        //添加点击方法
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self.imageV addGestureRecognizer:tapG];
        
        
    }
    return self;
}
- (void)tapAction:(UIGestureRecognizer *)gestur
{
    NSLog(@"点击了%ld", gestur.view.tag);
}
- (void)cellOffsetOnTabelView:(UITableView *)tabelView
{
    
    CGFloat currentLocation = tabelView.contentOffset.y + BCellHeight;
    
    
    //如果超出规定的位置以 ->“上”
    if (self.frame.origin.y < tabelView.contentOffset.y + BCellHeight - SCellHeight) {
        NSLog(@"cell:%.2f", currentLocation - SCellHeight);
        self.imageV.height = BCellHeight;
        
        self.imageV.y = - (BCellHeight - SCellHeight);
       
        self.label.font = [UIFont systemFontOfSize:FontSize * 4];
        
        
    }else if (self.frame.origin.y <= currentLocation && self.frame.origin.y >= tabelView.contentOffset.y) {
        //cell开始进入规定的位置
        
        //通过绝对值 取出移动的Y值
        CGFloat moveY = ABS(self.frame.origin.y - currentLocation) / SCellHeight * (BCellHeight - SCellHeight);
        
        [[self superview] bringSubviewToFront:self];
        
        //移动的值 + cell固定高度
        self.imageV.height = SCellHeight + moveY;
        self.label.height = SCellHeight + moveY;
        //设置偏移量Y值
        self.label.y = - moveY;
        self.imageV.y = - moveY;
        //通过move改变字体的大小 倍数 与起始变化位置自己定义 这里以最大值4倍计算
        if (BCellHeight - SCellHeight > moveY && moveY > 20) {
            
            self.label.font = [UIFont systemFontOfSize:FontSize * moveY / 20];
            
        } else if (moveY <= 20)
        {
            self.label.font = [UIFont systemFontOfSize:FontSize];
        } else {
            self.label.font = [UIFont systemFontOfSize:FontSize * 4];
        }
        
        
    }else{
        //超出规定的位置以 ->“下”
        
        self.imageV.height = SCellHeight;
        
        self.imageV.y = 0;
        
        self.label.font = [UIFont systemFontOfSize:FontSize];
    }
}
- (void)cellGetImage:(NSString *)str tag:(NSInteger)tag
{
    self.imageV.tag = tag;
    self.imageV.image = [UIImage imageNamed:str];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
