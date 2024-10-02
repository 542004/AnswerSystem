/**
 * 主题修改
 */
@Entry
@Component
struct ThemePage {
  @State message: string = '主题';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('ThemeHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}