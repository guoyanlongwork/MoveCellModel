//
//  ViewController.m
//  veryGood
//
//  Created by dllo on 16/11/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ViewController.h"
#import "MoveCell.h"

/*最小值的cell大小*/
#define SCellHeight 150
/*最大值的cell大小*/
#define BCellHeight 230
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化tableview
    [self createTabel];
    
    
}

- (void)createTabel
{
    self.tableV = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    //设置cell的上下内边距
    self.tableV.contentInset = UIEdgeInsetsMake(BCellHeight - SCellHeight, 0, self.view.frame.size.height - BCellHeight, 0);
    //取消cell边框
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableV];
    [self.tableV registerClass:[MoveCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //改变图片的坐标cell的点击方法不准确所以用手势代替
    NSLog(@"%ld", indexPath.row);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //在滑动过程中获取当前显示的所有cell, 调用偏移量的计算方法
        [[self.tableV visibleCells] enumerateObjectsUsingBlock:^(MoveCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        //cell偏移设置
        [obj cellOffsetOnTabelView:self.tableV];
        
    }];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%.2f", cell.frame.origin.y);
    //cell第一次出现时调用计算偏移量
    MoveCell *getCell = (MoveCell *)cell;
    
    [getCell cellOffsetOnTabelView:tableView];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoveCell *cell = [self.tableV dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //给获取的cell赋值图片以及给当前的imagev添加tag值
    [cell cellGetImage:[NSString stringWithFormat:@"%ld.jpg", indexPath.row]tag:indexPath.row];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
