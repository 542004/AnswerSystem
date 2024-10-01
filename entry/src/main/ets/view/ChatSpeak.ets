@Preview
@Component
export default struct ChatSpeak {
  build() {
    Column() {
      Row() {
        Text('hahaha')
          .fontSize(25)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .borderRadius(10)
    .width('90%')
    .backgroundColor(Color.Blue)
  }
}