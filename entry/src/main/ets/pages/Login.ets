/**
 * 登录页面
 */
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
    Column() {
      Column() {
        Image($r('app.media.lixiang'))
          .width(80)
        Text('汽车问答登录系统')
      }
      .width('100%')
      .margin({bottom:10})

      Column({space:20}) {
        TextInput({placeholder:'请输入用户名'})
          .onChange((userName)=>{
            this.userName=userName
            this.isSave=false
          })
          .width('100%')

        TextInput({placeholder:'请输入密码'})
          .type(InputType.Password)
          .onChange((code)=>{
            this.code=code
            this.isSave=false
          })
          .width('100%')
          Button('登录')
                .width('100%')
                .onClick(()=>{
                  if (this.userName != '' && this.code != '') {
                    PrefUtil.getValue(this.userName,CommonConstants.USER_PREF).then((value)=>{
                      if(value===this.code){
                        router.replaceUrl({
                          url:'pages/Index',
                          params:{
                            account:this.userName
                          }
                        })
                      }
                      else{
                        AlertDialog.show(
                          {
                            message: '密码错误！',
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
                    }).catch((err:Error)=>{
                      console.error('登录失败！err:'+`${err}`)
                      AlertDialog.show(
                        {
                          message: '登录失败，不存在的账号或密码错误！',
                          buttons: [
                            {
                              value: '确认',
                              action: () => {
                                console.info('Callback when button1 is clicked')
                              }
                            }
                          ],
                        })
                    })
                  }
                })
      }
      Button('前往注册')
        .width('30%')
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Black)
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Regist'
          })
        })

      Column() {
        Text('技术支持为本公司独立研发')
          .fontSize(15)
          .fontColor(Color.Gray)
      }
      .width('100%')
      .height('60%')
      .justifyContent(FlexAlign.End)

    }
    .width('100%')
    .height('100%')
    .padding(20)
  }


  // build() {
  //   Column(){
  //     Text('登录界面')
  //       .textAlign(TextAlign.Center)
  //       .fontSize(20)
  //       .width('50%')
  //
  //     // Blank()
  //     //   .height(40)
  //
  //     // Text('请输入用户名')
  //     //   .fontSize(20)
  //     //   .fontWeight(FontWeight.Bold)
  //     //   .opacity(0.6)
  //     //   .textAlign(TextAlign.Center)
  //
  //     TextInput({placeholder:'请输入用户名'})
  //       .onChange((userName)=>{
  //         this.userName=userName
  //         this.isSave=false
  //       })
  //       .textAlign(TextAlign.Center)
  //       .width('100%')
  //
  //     // Text('请输入密码')
  //     //   .fontSize(20)
  //     //   .fontWeight(FontWeight.Bold)
  //     //   .opacity(0.6)
  //     //   .textAlign(TextAlign.Center)
  //
  //     TextInput({placeholder:'请输入密码'})
  //       .type(InputType.Password)
  //       .onChange((code)=>{
  //         this.code=code
  //         this.isSave=false
  //       })
  //       .textAlign(TextAlign.Center)
  //       .width('100%')
  //
  //     Row(){
  //       Button('确认')
  //         .width('30%')
  //         .onClick(()=>{
  //           PrefUtil.getValue(this.userName,CommonConstants.USER_PREF).then((value)=>{
  //             if(value===this.code){
  //               router.pushUrl({
  //                 url:'pages/Index',
  //                 params:{
  //                   account:this.userName
  //                 }
  //               })
  //             }
  //             else{
  //               AlertDialog.show(
  //                 {
  //                   message: '密码错误！',
  //                   buttons: [
  //                     {
  //                       value: '确认',
  //                       action: () => {
  //                         console.info('Callback when button1 is clicked')
  //                       }
  //                     }
  //                   ],
  //                 })
  //             }
  //
  //           }).catch((err:Error)=>{
  //             console.error('登录失败！err:'+`${err}`)
  //             AlertDialog.show(
  //               {
  //                 message: '登录失败，不存在的账号或密码错误！',
  //                 buttons: [
  //                   {
  //                     value: '确认',
  //                     action: () => {
  //                       console.info('Callback when button1 is clicked')
  //                     }
  //                   }
  //                 ],
  //               })
  //           })
  //         })
  //
  //       Button('注册')
  //         .width('30%')
  //         .onClick(()=>{
  //           router.pushUrl({
  //             url:'pages/Regist'
  //           })
  //         })
  //     }
  //     .justifyContent(FlexAlign.SpaceBetween)
  //
  //   }
  //   .height('100%')
  //   .width('92%')
  //   .margin({left:15})
  //   .justifyContent(FlexAlign.Center)
  //   .alignItems(HorizontalAlign.Center)
  // }
}