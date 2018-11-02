//
//  RefundVC.m
//  PattayaUser
//
//  Created by yanglei on 2018/10/17.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "RefundVC.h"

@interface RefundVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSInteger currentTag;
}

@property (nonatomic,strong) UILabel * orderNumberLabel;//订单号
@property (nonatomic,strong) UILabel * describeLabel;
@property (nonatomic,strong) UITextView * describeTextView;//描述输入框
@property (nonatomic,strong) UILabel * placehoder;
@property (nonatomic,strong) UIButton * addBT;//添加按钮
@property (nonatomic,strong) UIButton * commitBT;//提交


@end

@implementation RefundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请退款";
    [self setupUI];
    
}

-(void)setupUI{
    [super setupUI];
    
    _orderNumberLabel = [[UILabel alloc] init];
    _orderNumberLabel.backgroundColor = UIColorWhite;
    _orderNumberLabel.text = @"    订单号：#1234567890";
    _orderNumberLabel.font = K_LABEL_SMALL_FONT_16;
    _orderNumberLabel.textColor = TextColor;
   // [_orderNumberLabel sizeToFit];
    [self.view addSubview: _orderNumberLabel];
    [_orderNumberLabel activateConstraints:^{
        [_orderNumberLabel.right_attr equalTo:self.view.right_attr ];
        [_orderNumberLabel.left_attr equalTo:self.view.left_attr ];
        [_orderNumberLabel.top_attr equalTo:self.view.top_attr ];
        _orderNumberLabel.height_attr.constant = IPhone_7_Scale_Height(50);
    }];
    
    UIView *whiteBGView = [[UIView alloc]init];
    whiteBGView.layer.cornerRadius = 5;
    whiteBGView.layer.masksToBounds = YES;
    whiteBGView.backgroundColor = UIColorWhite;
    [self.view addSubview:whiteBGView];
    [whiteBGView activateConstraints:^{
        [whiteBGView.right_attr equalTo:self.view.right_attr constant:IPhone_7_Scale_Width(-8) ];
        [whiteBGView.left_attr equalTo:self.view.left_attr constant:IPhone_7_Scale_Width(8) ];
        [whiteBGView.top_attr equalTo:self.orderNumberLabel.bottom_attr constant:IPhone_7_Scale_Height(20) ];
        whiteBGView.height_attr.constant = IPhone_7_Scale_Height(274);
    }];
    
    //
    UILabel *issueLabel = [[UILabel alloc] init];
    issueLabel.text = @"问题描述";
    issueLabel.font = K_LABEL_SMALL_FONT_16;
    issueLabel.textColor = TextColor;
     [issueLabel sizeToFit];
    [whiteBGView addSubview: issueLabel];
    [issueLabel activateConstraints:^{
        [issueLabel.right_attr equalTo:whiteBGView.right_attr constant:IPhone_7_Scale_Width(-12) ];
        [issueLabel.left_attr equalTo:whiteBGView.left_attr constant:IPhone_7_Scale_Width(12) ];
        [issueLabel.top_attr equalTo:whiteBGView.top_attr constant:IPhone_7_Scale_Height(16) ];
        issueLabel.height_attr.constant = IPhone_7_Scale_Height(22);
    }];
    
    //分割线
    UIView * lineView = [[UIView alloc] init];
    [whiteBGView addSubview:lineView];
    [lineView activateConstraints:^{
        [lineView.right_attr equalTo:whiteBGView.right_attr];
        [lineView.left_attr equalTo:whiteBGView.left_attr];
        [lineView.top_attr equalTo:issueLabel.bottom_attr constant:IPhone_7_Scale_Height(14)];
        lineView.height_attr.constant = 1;
    }];
    lineView.backgroundColor = UIColorFromRGB(0xEBEBEB);
    
    _describeTextView = [[UITextView alloc] init];
    _describeTextView.delegate = self;
    _describeTextView.font = [UIFont systemFontOfSize:14];
    [whiteBGView addSubview:_describeTextView];
    [_describeTextView activateConstraints:^{
        [_describeTextView.right_attr equalTo:whiteBGView.right_attr constant:IPhone_7_Scale_Width(-12) ];
        [_describeTextView.left_attr equalTo:whiteBGView.left_attr constant:IPhone_7_Scale_Width(12) ];
        [_describeTextView.top_attr equalTo:lineView.bottom_attr constant:IPhone_7_Scale_Height(10) ];
        _describeTextView.height_attr.constant = IPhone_7_Scale_Height(100);
    }];
    
    [_describeTextView addSubview:self.placehoder];
    
    CGFloat margin = (SCREEN_Width - IPhone_7_Scale_Width(12*2+8*2) - IPhone_7_Scale_Width(100)*3)/2;
    //添加按钮
    for (int i = 0; i < 3; i++) {
        UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(IPhone_7_Scale_Width(12)+ (IPhone_7_Scale_Width(100) + margin)*i, IPhone_7_Scale_Height(274) - IPhone_7_Scale_Width(78) - IPhone_7_Scale_Height(10), IPhone_7_Scale_Width(100), IPhone_7_Scale_Width(78)) ];
        addImageView.userInteractionEnabled = YES;
        addImageView.image = [UIImage imageNamed:@"btn_addpic"];
        addImageView.tag = i+100;
        [whiteBGView addSubview:addImageView];
        
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPic:)]
        ;
        [addImageView addGestureRecognizer:tap];
        
        UIButton *deleteBT = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBT.frame = CGRectMake(IPhone_7_Scale_Width(12 + 90) + (IPhone_7_Scale_Width(100)+margin)*i,IPhone_7_Scale_Height(274) - IPhone_7_Scale_Width(88) - IPhone_7_Scale_Height(10), IPhone_7_Scale_Width(20), IPhone_7_Scale_Width(20));
        [deleteBT setImage:[UIImage imageNamed:@"btn_cancel"] forState:UIControlStateNormal];
        [deleteBT setImage:[UIImage imageNamed:@"btn_cancel"] forState:UIControlStateSelected];
        [deleteBT addTarget:self action:@selector(canclePic:) forControlEvents:UIControlEventTouchUpInside];
        deleteBT.tag = i+1000;
        deleteBT.hidden = YES;
        [whiteBGView addSubview:deleteBT];
       

    }
    
    //提交
    _commitBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commitBT setTitle:@"提交" forState:UIControlStateNormal];
    [_commitBT addTarget:self action:@selector(commitEvaluate) forControlEvents:UIControlEventTouchUpInside];
    [_commitBT setTitleColor:UIColorWhite forState:UIControlStateNormal];
    _commitBT.backgroundColor = App_Nav_BarDefalutColor;
    _commitBT.layer.cornerRadius = 19;
    _commitBT.layer.masksToBounds = YES;
    [self.view addSubview:_commitBT];
    [_commitBT activateConstraints:^{
        [_commitBT.top_attr equalTo:whiteBGView.bottom_attr constant:IPhone_7_Scale_Height(40)];
        _commitBT.width_attr.constant = IPhone_7_Scale_Width(250);
        _commitBT.height_attr.constant = 38;
        _commitBT.centerX_attr = self.view.centerX_attr;
    }];
    
}

//添加
-(void)addPic:(UITapGestureRecognizer *)ges{
    NSLog(@"%ld",ges.view.tag);
    currentTag = ges.view.tag;
    [self alterHeadPortrait];
}

//取消
-(void)canclePic:(UIButton*)btn{
    btn.hidden = YES;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:btn.tag-900];
    imageView.image = [UIImage imageNamed:@"btn_addpic"];

}

#pragma mark - UITextViewDelegate 代理

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self performSelector:@selector(textViewDidChange:) withObject:textView afterDelay:0.1f];
}

- (void)textViewDidChange:(UITextView *)textView {

    if ([textView.text isEqualToString:@""]) {
        self.placehoder.hidden = NO;
    }else {
        self.placehoder.hidden = YES;
    }

}

#pragma mark 点击弹出Alert
-(void)alterHeadPortrait{
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:currentTag];
    UIButton *btn = (UIButton *)[self.view viewWithTag:currentTag+900];
    btn.hidden = NO;
    
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    imageView.image = newPhoto;
    //_myHeadPortrait.image = newPhoto;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 提交
-(void)commitEvaluate{
    
}

#pragma mark 懒加载
- (UILabel *)placehoder {
    if (_placehoder == nil) {
        _placehoder = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 150, 30)];
        _placehoder.enabled = NO;
        _placehoder.font = [UIFont systemFontOfSize:14];
        _placehoder.textColor = UIColorFromRGB(0xD8D8D8);
        _placehoder.textAlignment = NSTextAlignmentLeft;
        _placehoder.text = @"在此描述你的问题";
    }
    return _placehoder;
}
@end
