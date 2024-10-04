import PreferenceUtil from '../utils/PreferenceUtil'
import HttpUtils from '../utils/HttpUtils'
//跳转web
import web_webview from '@ohos.web.webview'
import { router } from '@kit.ArkUI'
import { NewChat } from '../utils/NewChat'

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
  @LocalStorageLink('record') @Watch("recChange")linkedRec: string =''

  recChange(){
    this.text=this.linkedRec
  }

  aboutToAppear(): void {
    PreferenceUtil.putPreferenceValue('talk1.0','1天气真好')
    PreferenceUtil.putPreferenceValue('talk1.1','2你说的真对')
    PreferenceUtil.putPreferenceValue('talk1.2','1谢谢')
    PreferenceUtil.putPreferenceValue('talk1.3','2不客气')
    // HttpUtils.request("刹车片是什么东西").then(resp => {
    //   this.haha = resp
    // })

    for (let index = 0; index < 100; index++) {
      PreferenceUtil.getPreferenceValue(`talk1.${index}`, null)
        .then((value) => {
          if ((value === null || value === undefined) && this.pankong == 0 ) {
            console.log('值未填入');
            this.kong = index
            console.log('kong',index)
            this.pankong = 1
          } else if (value) {
            let a = value
            this.cun[index] = value.toString()
            console.log('值',this.cun[index])
          }
          else {
            this.ifbreak = true
            console.log('获取到的值不是有效的对象或缺少');
          }
          if (this.ifbreak == true) {
            console.log('break')
            index = 99
          }
        })
        .catch((error: Error) => {
          console.error('获取值时出现错误', error);
        });
      if (this.ifbreak == true) {
        console.log('break')
        break
      }
    }
  }

  @Builder
  tabBarBuilder(name : string) {
    Row() {
      Text(name)
        .fontColor(Color.White)
    }
  }

  build() {
    //最外层用来包里面的内容
    Column() {
      Row() {
        Button('常见问题')
          .onClick(()=>{
            router.pushUrl({
              url:"pages/CommonQuestion"
            })
          })
      }

      Column() {
        Column() {
          List({ initialIndex: this.kong - 1, scroller: this.scroller.scrollEdge(Edge.End) }) {
            // List() {
            ForEach(this.cun, (item: string, Index) => {
              //chat框
              if (this.cun && this.cun[Index] !== undefined && this.cun[Index] !== null &&
                this.cun[Index].charAt(0) == '1') {
                ListItem() {
                  Column() {
                    Text(this.cun[Index].substring(1).toString())
                      .fontSize(25)
                  }
                  .alignItems(HorizontalAlign.Start)
                  .width('100%')
                }
                .width('95%')
                .backgroundColor('#F6F6F6')
                .padding(10)
                .margin(10)
                .borderRadius({
                  topLeft: 20,
                  topRight: 20,
                  bottomRight: 20
                })
              }
              //用户框
              else if (this.cun && this.cun[Index] !== undefined && this.cun[Index] !== null &&
                this.cun[Index].charAt(0) == '2') {
                ListItem() {
                  Column() {
                    Text(this.cun[Index].substring(1).toString())
                      .fontSize(25)
                  }
                  .alignItems(HorizontalAlign.End)
                  .width('100%')
                }
                .width('95%')
                .backgroundColor('#ffa5bfef')
                .padding(10)
                .margin(10)
                .borderRadius({
                  topLeft: 20,
                  topRight: 20,
                  bottomLeft: 20
                })
              } else {
              }

            })

          }
          .width('100%')
          .height('90%')

          // .scrollBar(BarState.Off)

        }

        /**
         * Chat对话框
         */
        Column() {
          //写推荐搜索，常用
          Column() {
            Row() {

            }

            Row() {
              TextInput({
                placeholder: '请输入内容',
                text: this.text
              })
                .onChange((value) => {
                  this.key2 = value
                  this.text = value
                })
                .width('80%')
                .backgroundColor(Color.Transparent)
              Button('查询')
                .onClick(() => {

                  if (this.text != '') {
                    console.log(this.key2)
                    PreferenceUtil.putPreferenceValue(`talk1.${this.kong}`, '2' + this.key2)
                    this.cun[this.kong] = '2' + this.key2
                    this.kong++
                    this.text = ''
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
                    console.info(`${this.linkedRec} Chat的记录改变了`)

                  }

                })
                .fontColor(Color.Blue)
                .backgroundColor(Color.Transparent)
                .padding(10)

              Button('新建对话')
                .onClick(() => {
                  NewChat.createNewChat(this.cun)
                  //清空数据
                  this.cun = Array(100).fill(null)
                  this.kong = 0;
                  this.pankong = 0;
                  this.text = '';
                  this.haha = '';
                  this.linshi = [];
                })
                .fontColor(Color.Blue)
                .backgroundColor(Color.Transparent)
                .padding(10)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .borderRadius(20)
            .backgroundColor('#F4F6F5')
          }
        }
        .justifyContent(FlexAlign.End)
        .width('100%')
      }
      .width('100%')
      .padding(20)
    }
  }
}

