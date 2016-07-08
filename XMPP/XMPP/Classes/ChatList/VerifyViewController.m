//
//  VerifyViewController.m
//  XMPP
//
//  Created by 超级腕电商 on 16/6/4.
//  Copyright © 2016年 超级腕电商. All rights reserved.
//

#import "VerifyViewController.h"

@interface VerifyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UITableView*_tableView;
    
   
}
 @property(nonatomic,strong)NSMutableArray*dataArray;
@end

@implementation VerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证信息";
    [self createTableView];
    
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)createTableView{
    CGFloat viewWidth  = screenWidth;
    CGFloat viewHeight = screenHeight-navBarHeight-statusBarHeight-tabBarHeight;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
}
-(void)loadData
{
    self.dataArray=[ZCXMPPManager sharedInstance].subscribeArray;
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        //同意
        UIButton * agree = [UIButton buttonWithType:UIButtonTypeCustom];
        agree.frame = CGRectMake(WIDTH-80, 10, 80, 30);
        [agree setTitle:@"同意" forState:UIControlStateNormal];
        [agree addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
        [agree setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [cell.contentView addSubview:agree];
        //拒绝
        UIButton * reject = [UIButton buttonWithType:UIButtonTypeCustom];
        reject.frame = CGRectMake(WIDTH-130, 10, 80, 30);
        [reject setTitle:@"拒绝" forState:UIControlStateNormal];
        [reject addTarget:self action:@selector(rejectClick:) forControlEvents:UIControlEventTouchUpInside];
        [reject setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:reject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        
    }
    //cell.textLabel.textColor=[ThemeManager themeColorStrToColor:kTableViewCellTextLabelTextColorNormal];
    
    cell.contentView.tag=indexPath.row;
    XMPPPresence * presence=self.dataArray[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@请求加你为好友",presence.from.user] ;
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)agreeClick:(UIButton*)button{
    XMPPPresence * presence=self.dataArray[button.superview.tag];
    //同意
    [[ZCXMPPManager sharedInstance] agreeRequest:presence.from.user];
    
    [_tableView reloadData];
}
-(void)rejectClick:(UIButton*)button{
    XMPPPresence * presence=self.dataArray[button.superview.tag];
    //拒绝
    [[ZCXMPPManager sharedInstance] reject:presence.from.user];
    
    [_tableView reloadData];
    
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

@end
