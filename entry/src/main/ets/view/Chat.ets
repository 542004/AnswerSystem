import PreferenceUtil from '../utils/PreferenceUtil'
import HttpUtils from '../utils/HttpUtils'
import distributedKVStore from '@ohos.data.distributedKVStore';
//跳转web
import web_webview from '@ohos.web.webview'
import { router } from '@kit.ArkUI'
import { NewChat } from '../utils/NewChat'
//主菜单抽屉
import {MyCustomDialog} from '../view/MenuDialog'
/**
 * 获取历史记录
 */
import {getBriefData} from '../view/History'
class DividerTmp {
  strokeWidth: Length = 1
  startMargin: Length = 0
  endMargin: Length = 60
  color: ResourceColor = '#ffe9f0f0'

  constructor(strokeWidth: Length, startMargin: Length, endMargin: Length, color: ResourceColor) {
    this.strokeWidth = strokeWidth
    this.startMargin = startMargin
    this.endMargin = endMargin
    this.color = color
  }
}
/**
 * 对话组件
 */
@Component
export struct Chat {
  scroller: Scroller = new Scroller();
  controller: web_webview.WebviewController = new web_webview.WebviewController()
  @Consume account : string
  @State zan : string = ''
  @State cun : string[] = Array(100).fill(null)
  @State key2 : string = ''
  @State kong : number = 0
  @State pankong : number = 0
  @State text : string = ''
  @State egDivider: DividerTmp = new DividerTmp(1, 60, 10, '#ffe9f0f0')
  @State ifbreak : boolean =false
  @State haha : string = ''
  @State linshi : string[] = []
  @Prop kvManager: distributedKVStore.KVManager | null
  @LocalStorageLink('record') @Watch("recChange")linkedRec: string =''

  recChange(){
    this.text=this.linkedRec
  }

  /**
   * 之前aboutToAppear里面的首选项存储历史记录删除了
   * 改用数据库存储
   */
  aboutToAppear(): void {
  }

  @Builder
  tabBarBuilder(name : string) {
    Row() {
      Text(name)
        .fontColor(Color.White)
    }
  }

  //主菜单抽屉
  menu_controller:CustomDialogController=new CustomDialogController({
    builder:MyCustomDialog({

    }),
    alignment:DialogAlignment.TopStart,
    cornerRadius:{topRight:10,bottomRight:10,topLeft:0,bottomLeft:0},
    width:270,
    height:'100%',
    openAnimation:{
      duration:300
    },
    backgroundColor:'#ffd2daff'
  })

  build() {
    //最外层用来包里面的内容
    Column() {

      Row() {
        Image($r('app.media.liebiao')).width(25)
          .onClick(()=>{
            this.menu_controller.open()
          })
          .margin({left:17})

        Row(){
          Text('常见问题')
            .onClick(()=>{
              router.pushUrl({
                url:"pages/CommonQuestion"
              })
            })
            .fontColor('#ff5d66e5')
            .fontSize(20)
            .margin({right:13})

          Image($r('app.media.xinjian1')).width(35)
            .onClick(()=>{
              NewChat.createNewChat(this.cun)
              //清空数据
              this.cun = Array(100).fill(null)
              this.kong = 0;
              this.pankong = 0;
              this.text = '';
              this.haha = '';
              this.linshi = [];
            })
        }
        .margin({right:17})

      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')

      // Column(){
        Column() {
          /**
           * 问答消息框
           */
          Column() {
            List({ initialIndex: this.kong - 1, scroller: this.scroller.scrollEdge(Edge.End) }) {
              // List() {
              ForEach(this.cun, (item: string, Index) => {
                //chat框
                if (this.cun && this.cun[Index] !== undefined && this.cun[Index] !== null &&
                  this.cun[Index].charAt(0) == '1') {
                  ListItem() {
                    Row(){
                      Image($r('app.media.MyIcon')).width(40)
                        .borderRadius(5)
                        .margin({top:10})

                      Column(){
                        Column() {
                          Text(this.cun[Index].substring(1).toString())
                            .fontSize(25)
                        }
                        .alignItems(HorizontalAlign.Start)
                        .width('100%')

                      }
                      .width('80%')
                      .backgroundColor('#F6F6F6')
                      .padding(10)
                      .margin({top:30,left:10,right:10})
                      .borderRadius({
                        topRight: 20,
                        bottomRight: 20,
                        bottomLeft:20
                      })

                    }
                    .alignItems(VerticalAlign.Top)
                  }

                }
                //用户框
                else if (this.cun && this.cun[Index] !== undefined && this.cun[Index] !== null &&
                  this.cun[Index].charAt(0) == '2') {
                  ListItem() {
                    Row(){
                      Column(){
                        Column() {
                          Text(this.cun[Index].substring(1).toString())
                            .fontSize(25)
                        }
                        .alignItems(HorizontalAlign.End)
                        // .width('100%')
                      }
                      // .width('80%')
                      .backgroundColor('#ffa5bfef')
                      .padding(12)
                      .margin({top:30,left:10,right:10})
                      .borderRadius({
                        topLeft: 20,
                        bottomRight:20,
                        bottomLeft: 20
                      })

                      Image($r('app.media.touxiang'))
                        .width(40)
                        .borderRadius(5)
                        .margin({top:10})
                    }
                    .alignItems(VerticalAlign.Top)
                    .justifyContent(FlexAlign.End)
                    .width('100%')


                  }

                } else {
                }

              })

            }
            .width('100%')
            .height('90%')
            .scrollBar(BarState.Off)
          }

          /**
           * Chat对话输入框
           */
          Column() {
            //写推荐搜索，常用
            Row() {
              TextInput({
                placeholder: '请输入内容',
                text: this.text
              })
                .onChange((value) => {
                  this.key2 = value
                  this.text = value
                })
                .width('60%')
                .backgroundColor(Color.Transparent)

              Image($r('app.media.send'))
                .width(50)
                .onClick(() => {
                  if (this.text != '') {
                    console.log(this.key2)
                    PreferenceUtil.putPreferenceValue(`talk1.${this.kong}`, '2' + this.key2)
                    this.cun[this.kong] = '2' + this.key2
                    this.kong++

                    // this.scroller.scrollToIndex(this.kong-1)
                    this.scroller.scrollToIndex(0)
                    HttpUtils.request(this.key2).then(resp => {
                      this.haha = resp
                      PreferenceUtil.putPreferenceValue(`talk1.${this.kong}`, '1' + this.haha)
                      this.cun[this.kong] = '1' + this.haha
                      this.kong++
                      this.scroller.scrollToIndex(this.kong - 1)
                    })
                    this.linkedRec=this.key2
                    this.text = ''
                    console.info(`${this.linkedRec} Chat的记录改变了`)
                  }
                })
                  // .fontColor(Color.Blue)
                .backgroundColor(Color.Transparent)
                .padding(10)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .borderRadius(20)
            .backgroundColor('#F4F6F5')
          }
            .backgroundColor(Color.Transparent)
            .padding(10)
        }
        .justifyContent(FlexAlign.End)
        .width('100%')
    }
    .width('100%')
    .padding(20)
  }
}

