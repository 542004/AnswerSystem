/**
 * 完整历史记录组件
 */
import historyInfo from '../viewmodel/historyInfo'
import distributedKVStore from '@ohos.data.distributedKVStore';
import findAllContains from '../Common/MatchUtil'
let Data:Array<string>=[]
export function getBriefData():Array<string>{
  return Data
}
@Component
export struct History{
  @Consume account : string
  @State historyInfo:historyInfo=new historyInfo(this.account)
  @State hisConv:Array<string>=[]//存放历史记录
  @State searchText :string=''
  @State listState:boolean=true
  @State matchHis:Array<string>=[]
  @State shallSave:boolean=true
  @State flag:boolean=false
  @State kvManager: distributedKVStore.KVManager | null=null
  //声明KVStore对象
  private kvStore: distributedKVStore.SingleKVStore | null = null
  @LocalStorageLink("record") @Watch("recChange") linkedRec:string=''//每一个问题

  recChange(){
    if(this.shallSave){
      console.info(`${this.linkedRec} 成功改变`)
      this.hisConv.unshift(this.linkedRec)//头插法插入历史记录数组
      this.historyInfo.hisConv=this.hisConv
      this.kvStore?.put(this.account, JSON.stringify(this.historyInfo), (err) => {
        if (err !== undefined) {
          console.error(`历史信息保存失败！ Code:${err.code},message:${err.message}`)
          return
        }
      })
      this.listState=true
    }
    else{
      this.shallSave=true
    }

  }

  installPreference() {
    let context = getContext(this)
    const kvManagerConfig: distributedKVStore.KVManagerConfig = {
      context: context,
      bundleName: 'com.example.answersys'
    }
    try {
      // 创建KVManager实例
      this.kvManager = distributedKVStore.createKVManager(kvManagerConfig)
      // 继续创建获取数据库
      try {
        const options: distributedKVStore.Options = {
          createIfMissing: true, // 当数据库文件不存在时是否创建数据库，默认创建
          encrypt: false, // 设置数据库文件是否加密，默认不加密
          backup: false, // 设置数据库文件是否备份，默认备份
          kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION, // 设置要创建的数据库类型，默认为多设备协同数据库
          securityLevel: distributedKVStore.SecurityLevel.S2 // 设置数据库安全级别
        }

        //指定Options和storeId，创建并得到指定类型的KVStore数据库storeId为数据库唯一标识符
        this.kvManager?.getKVStore(`${this.account}`, options, (err, kvStore: distributedKVStore.SingleKVStore) => {
          if (err) {
            console.error(`无法获取KVStore。 Code:${err.code},message:${err.message}`)
            return
          }
          console.info('成功获取KVStore')
          this.kvStore = kvStore
          //通过get获取指定键的值
          this.kvStore?.get(`${this.account}`).then((res) => {
            //通过JSON.parse()解析数据，再使用as断言进行类型转换
            let historyModel:historyInfo = JSON.parse(res.toString()) as historyInfo
            //对历史记录数组
            this.hisConv=historyModel.hisConv
            Data=historyModel.hisConv
          })
        })
      } catch (e) {
        console.error(`出现意外错误，Code:${e.code},message:${e.message}`)
      }
    } catch (e) {
      console.error(`未能创建KVManager，Code:${e.code},message:${e.message}`)
    }
  }

  aboutToAppear() {
    this.installPreference()
  }

  build(){
    Column({space:10}){
      Row(){//搜索框
        TextInput({ placeholder: '请输入查询的历史纪录', text: this.searchText })
          .placeholderColor('#ff696868')
          .fontSize(25)
          .width('80%')
          .onChange((value:string)=>{
            this.searchText=value
          })
        Image($r("app.media.search"))
          .width('10%')
          .onClick(()=>{
            this.listState=false
            this.matchHis=findAllContains(this.searchText,this.hisConv)
            if(this.matchHis.length==0){
              this.searchText='无搜索结果'
            }
          })
      }
      Row(){
        Text('搜索历史')
          .fontSize(30)
          .fontWeight(300)
      }
      .justifyContent(FlexAlign.Start)
      Column(){
        List(){//历史项
          if(this.listState){
            ForEach(this.hisConv,(item:string,index:number)=>{
              ListItem(){
                Row({space:8}){
                  Text('>')
                    .fontSize(30)
                  Text(item)
                    .fontSize(20)
                }
                .margin(8)
                .justifyContent(FlexAlign.Start)
                .width('95%')

              }
              .onClick(()=>{
                this.shallSave=false
                this.linkedRec=item
                this.listState=true
                //TODO:跳转到Chat传递搜索数据
              })
              .transition({ type: TransitionType.Delete, opacity: 0 })
              .swipeAction({
                end: this.deleteBuilder(this.hisConv,index)
              })
              .width('100%')
            })
          }
          else{
            ForEach(this.matchHis,(item:string)=>{
              ListItem(){
                Row({space:8}){
                  Text('>')
                    .fontSize(30)
                  Text(item)
                    .fontSize(20)
                }
                .margin(8)
                .justifyContent(FlexAlign.Start)
                .width('95%')

              }
              .onClick(()=>{
                this.shallSave=false
                this.linkedRec=item
                this.listState=true
                //TODO:跳转到Chat传递搜索数据
              })
              .width('100%')
            })

          }
        }
      }
      .width('95%')
      .borderRadius(30)
      .onClick(()=>{
        this.listState=true
      })



      Row(){
        Text('清除全部历史')
          .fontSize(20)
          .textAlign(TextAlign.Center)
          .fontColor((this.flag==true)?Color.Red:Color.Black)
          .onClick(()=>{
            AlertDialog.show(
              {
                message: '是否删除全部历史查询记录',
                buttons: [
                  {
                    value: '确认',
                    action: () => {
                      this.hisConv=[]
                      this.historyInfo.hisConv=this.hisConv
                      this.kvStore?.put(this.account, JSON.stringify(this.historyInfo), (err) => {
                        if (err !== undefined) {
                          console.error(`历史信息保存失败！ Code:${err.code},message:${err.message}`)
                          return
                        }
                      })
                    }
                  },
                  {
                    value: '取消',
                    action: () => {}
                  }
                ],
              })
          })
      }
      .onHover((isHover?:boolean)=>{
        if(isHover){
          this.flag=true;
        }
        else{
          this.flag=false
        }
      })

    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .height(800)

  }

  @Builder
  deleteBuilder(history:Array<string>,index:number){
    Image($r('app.media.delete'))
      .width(15)
      .height(15)
      .onClick(()=>{
        history.splice(index,1)
        this.hisConv=history
        this.historyInfo.hisConv=this.hisConv
        this.kvStore?.put(this.account, JSON.stringify(this.historyInfo), (err) => {
          if (err !== undefined) {
            console.error(`历史信息保存失败！ Code:${err.code},message:${err.message}`)
            return
          }
        })
      })
  }
}