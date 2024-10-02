/**
 * 常见问题
 * 点击问题后回答弹窗
 */
import {QA} from '../pages/CommonQuestion'

@CustomDialog
struct AnswerDialog{
  controller:CustomDialogController=new CustomDialogController({
    builder:AnswerDialog
  })//必须有
  @Prop DataItem:QA
  build() {
    Column(){
      Text("问: "+this.DataItem.question)
        .fontSize(18)
      Text("答: "+this.DataItem.answer)
        .fontSize(18)
        .margin({top:10})
    }
    // .backgroundColor('#ffefeee4')
    .alignItems(HorizontalAlign.Start)
    .margin({left:15,right:15})
    .padding(10)
  }
}
@Component
export struct AnswerDialogUser {
  @Prop DataItem:QA
  //创建构造器，与装饰器呼应相连。
  dialogController:CustomDialogController=new CustomDialogController({
    builder:AnswerDialog({DataItem:this.DataItem}),
    width:'95%',
    height:this.DataItem.question.length*1.2+this.DataItem.answer.length*1.2+100,
    openAnimation: {
      duration: 360,
      curve: Curve.Friction,
      delay: 200,
      playMode: PlayMode.Alternate,
      onFinish: () => {
        console.info('play end')
      }
    },
    cornerRadius:5
  })
  build() {
    Row(){
      Column(){
        Text(this.DataItem.question)
          .fontSize(20)
      }.width('85%').alignItems(HorizontalAlign.Start)

      Column(){
        Image($r('app.media.selright')).width(40).height(40)
          .onClick(()=>{
            this.dialogController.open()
          })
      }.width('15%')
    }
    // .backgroundColor('#fff9f9fa')
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .borderRadius(15)
    .margin({left:15,right:15})
    .padding(10)

  }
}