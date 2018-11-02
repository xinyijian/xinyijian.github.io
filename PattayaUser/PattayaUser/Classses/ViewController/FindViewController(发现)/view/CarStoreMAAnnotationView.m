//
//  CarStoreMAAnnotationView.m
//  PattayaUser
//
//  Created by 明克 on 2018/3/9.
//  Copyright © 2018年 明克. All rights reserved.
//

#import "CarStoreMAAnnotationView.h"
#import "CarStoreMAPointAnntation.h"
@implementation CarStoreMAAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        if ([annotation isKindOfClass:[CarStoreMAPointAnntation class]]) {
            
            _carId = [(CarStoreMAPointAnntation*)annotation carId];
            _lat = [(CarStoreMAPointAnntation*)annotation lat];
            _lon = [(CarStoreMAPointAnntation*)annotation lon];
            _feeLaber = [(CarStoreMAPointAnntation*)annotation feeLaber];
            _apartLaber = [(CarStoreMAPointAnntation*)annotation apartLaber];
            _addressLaber = [(CarStoreMAPointAnntation*)annotation addressLaber];
            _storeName = [(CarStoreMAPointAnntation*)annotation storeName];
            _categoryName = [(CarStoreMAPointAnntation*)annotation categoryName];
        }
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
