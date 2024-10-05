/**
 * 主题修改
 */
import PreferenceUtil from '../utils/PreferenceUtil'
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ThemePage {
  @State message: string = '主题';
  @State number1 : string = '30'
  @State lin : string = '0'


  aboutToAppear(): void {
    PreferenceUtil.getPreferenceValue('loginname',false)
      // .then((value) => {
      //   if (value != null || value != undefined) {
      //     this.lin = value?.toString()
      //   }
      // })
      // .catch((error: Error) => {
      //   console.error('获取值时出现错误', error);
      // });
    PreferenceUtil.getPreferenceValue('zihao','flase')
      .then((value) => {
        if (value != null || value != undefined) {
          this.lin = value?.toString()
        }
      })
      .catch((error: Error) => {
        console.error('获取值时出现错误', error);
      });
  }
  build() {
    Column() {
      Text('字体设置')
        .fontSize(50)
      Row() {
        Slider({
          min : 20,
          max : 50,
          value : Number(this.lin)
        })
          .onChange(value => {
            this.number1 = value.toString()
          })
          .width(300)
        Text(this.number1)
          .fontSize(Number(this.number1))
      }
      .width('100%')
      .height(100)
      Row() {
        Button('确认')
          .onClick(() => {
            PreferenceUtil.putPreferenceValue('zihao',Number(this.number1))
            // router.replaceUrl({
            //   url:'pages/Index',
            //   params:{}
            // })
            router.back()
          })
      }
    }
    .height('100%')
    .width('100%')
  }
}