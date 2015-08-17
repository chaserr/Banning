//
//  TXMapViewController.m
//  Banning
//
//  Created by lanou3g on 15/8/8.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//



// reason: 'Could not instantiate class named MKMapView'
// 如果storyBoard里用到了地图,必须手动导入框架
#import "TXMapViewController.h"
#import <MapKit/MapKit.h>
@interface TXMapViewController ()<MKMapViewDelegate>
/** 地图 */
@property (strong, nonatomic) IBOutlet MKMapView *customMapView;

@property (nonatomic, strong) CLLocationManager *mgr;
/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;
@end

@implementation TXMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注意:在iOS8中, 如果想要追踪用户的位置, 必须自己主动请求隐私权限
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 主动请求权限
        self.mgr = [[CLLocationManager alloc] init];
        
        [self.mgr requestAlwaysAuthorization];
    }
    self.customMapView.userTrackingMode = MKUserTrackingModeFollowWithHeading; // 跟踪用户并且获取方向

    // 设置不允许地图旋转
    self.customMapView.rotateEnabled = NO;
    // 成为mapVIew的代理
    self.customMapView.delegate = self;
}

#pragma mark -- MKMapViewDelegate

/*!
 *  @brief  每次更新到用户的位置就会调用,调用不平凡,只有位置改变才会调用
 *
 *  @param mapView      促发事件的控件
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{

    // 利用反地理编码获取位置之后设置标题
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placeMark = [placemarks firstObject];
        NSLog(@"获取地理位置成功 name = %@ locality = %@", placeMark.name, placeMark.locality);
        userLocation.title = placeMark.name;
        userLocation.subtitle = placeMark.locality;
    }];
    
    // 移动地图到当前用户所在位置
//    [self.customMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];

    // 获取用户位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 指定经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.000001, 0.000001);
    // 将用户当前的位置作为显示区域的中心点,并且指向需要显示的跨度范围
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    // 设置显示区域
    [self.customMapView setRegion:region animated:YES];

}

/*!
 *  @brief  每次添加大头针,就会调用(地图上有几个大头针就会调用几次)
 *
 *  @param mapView    地图
 *  @param annotation 大头针模型
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
// 如果返回nil,系统会按照自己默认的方式显示
    static NSString *identifier = @"anno";
    // 从缓存池中取
        // 1.注意:默认情况下MKAnnotationView是无法显示的,如果想自定义大头针可以使用MKAnnotationView的子类MKPinAnnotationView
        // 2.注意:如果是自定义大头针,默认情况点击大头针之后是不会显示标题的,需要我们自己手动设置显示
    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    // 如果没有创建一个新的
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:identifier];
   
        // 设置大头针颜色
        annoView.pinColor = MKPinAnnotationColorGreen;
        // 设置大头针出现动画
        annoView.animatesDrop = YES;
        // 手动设置大头针标题是否显示
        annoView.canShowCallout = YES;
        // 设置大头针标题显示的偏移量
//        annoView.calloutOffset = CGPointMake(0, 20);
        // 设置大头针辅助视图
        //    annoView.leftCalloutAccessoryView
        // 给大头针View设置数据
        annoView.annotation = annotation;

    }
    
       // 设置大头针图片, 如果是使用MKPinAnnotationView那么设置图片无效,因为系统内部会自动覆盖掉
//    annoView.image = [UIImage imageNamed:@"11"];
    // 返回大头针view
    return annoView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 懒加载
- (CLGeocoder *)geocoder{
    
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

@end
