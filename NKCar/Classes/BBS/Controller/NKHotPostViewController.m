//
//  NKHotPostViewController.m
//  XCar
//
//  Created by 牛康康 on 15/10/24.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKHotPostViewController.h"
#import "UIImage+NKExtension.h"
#import "NKHostPostModel.h"
#import "NKHotPostViewCell.h"
#import "MJExtension.h"
#import "NKWeiBoEditViewController.h"
#import "NKNavigationController.h"
#import "NKTalkKeywordToolbar.h"
#import "UMSocial.h"
#import "NKTextView.h"
#import "TYAlertController.h"

#define BGImageH 200
#define TitleH 44
#define BGImageMinH 64

@interface NKHotPostViewController ()<UITableViewDataSource,UITableViewDelegate,NKWeiBoEditViewControllerDelegate,NKHotPostViewCellDelegate,NKTalkKeywordToolbarDelegate>


/** 微博模型数组*/
@property (nonatomic,strong)NSMutableArray *weibo;

/** 导航栏标题*/
@property (nonatomic,weak)UILabel *name;

/** 最初偏移量*/
@property (nonatomic,assign) CGFloat oriOffSet;
@property (nonatomic,strong)UITableView *tableView;
/** 图片*/
@property (nonatomic,weak)UIImageView *bgimageView;
/** 头像*/
@property (nonatomic,weak)UIImageView *iconView;
/** 标题栏*/
@property (nonatomic,weak)UIView *selectView;
@property (nonatomic,weak)UIView *headView;
/** 发送按钮*/
@property (nonatomic,weak)UIButton *sendBtn;
/** 评论键盘tool*/
@property (nonatomic,weak)NKTalkKeywordToolbar *toolBar;
/** 评论选中cell*/
@property (nonatomic,weak)NKHotPostViewCell *talkSelectCell;
/** tableView原来偏移量*/
@property (nonatomic,assign)CGFloat offsetY;
/** 点击cell的位置*/
@property (nonatomic,assign)CGPoint point;
@end

@implementation NKHotPostViewController
#pragma mark -懒加载


//懒加载
- (NSMutableArray *)weibo
{
    
    if (!_weibo) {
        
//        _weibo = [NKHostPostModel objectArrayWithFilename:@"statuses.plist"];
        NSString *fullPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];;
        //得到完整的文件名
        NSString *filename=[fullPath stringByAppendingPathComponent:@"statuses.plist"];
        _weibo = [NKHostPostModel objectArrayWithFile:filename];
    }
    return _weibo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUPHeadImage];

    //关闭边缘边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //最初偏移量
    self.oriOffSet = -(BGImageH + TitleH);
    //额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(BGImageH+TitleH+20, 0, 69, 0);
    
    
}



//设置头部图片
- (void)setUPHeadImage{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, NKSCREEN_W, NKSCREEN_H) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor grayColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;

    
    UIView *headView = [[UIView alloc] init];
    [self.view addSubview:headView];
    _headView = headView;
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(200);
    }];
    
    //背景图片
    UIImageView *bgimageView = [[UIImageView alloc] init];
    [bgimageView setImage:[UIImage imageNamed:@"green"]];
    bgimageView.contentMode =  UIViewContentModeScaleAspectFill;
    bgimageView.clipsToBounds = YES;
    [self.headView addSubview:bgimageView];
    _bgimageView = bgimageView;
    [self.bgimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top);
        make.bottom.equalTo(headView.mas_bottom);
        make.left.equalTo(headView.mas_left);
        make.right.equalTo(headView.mas_right);

    }];

    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.layer.cornerRadius = 50;
    iconView.layer.borderWidth = 2;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    iconView.clipsToBounds = YES;
    [iconView setImage:[UIImage imageNamed:@"xiaoche"]];
    [self.headView addSubview:iconView];
    _iconView = iconView;
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.height.width.mas_equalTo(100);
        make.bottom.equalTo(headView.mas_bottom).offset(-45);
    }];
    
    //标题栏
    UIView *selectView = [[UIView alloc] init];
    selectView.backgroundColor = [UIColor colorWithRed:100 / 255.0 green:200 / 255.0 blue:237 / 255.0 alpha:0.7];
    [self.view addSubview:selectView];
    [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    //发送按钮
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.userInteractionEnabled = NO;
    UIImage *sendImage = [UIImage imageNamed:@"navigationbar_compose"];
    [sendBtn setBackgroundImage:sendImage forState:UIControlStateNormal];
    [selectView addSubview:sendBtn];
    self.sendBtn = sendBtn;
    sendBtn.alpha = 0;
    [sendBtn addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.width.height.mas_equalTo(26);
    }];
    
    //用户名
    UILabel *name = [[UILabel alloc] init];
    name.text = @"NK Car";
    name.textColor = [UIColor redColor];
    //label随字体变化
    [name sizeToFit];
    self.name = name;
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(22);
        make.top.equalTo(self.headView.mas_bottom).offset(4);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];

}

//点击发送按钮
- (void)send
{
    //移除指定的通知，不然会造成内存泄露
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NKWeiBoEditViewController *weiBoEditVC = [[NKWeiBoEditViewController alloc] init];
    weiBoEditVC.delegate = self;
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBar presentViewController:weiBoEditVC animated:YES completion:nil];

}

- (void)sendBtnDidClick:(NKWeiBoEditViewController *)weiboVC addDict:(NSMutableDictionary *)dict
{
    NKHostPostModel *model = [[NKHostPostModel alloc] init];
    model.icon = dict[@"icon"];
    model.name= dict[@"name"];
    model.vip = dict[@"vip"];
    model.text = dict[@"text"];
    model.picture = dict[@"picture"];
    [self.weibo insertObject:model atIndex:0];
    [self.tableView reloadData];
    //回到顶部
    [self.tableView setContentOffset:CGPointMake(0, -264) animated:YES];
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weibo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    NKHotPostViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NKHotPostViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.hpModel = self.weibo[indexPath.row];
    cell.index = indexPath.row;
    cell.delegate = self;

    return cell;
}

#pragma mark - 代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NKHostPostModel *hpModel = self.weibo[indexPath.row];
    return hpModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark -操作

- (void)keyBoardChange:(NSNotification *)note
{
    // 键盘的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardH = frame.size.height;
    if (self.point.y > NKSCREEN_H - keyboardH) {
      
        //键盘弹出时间
        CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        [UIView animateWithDuration:duration animations:^{
//            [self.tableView setContentOffset:CGPointMake(0, self.offsetY + keyboardH - 50)];
            [self.tableView setContentOffset:CGPointMake(0, self.offsetY + keyboardH - (NKSCREEN_H - self.point.y))];
        }];
    }
    
}


//评论
- (void)talkBtnDidClick:(NKHotPostViewCell *)cell atPoint:(CGPoint)point
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.point = point;
    self.talkSelectCell = cell;

    self.offsetY = self.tableView.contentOffset.y ;

    UITextField *textField = [[UITextField alloc] init];
    [cell addSubview:textField];
    NKTalkKeywordToolbar *toolBar = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NKTalkKeywordToolbar class]) owner:nil options:nil] lastObject];
    self.toolBar = toolBar;
    toolBar.delegateToolbar = self;
    textField.inputAccessoryView = toolBar;
    [textField becomeFirstResponder];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NKFunc;
}

//点击评论键盘发送按钮
- (void)talkWithsendBtnDidClick:(NKTalkKeywordToolbar *)toolbar
{
    //输入框文字
    NSString *text = self.toolBar.inputField.text;
    NSString *newText = [self.talkSelectCell.hpModel.text stringByAppendingString:text];
    self.talkSelectCell.hpModel.text = newText;
    //回归原来偏移量
    [self.view endEditing:YES];
    [self.tableView setContentOffset:CGPointMake(0, self.offsetY) animated:YES];
    [self.tableView reloadData];
    
    //取出沙盒中的plist文件,找到数组相对应的字典，修改数据
    NSString *fullPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    NSString *filename=[fullPath stringByAppendingPathComponent:@"statuses.plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filename];
    //获取模型对应的索引值
    NSInteger index = [self.weibo indexOfObject:self.talkSelectCell.hpModel];
    NSDictionary *dataDict = dataArray[index];
    [dataDict setValue:newText forKey:@"text"];
    [dataArray writeToFile:filename atomically:YES];
    
}

//点击评论键盘取消按钮
- (void)talkWithexitBtnDidClick:(NKTalkKeywordToolbar *)toolbar
{
    //移除指定的通知，不然会造成内存泄露
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    //回归原来偏移量
    [self.view endEditing:YES];
    [self.tableView setContentOffset:CGPointMake(0, self.offsetY) animated:YES];
    [self.tableView reloadData];
}


//转发
- (void)forwardBtnDidClick:(NKHotPostViewCell *)cell
{
    //移除指定的通知，不然会造成内存泄露
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NKWeiBoEditViewController *weiBoEditVC = [[NKWeiBoEditViewController alloc] init];
    weiBoEditVC.delegate = self;
    UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [tabBar presentViewController:weiBoEditVC animated:YES completion:nil];
    
   
    weiBoEditVC.weiboTextView.text = [NSString stringWithFormat:@"//@%@:%@",cell.hpModel.name,cell.hpModel.text];
    weiBoEditVC.weiboTextView.textColor = [UIColor blackColor];
    weiBoEditVC.pictureName= cell.hpModel.picture;
    weiBoEditVC.weiboTextView.selectedRange = NSMakeRange(0, 0);
    weiBoEditVC.text_label.textColor = [UIColor clearColor];
}

//删除
- (void)deleBtnDidClick:(NKHotPostViewCell *)cell
{
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"是否删除?" message:nil];
    
    [alertView addAction:[TYAlertAction actionWithTitle:@"删除" style:TYAlertActionStyleDestructive  handler:^(TYAlertAction *action) {
        
        [self.weibo removeObjectAtIndex:cell.index];
        [self.tableView reloadData];
        
        NSString *fullPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filename=[fullPath stringByAppendingPathComponent:@"statuses.plist"];
        NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filename];
        [dataArray removeObjectAtIndex:cell.index];
        [dataArray writeToFile:filename atomically:YES];
        
    }]];

    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
    
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleActionSheet];
    [self presentViewController:alertController animated:YES completion:nil];
}

//更多
- (void)moreBtnDidClick:(NKHotPostViewCell *)cell
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"564fc736e0f55a04dd000c42"
                                      shareText:cell.hpModel.text
                                     shareImage:[UIImage imageNamed:@"qianlanse.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToEmail,UMShareToSms,nil]
                                       delegate:self];
    
}

//滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //当前的偏移量
    CGFloat curOffSet = self.tableView.contentOffset.y;
    
    //与之前偏移量差值
    CGFloat delta = curOffSet  - self.oriOffSet;
    
    //图片高度
    CGFloat h = BGImageH - delta;
    if(h < 20) {
        h = 20;
        self.sendBtn.userInteractionEnabled = YES;
    }else {
        self.sendBtn.userInteractionEnabled = NO;
    }
    
    //高度约束
    
    [self.headView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(h);
    }];
    //导航器透明度
    CGFloat alpha = delta / (BGImageH-BGImageMinH);
    if(h < BGImageMinH) {
        h = BGImageMinH;
    }
    
    //标题颜色
    self.name.textColor = [UIColor colorWithWhite:0 alpha:alpha];
    self.sendBtn.alpha = alpha;
    
}


@end
