//
//  ViewController.m
//  RTCollectionViewGroup
//
//  Created by Rabbit on 16/3/12.
//  Copyright © 2016年 Rabbit. All rights reserved.
//

#import "ViewController.h"
#import "GroupCollectionCell.h"
#import "GroupSection.h"

#define SCREEN_WIDTH ([UIScreen  mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
//内容数组
@property (nonatomic, strong) NSMutableArray *dataArray;
//标题数组
@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) NSMutableArray *stateArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //创建CollectionView布局类的对象，UICollectionViewFlowLayout有水平和垂直两种布局方式，如果你需要做复杂的而已可以继承UICollectionViewFlowLayout创建你自己的布局类
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //指定布局方式为垂直
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 10;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
    flow.minimumInteritemSpacing = 10;//两个单元格之间的最小间距
    
    //创建CollectionView并指定布局对象
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flow];
    _collectionView.backgroundColor = [UIColor colorWithRed:239/255.0f green:239/255.0f blue:239/255.0f alpha:1.0];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    //注册用xib定制的cell，各参数的含义同UITableViewCell的注册
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"GroupCellID"];
    
    //注册用xib定制的分组脚
    //参数二：用来区分是分组头还是分组脚
    [_collectionView registerNib:[UINib nibWithNibName:@"GroupSection" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID"];
    
    NSArray *one = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSArray *two = @[@"1",@"2",@"3",@"4",@"5",@"6"];
//    _sectionArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"关闭(%ld)",one.count],[NSString stringWithFormat:@"关闭(%ld)",two.count], nil];
    _sectionArray = [NSMutableArray arrayWithObjects:@"关闭",@"关闭", nil];
    
    _dataArray = [NSMutableArray arrayWithObjects:one,two, nil];
    
    _stateArray = [NSMutableArray array];
    
    for (int i = 0; i < _dataArray.count; i++)
    {
        //所有的分区都是闭合
        [_stateArray addObject:@"0"];
    }
}

//协议的方法,用于返回section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count;
}

//协议中的方法，用于返回分区中的单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_stateArray[section] isEqualToString:@"1"]) {
        //如果是打开状态
        NSArray *arr = [_dataArray objectAtIndex:section];
        return arr.count;
    }
    else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //UICollectionViewCell里的属性非常少，实际做项目的时候几乎必须以其为基类定制自己的Cell
    GroupCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GroupCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

//协议中的方法，用于返回单元格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH / 4 - 10, SCREEN_WIDTH / 4);
}

//协议中的方法，用于返回整个CollectionView上、左、下、右距四边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右的边距
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

//协议中的方法，用来返回分组头的大小。如果不实现这个方法，- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath将不会被调用
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //宽度随便定，系统会自动取collectionView的宽度
    //高度为分组头的高度
    return CGSizeMake(0, 44);
}


//协议中的方法，用来返回CollectionView的分组头或者分组脚
//参数二：用来区分是分组头还是分组脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //重用分组头，因为前边注册过，所以重用一定会成功
    //参数一：用来区分是分组头还是分组脚
    //参数二：注册分组头时指定的ID
    GroupSection *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupSectionID" forIndexPath:indexPath];
    header.sectionTitle.text = _sectionArray[indexPath.section];
    [header.sectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    header.sectionBtn.tag = indexPath.section + 1;
    //    header.iconImage.backgroundColor = [UIColor purpleColor];
    
    if ([_stateArray[indexPath.section] isEqualToString:@"0"]) {
        //        header.iconImage.backgroundColor = [UIColor redColor];
        header.iconImage.image = [UIImage imageNamed:@"btn_menu_normal"];
        header.imgHeight.constant = 12.0f;
        header.imgWidth.constant = 7.0f;
        header.sectionTitle.text = @"关闭";
        
    }
    else if ([_stateArray[indexPath.section] isEqualToString:@"1"]){
        header.iconImage.image = [UIImage imageNamed:@"btn_menu@2x.png"];
        header.imgHeight.constant = 7.0f;
        header.imgWidth.constant = 12.0f;
        header.sectionTitle.text = @"打开";

    }
    return header;
}

- (void)buttonClick:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1]];
    
    
}

@end
