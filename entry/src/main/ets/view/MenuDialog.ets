@CustomDialog
export struct MyCustomDialog{
  controller:CustomDialogController

  build() {
    Column(){
      Row(){
        Image($r('app.media.touxiang'))
          .width(75)

      }
      .margin({top:20})
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#fff1f1ff')
  }
}