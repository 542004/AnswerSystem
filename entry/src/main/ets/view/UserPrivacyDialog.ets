
/**
 * 使用@CustomDialog声明弹窗组件
 */
@CustomDialog
 struct UserPrivacyDialog {
  Controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({}),
  })
  confirm: () => void = () => {}
  cancel: () => void = () => {}


  build() {
    Column({space: 10 }) {
      //标题
      Text('欢迎使用理想汽车知识回答App')
        .fontSize(40)
        .fontWeight(FontWeight.Medium)
      //内容
      Text('感谢您的信任并使用理想汽车最新知识回答App，我们将通过《用户协议手册》和《理想汽车知识回答App隐私政策》帮助您了解我们收集、使用' +
        '、存储和共享个人信息的情况，特别是我们所采集的个人信息类型与用途的对应关系。此外，如您同意，请点击下方按钮并接受我们的' +
        '服务')
      //按钮
      Button('同意')
        .width(150)
        .onClick(() => {
          this.confirm()
          this.Controller.close()
        })
      Button('不同意')
        .width(150)
        .backgroundColor(Color.Grey)
        .onClick(() => {
          this.cancel()
          this.Controller.close()
        })
    }
    .width('100%')
    .padding(10)
  }
}
export default UserPrivacyDialog;