import router from '@ohos.router';
import PreferenceUtil from '../utils/PreferenceUtil'
/**
 * 我的
 */
let params = router.getParams()
@Component
export struct Mine{
  private imageSrc:Array<Resource>=[
    $r('app.media.L6'),
    $r('app.media.L7'),
    $r('app.media.L8'),
    $r('app.media.L9'),
  ]
  @Consume account:string
  @Prop lin : string = '20'
  // @State size : string = params.['name']

  aboutToAppear() {
    console.info(`mine的${this.account}`)
    PreferenceUtil.getPreferenceValue('zihao','flase')
      .then((value) => {
        if (value != null || value != undefined) {
          this.lin = value?.toString()
        }

      })
      .catch((error: Error) => {
        console.error('获取值时出现错误', error);
      });
  }
  onDidBuild(): void {
    PreferenceUtil.getPreferenceValue('zihao','flase')
      .then((value) => {
        if (value != null || value != undefined) {
          this.lin = value?.toString()
        }

      })
      .catch((error: Error) => {
        console.error('获取值时出现错误', error);
      });
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
            .fontSize(Number(this.lin))
            .width('30%')
          Blank()
            .width('35%')
          Image($r('app.media.logout'))
            .height(30)
            .width('10%')
            .onClick(()=>{
              AlertDialog.show(
                {
                  message: '确认退出登录吗',
                  buttons: [
                    {
                      value: '确认',
                      action: () => {
                        PreferenceUtil.putPreferenceValue('login',false)
                        PreferenceUtil.putPreferenceValue('loginname','')
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
                  .height(35)
                  .fontSize(Number(this.lin)-4)
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
                  .height(35)
                  .fontSize(Number(this.lin)-4)
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
            router.pushUrl({
              url:'pages/ThemePage',params:{name : this.account}
            })
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