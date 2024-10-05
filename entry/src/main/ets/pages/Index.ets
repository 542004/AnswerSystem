/**
 * 主页面 包含Chat History ShowPage Mine
 */
import {Mine} from '../view/Mine'
import {Chat} from '../view/Chat'
import {ShowPage} from '../view/ShowPage'
import {History} from '../view/History'
import router from '@ohos.router';


let para: Record<string, string> = { 'record': '' };
let storage: LocalStorage = new LocalStorage(para);
@Entry(storage)
@Component
struct Index{
  private controller: TabsController = new TabsController()
  @State currentPage:number=0
  @Provide account:string=(router.getParams() as Record<string,string>)['account']

  @Builder
  TabBuilder(text:string,index:number){
    Column(){
      Text(text)
        .fontSize(20)
        .fontWeight(500)
        .fontColor(this.currentPage === index ? "#007DFF" : "#999")
        .margin({ top: "4vp" })
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
  build(){
    Column(){
      Tabs({barPosition:BarPosition.End,controller:this.controller}){
        //对话
        TabContent(){
          Chat()
        }
          .tabBar(this.TabBuilder('对话',0))
        //历史
        TabContent(){
          History()
        }
        .tabBar(this.TabBuilder('历史',1))
        //汽车信息
        TabContent(){
          ShowPage()
        }
        .tabBar(this.TabBuilder('汽车信息',2))
        //我的
        TabContent(){
          Mine()
        }
        .tabBar(this.TabBuilder('我的',3))
      }
      .scrollable(false)
      .width('100%')
      .height('100%')
      .barWidth("94%")
      .barMode(BarMode.Fixed)
      .vertical(false)
      .onChange((index) => {
        this.currentPage = index
      })
    }
  }
}