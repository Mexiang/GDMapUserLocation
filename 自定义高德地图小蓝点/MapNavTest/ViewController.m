//
//  ViewController.m
//  MapNavTest
//
//  Created by Dry on 16/9/1.
//  Copyright © 2016年 Dry. All rights reserved.
//

#import "ViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

@interface ViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self creatMapView];
}

- (void)creatMapView {
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.showsCompass = NO;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    [self.view addSubview:_mapView];
}

#pragma mark MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    NSLog(@"%d",updatingLocation);
    NSLog(@"位置更新");
    NSLog(@"当前位置：%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    //用户当前位置大头针
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.canShowCallout = NO;
        annotationView.image = [UIImage imageNamed:@"heardImg_passenger_default"];
        annotationView.frame = CGRectMake(0, 0, 26, 26);
        annotationView.contentMode = UIViewContentModeScaleToFill;
        annotationView.layer.masksToBounds = YES;
        
        return annotationView;
    }
    
    else if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        static NSString *locationBackViewReuseIndetifier = @"locationBackViewReuseIndetifier";
//        
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:locationBackViewReuseIndetifier];
//        
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:locationBackViewReuseIndetifier];
//        }
//
//        annotationView.canShowCallout = NO;
//        annotationView.image = [UIImage imageNamed:@"heardImg_passenger_default"];
//        annotationView.frame = CGRectMake(0, 0, 10, 10);
//        annotationView.contentMode = UIViewContentModeScaleToFill;
//        annotationView.layer.masksToBounds = YES;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    
}


- (MAPolylineRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    /* 自定义定位精度对应的MACircleView.*/
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        
        
    }
    
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
