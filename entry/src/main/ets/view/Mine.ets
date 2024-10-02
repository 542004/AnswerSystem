import router from '@ohos.router';
/**
 * 我的
 */
@Component
export struct Mine{
  private imageSrc:Array<Resource>=[
    $r('app.media.L6'),
    $r('app.media.L7'),
    $r('app.media.L8'),
    $r('app.media.L9'),
  ]
  @Consume account:string
  aboutToAppear() {
    console.info(`mine的${this.account}`)
  }

  build(){
    Column(){
      //头像和昵称
      Column(){
        Row({space:10}){
          Image($r('app.media.avatar'))
            .width('20%')
            .height(70)
            .borderRadius(35)
          Text(this.account)
            .fontSize(20)
            .width('30%')
          Blank()
            .width('35%')
          Image($r('app.media.logout'))
            .height(30)
            .width('10%')
            .onClick(()=>{
              AlertDialog.show(
                {
                  message: '确认注销吗',
                  buttons: [
                    {
                      value: '确认',
                      action: () => {
                        router.replaceUrl({
                          url:"pages/Login"
                        })
                      }
                    },
                    {
                      value: '取消',
                      action: () => {
                        console.info('取消注销')
                      }
                    }
                  ],
                })
            })

        }
        .justifyContent(FlexAlign.Start)
        .margin(15)
      }
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: 10,
        left: 10,
        right: 10
      })
      .margin({
        top: 10,
        left: 10,
        right: 10
      })
      .width('100%')
      .height(80)

      //轮播图
      Row() {
        Swiper() {
          ForEach(this.imageSrc, (item: Resource) => {
            Image(item)
              .borderRadius(20)
          }, (item: string, index) => index.toString())
        }
        .autoPlay(true) //自动播放
        .loop(true) //循环播放
        .interval(3000) //自动播放的时间间隔
      }
      .margin({
        top: 10,
        left: 10,
        right: 10
      })
      .width('100%')
      .height(150)

      //修改信息、主题设置
      Row() {
        List() {
          ListItem() {
            Column() {
              Row() {
                Image($r('app.media.account')).width(20).height(20).margin({right: 10 })
                Text('修改信息')
                  .height(20)
                  .fontSize(16)
                  .fontColor('#0F172A')
                  .flexGrow(1)
                  .fontWeight(400)
                Image($r('app.media.selright')).width(16).width(16)
              }
              .width('100%')
              .height(55)
              .padding({ left: 20, right: 20 })
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/InfoPage',
                  params:{
                    account:this.account
                  }
                })
                console.info(`mine的路由跳转完成了 ${this.account}`)
              })
              //分割线组件
              Divider().width('90%')
            }
          }

          ListItem() {
            Column() {
              Row() {
                Image($r('app.media.subject')).width(20).height(20).margin({right: 10})
                Text('主题设置')
                  .height(20)
                  .fontSize(16)
                  .fontColor('#0F172A')
                  .flexGrow(1)
                  .fontWeight(400)
                Image($r('app.media.selright')).width(16).width(16)
              }
              .width('100%').height(55).padding({ left: 20, right: 20 })
              Divider().width('90%')
            }
          }//跳转主题设置页面
          .onClick(()=>{

          })

        }
      }
      .backgroundColor(Color.White)
      .margin({
        left: 8,
        right: 8
      })
      .borderRadius(8)
    }
  }

}