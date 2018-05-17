//
//  ViewController.m
//  GeneralExample
//
//  Created by pxh on 2018/5/16.
//  Copyright © 2018年 pxh. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [FMDBManager creatTableWithTableName:@"Person" arFields:@[@"name",@"age",@"sex"] arFieldsType:@[@"text",@"text",@"text"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
