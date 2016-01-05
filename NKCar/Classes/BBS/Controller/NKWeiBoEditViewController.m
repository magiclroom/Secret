//
//  NKWeiBoEditViewController.m
//  NKCar
//
//  Created by J on 15/11/14.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKWeiBoEditViewController.h"
#import "NKTextView.h"
#import "NKEditKeywordToolbar.h"
#import "NKWeiBoImageView.h"

@interface NKWeiBoEditViewController ()<NKEditKeywordToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>

@property (nonatomic,weak)UIImage *image;
@property (nonatomic,strong)NKWeiBoImageView *imageView;
@property (nonatomic,strong)NSString *picturePath;
@end

@implementation NKWeiBoEditViewController

#pragma mark -初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUPTitleView];
    [self.weiboTextView becomeFirstResponder];
    
}

- (void)setUPTitleView
{
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, NKSCREEN_W, 44)];
    titleView.userInteractionEnabled = YES;
    titleView.image = [UIImage imageNamed:@"navigationbarBackgroundWhite"];
    [self.view addSubview:titleView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.left.equalTo(titleView.mas_left).offset(10);
        make.centerY.equalTo(titleView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    NSString *title = @"发微博\nNK";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:title];
    NSMutableDictionary *topDict = [NSMutableDictionary dictionary];
    topDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    topDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    NSMutableDictionary *buttomDict = [NSMutableDictionary dictionary];
    buttomDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    buttomDict[NSForegroundColorAttributeName] = NKBlueColor;
    [attributed addAttributes:topDict range:NSMakeRange(0, title.length)];
    [attributed addAttributes:buttomDict range:NSMakeRange(4, 2)];
    
    titleLabel.attributedText = attributed;
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(titleView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sendBtn addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:sendBtn];
    [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        make.right.equalTo(titleView.mas_right).offset(-10);
        make.centerY.equalTo(titleView);
    }];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, NKSCREEN_W, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [self.view addSubview:lineView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, NKSCREEN_W, 300)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];

    NKTextView *weiboTextView = [[NKTextView alloc] initWithFrame:tableView.bounds];
    self.weiboTextView = weiboTextView;
    weiboTextView.delegate = self;
    weiboTextView.selectedRange = NSMakeRange(0, 0);
    NKEditKeywordToolbar *toolbar = (NKEditKeywordToolbar *)weiboTextView.inputAccessoryView;
    toolbar.delegateToolbar = self;
    self.weiboTextView = weiboTextView;
    [tableView addSubview:weiboTextView];
    
    UILabel *text_label = [[UILabel alloc] init];
    self.text_label = text_label;
    [text_label setText:@"分享生活..."];
    text_label.font = [UIFont fontWithName:@"Arial" size:16];
    [text_label setTextColor:[UIColor grayColor]];
    [weiboTextView addSubview:text_label];
    [text_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weiboTextView.mas_top).offset(2);
        make.left.equalTo(weiboTextView.mas_left).offset(5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark -操作
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        self.text_label.hidden = NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.text_label.hidden = YES;
    if (textView.text.length == 0) {
         self.text_label.hidden = NO;
    }
}

//点击编辑键盘照片按钮
- (void)editWithPhotoBtnDidClick:(NKEditKeywordToolbar *)toolbar
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}

//点击编辑键盘取消按钮
- (void)editWithExitBtnDidClick:(NKEditKeywordToolbar *)toolbar
{
    [self.view endEditing:YES];
}


//从相册获取照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    static NSInteger i = 1;
    UIImage *image = info[UIImagePickerControllerEditedImage];
    image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(210.0, 210.0)];
    [self saveImage:image WithName:[NSString stringWithFormat:@"weibo%ld.png",i]];
    
    
    NKWeiBoImageView *imageView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NKWeiBoImageView class]) owner:nil options:nil] lastObject];
    self.imageView = imageView;
    imageView.frame = CGRectMake(20, 200, 80, 80);
    [self.view addSubview:imageView];
    if (image) {
        imageView.weiboImage = image;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
//    NKLog(@"%@",info[UIImagePickerControllerReferenceURL]);
    
    i++;
}
//重绘图片
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//存储图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *picturePath = [filePath stringByAppendingPathComponent:imageName];
    self.picturePath = picturePath;
    [imageData writeToFile:picturePath atomically:NO];
}

//点击发送按钮
- (void)sendClick
{
    NSMutableDictionary *weiboDict = [NSMutableDictionary dictionary];
    weiboDict[@"icon"] = @"car-5";
    weiboDict[@"name"] = @"nk";
    weiboDict[@"vip"] = @"1";
    weiboDict[@"text"] = self.weiboTextView.text;
  

        if (self.imageView.weiboImage) {
            weiboDict[@"picture"] = self.picturePath;
           
        }
        if (self.pictureName) {
            if (!self.imageView.weiboImage) {
                weiboDict[@"picture"] = self.pictureName;
            }
        }
    
   
    NSString *fullPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filename=[fullPath stringByAppendingPathComponent:@"statuses.plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filename];
    [dataArray insertObject:weiboDict atIndex:0];
    [dataArray writeToFile:filename atomically:YES];
    
    if ([_delegate respondsToSelector:@selector(sendBtnDidClick:addDict:)]) {
        [_delegate sendBtnDidClick:self addDict:weiboDict];
    }
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击取消按钮
- (void)cancelClick
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
