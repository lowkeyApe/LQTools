//
//  YXLQNetWorkTools.m
//  HBuilder-Hello
//
//  Created by Low-Key on 2017/10/17.
//  Copyright © 2017年 DCloud. All rights reserved.
//

#import "YXLQNetWorkTools.h"

@implementation YXLQNetWorkTools
+(void)requestURL:(NSString *)URL requestType:(LQREQUEST_TYPE)customType requestSerializerType:(LQREQUEST_SerializerType)requestSerializerType  responseSerializerType:(LQRESPONSE_Serializer)responseSerializerType requestParameter:(id)param successBlock:(void (^)(id respondData))successBlock failurBlock:(void (^)(NSError *error))failurBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //
    manager.requestSerializer = requestSerializerType == LQREQUEST_SerializerType_JSON ?
    [AFJSONRequestSerializer serializer]:
    [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = responseSerializerType == LQRESPONSE_SerializerType_JSON ?
    [AFJSONResponseSerializer serializer]:
    [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    //GET
    customType == LQREQUEST_TYPE_GET ? [manager GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            successBlock(dic);
        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }]:
    //POST
    [manager POST:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (dic) {
                successBlock(dic);
            }else{
                NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                successBlock(result);
                NSLog(@"服务器返回的类型%@",result);
            }
        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }];
    
}




+(void)requestURL:(NSString *)URL requestType:(LQREQUEST_TYPE)type requestParameter:(id)param successBlock:(void (^)(id respondData))successBlock failurBlock:(void (^)(NSError *error))failurBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([param isKindOfClass:[NSMutableArray class]] || [param isKindOfClass:[NSArray class]]) {
        //如果SB服务器传入的参数是数组
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //并且返回的数据不用urlencode转换（猜的，AFHTTPResponseSerializer对返回的数据进行了urlencode）
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else if ([param isKindOfClass:[NSMutableDictionary class]] ||[param isKindOfClass:[NSDictionary class]] ){
        //如果是字典（常规）
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    //GET
    type == LQREQUEST_TYPE_GET ? [manager GET:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (dic) {
                successBlock(dic);
            }else{
                NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                successBlock(result);
                NSLog(@"服务器返回的类型%@",result);
            }        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }]:
    //POST
    [manager POST:URL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (dic) {
                successBlock(dic);
            }else{
                NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                successBlock(result);
                NSLog(@"服务器返回的类型%@",result);
            }
        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }];
    
}

+ (void)postImageWithImage:(UIImage *)image
     servicerImageFileName:(NSString *)imageFileNameKey
               servicerURL:(NSString *)URL
            servicerParams:(NSDictionary *)param
            uploadProgress:(void(^)(NSProgress *uploadProgress))progressBlock
              successBlock:(void(^)(id respondData))successBlock
               failurBlock:(void(^)(NSError *error))failurBlock{
    
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把file改成网站开发人员告知的字段名
     */
    
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:URL parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //                NSData *imageData = UIImageJPEGRepresentation(image, .5f);
        NSData *imageData = [self reSizeImageData:image maxImageSize:800 maxSizeWithKB:1024.0];
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:imageData name:imageFileNameKey fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        // 给Progress添加监听 KVO
        //        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        //        // 回到主队列刷新UI,用户自定义的进度条
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            self.progressView.progress = 1.0 *
        //            uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        //        });
        
        progressBlock(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败 %@", error);
        failurBlock(error);
    }];
    
}
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

+ (void)postDataWithURL:(NSString *)urlStr
               DataPath:(NSString *)dataPath
           PostDataType:(postDataType)postDataType
         uploadProgress:(void(^)(NSProgress *uploadProgress))progressBlock
           successBlock:(void(^)(id respondData))successBlock
            failurBlock:(void(^)(NSError *error))failurBlock{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:dataPath];
        NSString *fileName;
        NSString *mimeType;
        if (postDataType==postDataType_Image) {
            fileName = @"test.png";
            mimeType = @"image/png";
        }else if (postDataType==postDataType_Voice){
            fileName = @".wav";
            mimeType = @"voice/wav";
        }else{
            fileName = @"test.mp4";
            mimeType = @"vedio/mp4";
        }
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:mimeType];
        
        //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:imgPath] name:@"file" fileName:@"xxx.png" mimeType:@"image/png" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"已上传：%@",uploadProgress);
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"-------%@", [responseObject class]);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (dic) {
                successBlock(dic);
            }else{
                NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                successBlock(result);
                NSLog(@"服务器返回的类型%@",result);
            }
        }else{
            successBlock(responseObject);
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
        NSLog(@"-------%@", error);
    }];
    
}


#pragma mark ------文件下载---------------------
+ (void)loadDownFile:(NSString *)fileStr
        saveFilePath:(NSString *)saveFilePath
           pathBlock:(void(^)(NSString *path))pathBlcok{
    NSURLSessionDownloadTask *_downloadTask;
    //网络监控句柄
    AFNetworkReachabilityManager *manager1 = [AFNetworkReachabilityManager sharedManager];
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager1 startMonitoring];
    
    [manager1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //status:
        //AFNetworkReachabilityStatusUnknown          = -1,  未知
        //AFNetworkReachabilityStatusNotReachable     = 0,   未连接
        //AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
        //AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
        NSLog(@"%ld", (long)status);
    }];
    
    
    NSURL *URL = [NSURL URLWithString:fileStr];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //下载Task操作
    _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // @property int64_t totalUnitCount;  需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        // 给Progress添加监听 KVO
        NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        // 回到主队列刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            //  self.progressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        });
        
        //        progressBlock(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"targetPath=%@",targetPath);
        
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        
        NSString *savePath;
        
        savePath = saveFilePath;
        
        NSString *cachesPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:savePath];
        
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return  [NSURL fileURLWithPath:path];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (filePath) {
            pathBlcok([filePath path]);
        }
        
        
        
    }];
    
    [_downloadTask resume];
}

+(void)requestURL:(NSString *)URL requestType:(LQREQUEST_TYPE)type
                             requestParameter:(id)param
                                     progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                                 successBlock:(void (^)(id respondData))successBlock
                                  failurBlock:(void (^)(NSError *error))failurBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([param isKindOfClass:[NSMutableArray class]] || [param isKindOfClass:[NSArray class]]) {
        //如果SB服务器传入的参数是数组
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //并且返回的数据不用urlencode转换（猜的，AFHTTPResponseSerializer对返回的数据进行了urlencode）
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else if ([param isKindOfClass:[NSMutableDictionary class]] ||[param isKindOfClass:[NSDictionary class]] ){
        //如果是字典（常规）
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    //GET
    type == LQREQUEST_TYPE_GET ? [manager GET:URL parameters:param progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            successBlock(dic);
        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }]:
    //POST
    [manager POST:URL parameters:param progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            if (dic) {
                successBlock(dic);
            }else{
                NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
                successBlock(result);
                NSLog(@"服务器返回的类型%@",result);
            }
        }else{
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failurBlock(error);
    }];
    

    

}


@end
