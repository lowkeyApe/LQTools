//
//  YXLQNetWorkTools.h
//  HBuilder-Hello
//
//  Created by Low-Key on 2017/10/17.
//  Copyright © 2017年 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger,postDataType) {
    postDataType_Image = 1,
    postDataType_Voice,
    postDataType_Video
};

typedef NS_ENUM(NSInteger,LQREQUEST_TYPE) {
    LQREQUEST_TYPE_GET = 1,
    LQREQUEST_TYPE_POST
};

typedef NS_ENUM(NSInteger,LQREQUEST_SerializerType) {
    LQREQUEST_SerializerType_JSON = 1,
    LQREQUEST_SerializerType_HTTP
};

typedef NS_ENUM(NSInteger,LQRESPONSE_Serializer) {
    LQRESPONSE_SerializerType_JSON = 1,
    LQRESPONSE_SerializerType_HTTP
};


@interface LQNetWorkTools : NSObject


/**get post常规请求
 @URL                               请求链接
 @customType                        GET/POST
 @requestSerializerType             请求Serializer
 @responseSerializerType            数据返回Serializer
 @param                             参数
 @successBlock                      成功的block
 @failurBlock                       失败的block
 */
+(void)requestURL:(NSString *)URL
      requestType:(LQREQUEST_TYPE)customType
requestSerializerType:(LQREQUEST_SerializerType)requestSerializerType
responseSerializerType:(LQRESPONSE_Serializer)responseSerializerType
 requestParameter:(id)param
     successBlock:(void (^)(id respondData))successBlock
      failurBlock:(void (^)(NSError *error))failurBlock;

/**get post常规请求
 @URL                               请求链接
 @type                              GET/POST
 @param                             参数
 @successBlock                      成功的block
 @failurBlock                       失败的block
 */
+ (void)requestURL:(NSString*)URL
       requestType:(LQREQUEST_TYPE)type
  requestParameter:(id)param
      successBlock:(void(^)(id respondData))successBlock
       failurBlock:(void(^)(NSError *error))failurBlock;
/**上传图片
 @method
 @image            图片文件
 @imageFileNameKey 图片文件名传的key
 @URL              接口URL
 @progressBlock    上传的进度
 */
+ (void)postImageWithImage:(UIImage *)image
     servicerImageFileName:(NSString *)imageFileNameKey
               servicerURL:(NSString *)URL
            servicerParams:(NSDictionary *)param
            uploadProgress:(void(^)(NSProgress *uploadProgress))progressBlock
              successBlock:(void(^)(id respondData))successBlock
               failurBlock:(void(^)(NSError *error))failurBlock;

/**上传(图片,视频,音频)
 @method
 @imgPath           文件Path
 @postDataType      文件类型(图片,视频,音频)
 @urlStr            接口URL
 @progressBlock     上传的进度
 @successBlock      成功的block
 @failurBlock       失败的block
 */
+ (void)postDataWithURL:(NSString *)urlStr
               DataPath:(NSString *)dataPath
           PostDataType:(postDataType)postDataType
         uploadProgress:(void(^)(NSProgress *uploadProgress))progressBlock
           successBlock:(void(^)(id respondData))successBlock
            failurBlock:(void(^)(NSError *error))failurBlock;

/**下传(图片,视频,音频)
 @method
 @fileStr           文件的下载链接
 @saveFilePath      需要加在Cahes文件的后缀名 如/Chat/Pic
 @pathBlock         返回下载位置路径
 */
+ (void)loadDownFile:(NSString *)fileStr
        saveFilePath:(NSString *)saveFilePath
           pathBlock:(void(^)(NSString *path))pathBlcok;

/**get post常规请求 ----------有进度条progress
 @URL                               请求链接
 @type                              GET/POST
 @param                             参数
 @successBlock                      成功的block
 @failurBlock                       失败的block
 */
+(void)requestURL:(NSString *)URL requestType:(LQREQUEST_TYPE)type
                             requestParameter:(id)param
         progress:(void (^_Nullable)(NSProgress * _Nonnull uploadProgress))uploadProgress
     successBlock:(void (^_Nullable)(id _Nullable respondData))successBlock
      failurBlock:(void (^_Nonnull)(NSError * _Nonnull error))failurBlock;

@end
