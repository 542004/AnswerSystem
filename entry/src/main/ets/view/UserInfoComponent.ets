/**
 * 个人中心的用户信息组件
 */
import CommonConstants from '../Common/CommonConstants'
import router from '@ohos.router'
import distributedKVStore from '@ohos.data.distributedKVStore'
import promptAction from '@ohos.promptAction'
import userInfo from '../viewmodel/userInfo'
import userInfoApi from '../Common/UserInfoRdbApi'
import TextInputWidget from '../viewmodel/TextInputwidget'

@Component
export struct UserInfoComponent {
  @Consume userInfo :userInfo
  @State nickName:string=this.userInfo.nickName
  @State sex:string=this.userInfo.sex
  @State birthDay:string=this.userInfo.birthDay
  @State signature :string=this.userInfo.signature

  private kvManager: distributedKVStore.KVManager | null = null
  //声明KVStore对象
  private kvStore: distributedKVStore.SingleKVStore | null = null

  saveInfo:userInfo=this.userInfo

  async aboutToAppear() {
    console.info(`这是用户信息组件的账户状态：${this.userInfo.account}`)
    userInfoApi.query(this.userInfo.account).then(result=>{
      this.nickName=result[0].nickName
      this.sex=result[0].sex
      this.birthDay=result[0].birthDay
      this.signature=result[0].signature
    })
    //this.installPreference()
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
        this.kvManager.getKVStore('Info', options, (err, kvStore: distributedKVStore.SingleKVStore) => {
          if (err) {
            console.error(`无法获取KVStore。 Code:${err.code},message:${err.message}`)
            return
          }
          console.info('成功获取KVStore')
          this.kvStore = kvStore
          //通过get获取指定键的值
          this.kvStore?.get('userInfo').then((res) => {
            //通过JSON.parse()解析数据，再使用as断言进行类型转换
            let userModel = JSON.parse(res.toString()) as userInfo
            //对下面五个状态变量进行赋值
            this.nickName = userModel.nickName
            this.birthDay = userModel.birthDay
            this.sex = userModel.sex
            this.signature = userModel.signature
          })
        })
      } catch (e) {
        console.error(`出现意外错误，Code:${e.code},message:${e.message}`)
      }
    } catch (e) {
      console.error(`未能创建KVManager，Code:${e.code},message:${e.message}`)
    }
  }

  build() {
    Column() {
      Row() {
        //返回之前的页面
        Image($r('app.media.fanhui'))
          .width(25)
          .aspectRatio(1)
          .onClick(() => {
            router.back()
          })
        Row({ space: 50 }) {
          Text('保存').fontSize(20).fontColor(Color.Red)//为'保存'文本框添加onClick事件
        }
        .onClick(() => {
          if (this.nickName === '' || this.birthDay === '' || this.sex === '' || this.signature === '') {
            AlertDialog.show({
              message: '请将个人信息填写完整！'
            })
            return
          }
          this.saveInfo.nickName=this.nickName
          this.saveInfo.birthDay=this.birthDay
          this.saveInfo.sex=this.sex
          this.saveInfo.signature=this.signature
          userInfoApi.updateDataByAccount(this.saveInfo)
          promptAction.showToast({ message: '个人信息保存成功！' })

          /**
          //保存个人账户信息数据
          this.saveInfo.nickName=this.nickName
          this.saveInfo.sex=this.sex
          this.saveInfo.birthDay=this.birthDay
          this.saveInfo.signature=this.signature
          console.info('save run')
          //使用JSON.stringify()将对象转换为字符串
          this.kvStore?.put("userInfo", JSON.stringify(this.saveInfo), (err) => {
            if (err !== undefined) {
              console.error(`个人信息保存失败！ Code:${err.code},message:${err.message}`)
              return
            }
            promptAction.showToast({ message: '个人信息保存成功！' })
          })
          **/
        })
        .layoutWeight(1)
        .justifyContent(FlexAlign.End)
        .padding({
          right: 10
        })
      }
      .width('100%')
      .height(50)
      .margin({
        top: 5
      })
      .padding({
        left: 10,
        right: 10
      })
      /*
       * 个人信息
       * */

      Image($r('app.media.avatar'))
        .width(50)
        .height(50)
        .alignSelf(ItemAlign.Center)
        .margin({ top: '5.5%' })

      Text('头像')
        .fontColor(Color.Black)
        .fontSize(25)
        .margin({ top: '2.1%' })
        .alignSelf(ItemAlign.Center)
      /*
       * 昵称
       * */
      TextInputWidget({
        inputImage: $r('app.media.ic_nickname'),
        hintText: '昵称',
        content: this.nickName
      })
      /*
       * 出生日期
       * */
      TextInputWidget({
        inputImage: $r('app.media.ic_birthday'),
        hintText: '出生日期',
        content: this.birthDay
      })
      /*
       * 性别
       * */
      TextInputWidget({
        inputImage: $r('app.media.ic_sex'),
        hintText: '性别',
        content: this.sex
      })
      /*
       * 个性签名
       * */
      TextInputWidget({
        inputImage: $r('app.media.ic_signature'),
        hintText: '个性签名',
        content: this.signature
      })

    }
    .backgroundColor('#ebebeb')
    .width('100%')
    .height('100%')
  }
}