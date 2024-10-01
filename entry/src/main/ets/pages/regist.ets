import PrefUtil from "../Common/PrefUtil"
import router from '@ohos.router';
import CommonConstants from '../Common/CommonConstants'
@Entry
@Component
struct Index {

  @State userName:string =''
  @State code: string = '';
  @State isSave:boolean=false

  build() {
    Column(){
      Text('注册界面')
        .textAlign(TextAlign.Center)
        .fontSize(20)
        .width('50%')
        .textAlign(TextAlign.Center)

      Blank()
        .height(40)

      Text('请输入用户名')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .opacity(0.6)
        .textAlign(TextAlign.Center)

      TextInput()
        .onChange((userName)=>{
          this.userName=userName
          this.isSave=false
        })
        .textAlign(TextAlign.Center)

      Text('请输入密码')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .opacity(0.6)

      TextInput()
        .onChange((code)=>{
          this.code=code
          this.isSave=false
        })
        .textAlign(TextAlign.Center)

      Row(){
        Button('确认')
          .width('30%')
          .onClick(()=>{
            PrefUtil.hasKey(this.userName,CommonConstants.USER_PREF).then((judge)=>{
              if(judge==true){
                AlertDialog.show(
                  {
                    message: '注册失败，该账号已被使用！',
                    buttons: [
                      {
                        value: '确认',
                        action: () => {
                          console.info('Callback when button1 is clicked')
                        }
                      }
                    ],
                  })
              }
              else{
                PrefUtil.saveValue(this.userName,this.code,CommonConstants.USER_PREF)
                this.isSave=true
                AlertDialog.show(
                  {
                    message: '注册成功！',
                    buttons: [
                      {
                        value: '确认',
                        action: () => {
                          console.info('Callback when button1 is clicked')
                        }
                      }
                    ],
                  })
                router.back({
                  url:'pages/Login'
                })
              }
            }).catch((err:Error)=>{
              AlertDialog.show(
                {
                  message: '查询账号数据失败，请稍后再试,err:'+`${err}`,
                  buttons: [
                    {
                      value: '确认',
                      action: () => {
                        console.info('Callback when button1 is clicked')
                      }
                    }
                  ],
                })
              console.error('查询账号数据失败，请稍后再试,err:'+`${err}`)
            })

          })

        Blank()
          .width('40%')

        Button('返回')
          .width('30%')
          .onClick(()=>{
            router.showAlertBeforeBackPage({
              message:'您还未注册，确定返回吗？'
            })
            router.back({
              url:'pages/Login'
            })
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .height('100%')
    .width('92%')
    .margin({left:15})
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}