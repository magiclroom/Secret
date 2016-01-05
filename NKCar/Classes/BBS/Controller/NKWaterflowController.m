//
//  NKLookingForBBS.m
//  XCar
//
//  Created by 牛康康 on 15/10/24.
//  Copyright © 2015年 牛康康. All rights reserved.
//

#import "NKWaterflowController.h"
#import "NKWaterFlowLayout.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "NKWaterflowCollectionViewCell.h"
#import "NKWaterflowPicture.h"
#import "NKNetworkTool.h"
#import "UIImageView+WebCache.h"
#import <Photos/Photos.h>
#import "MBProgressHUD+NK.h"


@interface NKWaterflowController () <UICollectionViewDataSource,NKWaterFlowLayoutDelegate,NKWaterflowCollectionViewCellDelegate>
/** 图片数组*/
@property (nonatomic,strong)NSMutableArray *pictureArray;
@property (nonatomic,weak)UICollectionView *collectionView;
/** 数据*/
@property (nonatomic,strong)NSMutableDictionary *dataDict;
/** 加载的页数*/
@property (nonatomic,assign)NSInteger number;
/** 图片尺寸数组*/
@property (nonatomic,strong)NSMutableArray *sizeArray;
/** 大图*/
@property (nonatomic,weak)UIImageView *bigImageView;
/** 原图*/
@property (nonatomic,weak)UIImageView *imageView;

@end


@implementation NKWaterflowController

static NSString * const NKPictureID = @"picture";
static NSString *NKAssetCollectionTitle = @"NKCar";

#pragma mark -懒加载
/*
**
*
*
*  向服务器请求的参数信息
*/
- (NSMutableDictionary *)dataDict
{
    if (!_dataDict) {
        _dataDict = [NSMutableDictionary  dictionary];
        _dataDict[@"page"] = @1;
        _dataDict[@"rows"] = @20;
    }
    return _dataDict;
}

- (NSMutableArray *)pictureArray
{
    if (!_pictureArray) {
        
        NSMutableArray *pictureArray = [NSMutableArray array];
        _pictureArray = pictureArray;
    }
    return _pictureArray;
}

- (NSMutableArray *)sizeArray
{
    if (!_sizeArray) {
        
        NSMutableArray *sizeArray = [NSMutableArray array];
        _sizeArray = sizeArray;
    }
    return _sizeArray;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLayout];
    [self setUPMorePicture];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}


//设置上拉刷新
-(void) setUPMorePicture
{
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMorePicture)];
    self.collectionView.footer.hidden = YES;
    [self.collectionView.footer beginRefreshing];
}


- (void)requestMorePicture
{

    [self.sizeArray addObjectsFromArray:[self setUPSizeArray]];

    self.number += 1;
    self.dataDict[@"page"] = @(self.number);
    [[[AFHTTPSessionManager manager] GET:@"http://www.tngou.net/tnfs/api/list" parameters:self.dataDict success:^ void(NSURLSessionDataTask * __nonnull task, id  __nonnull responseObject) {
        
        NSArray *pictureInfos = [NKWaterflowPicture objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        [self.pictureArray addObjectsFromArray:pictureInfos];
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask * __nonnull task, NSError * __nonnull error) {
        
    }] resume];
    
}

- (NSMutableArray *)setUPSizeArray
{
    NSMutableArray *dictArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        CGFloat pictureW = 100 + arc4random_uniform(50);
        CGFloat pictureH = 150 + arc4random_uniform(50);
        NSString *sizeW= [NSString stringWithFormat:@"%f",pictureW];
        NSString *sizeH= [NSString stringWithFormat:@"%f",pictureH];
        NSDictionary *dict = @{@"w":sizeW,@"h":sizeH};
        [dictArray addObject:dict];
    }
    return dictArray;
}

- (void)setupLayout
{
    // 创建布局
    NKWaterFlowLayout *layout = [[NKWaterFlowLayout alloc] init];
    layout.delegate = self;
    
    // 创建CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NKWaterflowCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NKPictureID];
    
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.pictureArray.count == 0;
    return self.pictureArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKWaterflowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NKPictureID forIndexPath:indexPath];
    cell.delegate = self;
    cell.picture = self.pictureArray[indexPath.item];
    
    return cell;
}

#pragma mark - <CYWaterflowLayoutDelegate>
- (CGFloat)waterflowLayout:(NKWaterFlowLayout *)waterflowLayout heightForItemIndex:(NSInteger)index itemWidth:(CGFloat)itemWidth
{
    NSDictionary *dict = self.sizeArray[index];
    //    NKLog(@"%@,%@",[dict[@"w"],[dict[@"h"]);

    CGFloat pictureW = [dict[@"w"] doubleValue];
    CGFloat pictureH = [dict[@"h"] doubleValue];
    //    NKLog(@"%f,%f,%ld",pictureW,pictureH,index);
    return itemWidth * pictureH / pictureW;

}

- (CGFloat)rowMarginInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout
{
    return 10;
}

- (NSInteger)columnCountInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout
{
    //    if (self.shops.count <= 50) return 2;
    return 3;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(NKWaterFlowLayout *)waterflowLayout
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark -点击图片
- (void)imageViewClick:(NKWaterflowCollectionViewCell *)cell withImageView:(UIImageView *)imageView withImagePath:(NSString *)picturePath
{
    
    imageView.userInteractionEnabled = NO;
    self.imageView = imageView;
    
    UIImageView *bigImageView = [[UIImageView alloc] init];
    [bigImageView sd_setImageWithURL:[NSURL URLWithString:picturePath]];
    [[UIApplication sharedApplication].keyWindow addSubview:bigImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smallPicture)];
    bigImageView.userInteractionEnabled = YES;
    [bigImageView addGestureRecognizer:tap];
    self.bigImageView = bigImageView;
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    saveBtn.layer.cornerRadius = 3;
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    saveBtn.alpha = 0.0;
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bigImageView addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(savePicture) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
        make.right.equalTo(bigImageView.mas_right).offset(-30);
        make.bottom.equalTo(bigImageView.mas_bottom).offset(-25);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat imageViewW = NKSCREEN_W;
        CGFloat imageViewH = NKSCREEN_H;
        CGFloat imageViewX = 0;
        CGFloat imageViewY = 0;
        bigImageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);

    } completion:^(BOOL finished) {
        saveBtn.alpha = 1.0;
    }];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

//图片缩小
- (void)smallPicture
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bigImageView.center = CGPointMake(0, 0);
        self.bigImageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
     [self.bigImageView removeFromSuperview];
     self.imageView.userInteractionEnabled = YES;
    }];
}

//保存图片
- (void)savePicture
{
    /*
     PHAuthorizationStatusNotDetermined,     用户还没有做出选择
     PHAuthorizationStatusDenied,            用户拒绝当前应用访问相册(用户当初点击了"不允许")
     PHAuthorizationStatusAuthorized         用户允许当前应用访问相册(用户当初点击了"好")
     PHAuthorizationStatusRestricted,        因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
     */
    
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 因为家长控制, 导致应用无法方法相册(跟用户的选择没有关系)
        [MBProgressHUD showError:@"因为系统原因, 无法访问相册"];
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前应用访问相册(用户当初点击了"不允许")
        NKLog(@"提醒用户去[设置-隐私-照片-xxx]打开访问开关");
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册(用户当初点击了"好")
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                [self saveImage];
            }
        }];
    }

}

- (void)saveImage
{
    // PHAsset : 一个资源, 比如一张图片\一段视频
    // PHAssetCollection : 一个相簿
    
    // PHAsset的标识, 利用这个标识可以找到对应的PHAsset对象(图片对象)
    __block NSString *assetLocalIdentifier = nil;
    
    // 如果想对"相册"进行修改(增删改), 那么修改代码必须放在[PHPhotoLibrary sharedPhotoLibrary]的performChanges方法的block中
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.保存图片A到"相机胶卷"中
        // 创建图片的请求
        assetLocalIdentifier = [PHAssetChangeRequest creationRequestForAssetFromImage:self.bigImageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError *error) {
        if (success == NO) {
            [self showError:@"保存图片失败!"];
            return;
        }
        
        // 2.获得相簿
        PHAssetCollection *createdAssetCollection = [self createdAssetCollection];
        if (createdAssetCollection == nil) {
            [self showError:@"创建相簿失败!"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            // 3.添加"相机胶卷"中的图片A到"相簿"D中
            
            // 获得图片
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetLocalIdentifier] options:nil].lastObject;
            
            // 添加图片到相簿中的请求
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdAssetCollection];
            
            // 添加图片到相簿
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError *error) {
            if (success == NO) {
                [self showError:@"保存图片失败!"];;
            } else {
                [self showSuccess:@"保存图片成功!"];;
            }
        }];
    }];
}



/**
 *  获取曾经创建过的相册
 */
- (PHAssetCollection *)createdAssetCollection
{
    PHFetchResult *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:NKAssetCollectionTitle]) {
            return assetCollection;
        }
    }
    // 没有找到对应的相簿, 得创建新的相簿
    
    // 错误信息
    NSError *error = nil;
    
    // PHAssetCollection的标识, 利用这个标识可以找到对应的PHAssetCollection对象(相簿对象)
    __block NSString *assetCollectionLocalIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 创建相簿的请求
        assetCollectionLocalIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:NKAssetCollectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    
    // 如果有错误信息
    if (error) return nil;
    
    // 获得刚才创建的相簿
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionLocalIdentifier] options:nil].lastObject;
}

- (void)showSuccess:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:text];
    });
}

- (void)showError:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:text];
    });
}


@end


