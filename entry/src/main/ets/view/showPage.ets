import {webview} from '@kit.ArkWeb';
import {BusinessError} from '@kit.BasicServicesKit'
@Component
export struct showPage{
  controller:webview.WebviewController=new webview.WebviewController()

  build(){
    Column(){
      Button('loadUrl')
        .onClick(() => {
          try {
            // 需要加载的URL是string类型。
            this.controller.loadUrl('https://www.lixiang.com/');
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Web({src:'https://www.lixiang.com/',controller:this.controller})
    }
  }
}