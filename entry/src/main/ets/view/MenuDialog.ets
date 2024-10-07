@CustomDialog
export struct MyCustomDialog{
  controller:CustomDialogController
  @Link message:string[]
  @Link text:string
  change:Function=()=>{

  }


  aboutToAppear(): void {
    console.info('jiancha'+this.message)

  }

  build() {
    Column(){
      Row(){
        Text('最近历史').fontSize(20)
          .fontColor('#ff67b5f5')

        Text('新建对话').fontSize(20)
          .fontColor('#ff67b5f5')
          .onClick(()=>{
            this.change()
            this.controller.close()
          })
      }
      .margin({top:20,left:30,right:30})
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)


      if(this.message.length==0){
        Text('暂无历史记录')
          .margin({top:20})
      }else{
        List(){
          ForEach(this.message,(value:string,index:number)=>{
            ListItem(){
              if(index<=7){
                Row(){
                  Text(value)
                    .fontSize(20)
                }
                .width('100%')
                .height(70)
              }

            }
            .onClick(()=>{
              this.text=value
              this.controller.close()
            })

            .margin(5)
            .backgroundColor('#66ffffff')
          })
        }
        .margin({top:20})
        .scrollBar(BarState.Off)
      }


    }
    .height('100%')
    .width('90%')

  }
}