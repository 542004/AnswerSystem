/**
 * 汽车展示
 */
import {webview} from '@kit.ArkWeb';
import {BusinessError} from '@kit.BasicServicesKit'
@Component
export struct ShowPage{
  controller:webview.WebviewController=new webview.WebviewController()

  build(){
    Column(){
      Web({src:'https://www.lixiang.com/',controller:this.controller})
    }
  }
}