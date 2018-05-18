//
//  MainVC.m
//  GeneralExample
//
//  Created by pxh on 2018/5/18.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "MainVC.h"

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;

@property(nonatomic,strong)NSDictionary* data;
@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开发示例";
    self.data = @{@"数据存储":@[@"FMDB"]};
    [self configureTableview];
}

- (void)configureTableview{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = UIColor.lightGrayColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK:--UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.data.allKeys[section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = (NSArray* )[self.data allValues][section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray* array = (NSArray* )[self.data allValues][indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

@end
