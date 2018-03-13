# 1 概述
本项目为修改后的 [apereo/dotnet-cas-client](https://github.com/apereo/dotnet-cas-client) （cas客户端实例），供研发时间不足的开发者参考。

# 2 重定向问题解决
在apereo官方提供的[CAS Cilent](https://apereo.github.io/cas/5.1.x/integration/CAS-Clients.html)中，提供了.NET版本的dotnet-cas-client。
在这个解决方案中包含我们需要的DotNetCasClient，以及两个样例，web样例名为ExampleWebSite。


样例的详细使用过程大家可以参考[《实现 ASP.NET WebForm Client》](http://www.cnblogs.com/zhenyulu/archive/2013/01/22/2870936.html)，
博主写的很详细，最后专门介绍了重定向错误的解决方法。
根据文中提到的方法，我并没有完全解决重定向问题。现分享下我的解决办法。重定向问题有以下几个原因：
## 2.1 证书问题
该问题有两种解决思路，一种是添加证书，详细过程参考[《HOWTO CASifying ASP.NET WebApp - ExampleWebsite》](https://wiki.jasig.org/display/CASUM/HOWTO+CASifying+ASP.NET+WebApp+-+ExampleWebsite)。

另一种是不校验证书，即《实现 ASP.NET WebForm Client》给出的解决办法。即在HttpUtil的PerformHttpGet方法中添加
``` C#
ServicePointManager.ServerCertificateValidationCallback
  =delegate(object obj, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors){
    return true
}
```

## 2.2 会话状态丢失问题
会话状态丢失问题就是[《实现 ASP.NET WebForm Client》](http://www.cnblogs.com/zhenyulu/archive/2013/01/22/2870936.html)一文中提到的问题。
这个问题我在正常启动中没有遇到，但在进入断点调试的时候遇到了，PerformHttpGet的返回值responseBody中可以看到相关提示，应该是进入断点超时后会话状态丢失。
此时根据文中的方案可以避开这个问题，但我觉得没必要。

## 2.3 代理地址无效
这个是我遇到的问题，困扰了我很久。
我在按照1中给出的方案解决了证书问题后，依旧不能正常使用。
后在调试中查看PerformHttpGet的返回值responseBody时发现提示“INVALID_PROXY_CALLBACK 所提供的代理回调网址http…不能提供认证”的错误。
查看传入PerformHttpGet的url参数，发现其中包含一个pgUrl，而这个链接正是提示的网址，并且这个网址并不存在于我的网站。
尝试将这一部分去掉，结果解决了问题。代码如下：

``` C#
int index = url.LastIndexOf(”pgurl”);
if(index > 1){
    url = url.Substring(0, index-1);
}
```

问题应该就是链接中多出了一个回调地址，但是这个地址不存在，于是出错了。这部分代码并不严谨，需根据实际情况进行修改。

## 2.4 对遇到其他问题的建议

强烈建议遇到了重定向问题，而通过搜索没有找到解决办法的同学，注意查看responseBody的值。

# 3 客户端的修改

另提供一个ExampleWebsite的极简版本供时间有限，或对ASP.NET不熟悉的同学。
该版本去掉了不需要的配置、模块，删除了Master、Controls、样式。
使用时仅需修改cas但保留了版权声明，版权也归原作者所有。
