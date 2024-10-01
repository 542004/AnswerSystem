import { common, StartOptions } from '@kit.AbilityKit';
import { router } from '@kit.ArkUI';
import UserPrivacyDialog from "../view/UserPrivacyDialog";
import PreferencesUtil from '../utils/PreferenceUtil'


@Extend(Text)
function TextFn() {

  .fontSize(100)
  .fontColor(Color.White)
}

@Extend(Text)
function smText() {
  .fontSize(12).opacity(0.8).fontColor(Color.White)
}


const PREF_KEY = 'userPrivacyKey'
@Entry
@Component
struct WelcomePage {
  //用于关闭App
  context = getContext(this) as common.UIAbilityContext
  //页面中声明弹窗控制器并用其控制弹窗
  Controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confirm: () => this.onConfirm(),
      cancel: () => this.exitApp()
    }),
  })

  async aboutToAppear() {
    //加载首选项
    let isAgree = await PreferencesUtil.getPreferenceValue(PREF_KEY, false)//key和错误时传回的值
    //判断是否同意
    if (isAgree) {
      this.jumpToIndex()
    } else {
      this.Controller.open()
    }
  }

  jumpToIndex() {
    setTimeout(() => {
      router.replaceUrl({
        url:'pages/Login'
      })
    },2000)
  }

  onConfirm() : void{
    PreferencesUtil.putPreferenceValue(PREF_KEY, true)//key和value
    this.jumpToIndex()
  }

  exitApp() : void{
    this.context.terminateSelf()
  }

  build() {
    Column({space:10}) {
      //中央slogan
      Column(){
        Text(' ')
          .fontColor(Color.White)
          .fontSize(70)
        Row({space : 10}) {
          Image($r('app.media.lixiang'))
            .width(150)
            .fillColor(Color.White)
          Text('理想')
            .fontColor(Color.White)
            .fontSize(90)

        }
      }.layoutWeight(1)
      .margin({top:200})
      Row(){
        Text('汽车支持').smText()
        Text('ipv6')
          .smText()
          .border({style: BorderStyle.Solid,width: 1,color:Color.White,radius:16})
          .padding({
            left:5,
            right:5
          })
        Text('网络').smText()
      }
      Text('更多设置敬请期待，请期待2210年更新，或访问火星客户端').smText()
      Text('秦ICP备00000001TSF-36D').smText().opacity(0.4).margin({bottom:35})
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
  }
}