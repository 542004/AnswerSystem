@Component
export default struct TextInputWidget {
  //显示内容
  @Link content: string
  // 文本框左侧图片
  private inputImage?: Resource
  // 文本框提示
  private hintText?: string
  build() {
    Row() {
      Image(this.inputImage !== undefined ? this.inputImage : '')
        .width(30)
        .height(30)
        .margin({ left: 8 })
      //placeholder设置无输入时的提示文本；text设置输入框当前的文本内容
      TextInput({ placeholder: this.hintText, text: this.content })
        .fontSize(20)
        .padding({ left: 5 })
        .placeholderColor('#ebebeb')
        .backgroundColor(Color.White)
        .fontWeight(FontWeight.Normal)
        .fontStyle(FontStyle.Normal)
        .fontColor('#ce1c1b1b')
        .margin({ right: 8 })
        .layoutWeight(1)
        .height(55)
        .enableKeyboardOnFocus(false)
          //绑定onChange事件可以获取输入框内改变的内容
        .onChange((value) => {
          this.content = value //获取TextInput组件的值
        })
    }
    .margin({ top: 10 })
    .borderRadius(21) //边框半径
    .backgroundColor(Color.White) //背景色为白色
    .width('92%')
    .height(60)
  }
}