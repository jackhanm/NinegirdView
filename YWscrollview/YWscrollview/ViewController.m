//
//  ViewController.m
//  YWscrollview
//
//  Created by yuhao on 2017/8/3.
//  Copyright © 2017年 uhqsh. All rights reserved.
//

#import "ViewController.h"
#import "YWscollview.h"
#import "DataSource.h"
#define ItemHeight 90
#define IMG(name)           [UIImage imageNamed:name]
@interface ViewController ()<YWScrollMenuProtocol,UITableViewDelegate,UITableViewDataSource>{
    
    NSInteger row;
    NSInteger item;
}

@property (nonatomic, strong) YWscollview *menu;
@property (nonatomic, strong) NSMutableArray *dataarr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self createData];;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    row = 2;
    item = 2;
    
    self.menu = [[YWscollview alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, ItemHeight *row )];
    self.menu.currentPageIndicatorTintColor = [UIColor colorWithRed:107/255.f green:191/255.f blue:255/255.f alpha:1.0];
   //如果要加pagecontroller 初始化的时候高度加16
    
    self.menu.backgroundColor = [UIColor orangeColor];
    self.menu.delegate = self;
    [self.view addSubview:self.menu];
      [self.menu reloadData];
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *Cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (Cell) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    Cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",indexPath];
    return Cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  100;
}

- (void)createData{
    
    
    NSArray *images = @[IMG(@"icon_cate"),
                        IMG(@"icon_drinks"),
                        IMG(@"icon_movie"),
                        IMG(@"icon_recreation"),
                        IMG(@"icon_stay"),
                        IMG(@"icon_ traffic"),
                        IMG(@"icon_ scenic"),
                        IMG(@"icon_fitness"),
                        IMG(@"icon_fitment"),
                        IMG(@"icon_hairdressing"),
                        IMG(@"icon_mom"),
                        IMG(@"icon_study"),
                        IMG(@"icon_travel"),
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF"];
    NSArray *titles = @[@"美食",
                        @"休闲娱乐",
                        @"电影/演出",
                        @"KTV",
                        @"酒店住宿",
                        @"火车票/机票",
                        @"旅游景点",
                        @"运动健身",
                        @"家装建材",
                        @"美容美发",
                        @"母婴",
                        @"学习培训",
                        @"旅游出行",
                        @"动态图\n从网络获取"];
     self.dataarr = [NSMutableArray array];
    for (NSUInteger idx = 0; idx< images.count; idx ++) {
        
        DataSource *object = [[DataSource alloc] init];
       
        object.text = titles[idx];
        object.image = images[idx];
        object.placeholderImage = IMG(@"placeholder");
        
        [self.dataarr addObject:object];
        
    }

    
    
}
#pragma mark - YANScrollMenuProtocol
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YWscollview *)scrollMenu{
    
    return row;
}
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YWscollview *)scrollMenu{
    
    return item;
}
- (NSUInteger)numberOfMenusInScrollMenu:(YWscollview *)scrollMenu{
    
    return self.dataarr.count;
}
- (id<YWmeunObject>)scrollMenu:(YWscollview *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    return self.dataarr[idx];
}

- (void)scrollMenu:(YWscollview *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",indexPath.section,indexPath.row,@"11"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:tips preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)reload:(id)sender {
    
    self.tableView.tableHeaderView = nil;
    
    CGRect frame = self.menu.frame;
    frame.size.height = row * ItemHeight + 16;
    self.menu.frame = frame;
    
    self.tableView.tableHeaderView = self.menu;
    
    [self.menu reloadData];
}
#pragma mark - TableView Delegate & DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            row = 1;
            item = 5;
        }
            break;
        case 1:{
            row = 2;
            item = 4;
        }
            break;
        case 2:{
            row = 2;
            item = 5;
        }
            break;
        case 3:{
            row = 3;
            item = 4;
        }
            break;
        case 4:{
            row = 3;
            item = 5;
        }
            break;
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
