//
//  MasterViewController.m
//  WinPhone
//
//  Created by guodong on 16/1/1.
//  Copyright © 2016年 nonobank. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
//#import <FrameShellTest/Shell.h>
#import <FrameShellTest/Shell.h>
//、#import "FMDeviceManager.h"
#import "MobClick.h"


@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

//-(void)initTd
//{
//    // 获取设备管理器实例
//
//    FMDeviceManager_t *manager = [FMDeviceManager sharedManager];
//
//    // 准备SDK初始化参数
//
//    NSMutableDictionary *options = [NSMutableDictionary dictionary];
//
//    // SDK具有防调试功能，当使用xcode运行时，请取消此行注释，开启调试模式
//
//    // 否则使用xcode运行会闪退，(但直接在设备上点APP图标可以正常运行)
//
//    // 上线Appstore的版本，请记得删除此行，否则将失去防调试防护功能！
//
//     [options setValue:@"allowd" forKey:@"allowd"];  // TODO
//
//    // 指定对接同盾的测试环境，正式上线时，请删除或者注释掉此行代码，切换到同盾生产环境
//
//    //[options setValue:@"sandbox" forKey:@"env"]; // TODO
//
//    // 指定合作方标识
//
//    [options setValue:@"nonobank" forKey:@"partner"];
//
//    // 使用上述参数进行SDK初始化
//
//    manager->initWithOptions(options);
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initTd];

    [MobClick startWithAppkey:@"123123"];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    
    Shell *ctrl = [[Shell alloc] init];
    [ctrl add:3 :5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
