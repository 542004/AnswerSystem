/**
 * 常见问题页面
 */
import { router } from '@kit.ArkUI';
import { AnswerDialogUser} from '../view/AnswerDialog'
export class QA{
  question:string='';
  answer:string='';
  constructor(question:string,answer:string) {
    this.question=question;
    this.answer=answer;
  }
}
//初始化
function init(Data:QA[]){
  Data.push(new QA(
    "理想L7充电一般充到百分之多少？",
    "为了更好地保护电池，建议在电量降至20%时进行充电，充至80%-98%即可。在充电设置中可以操作最低电量设置。如需经常充电，可考虑购买家用快充桩，方便且快速。"
  ))
  Data.push(new QA(
    "频繁充电是否会影响电池寿命？",
    "电池的最终寿命实际上主要取决于“循环次数”。"
  ))
  Data.push(new QA(
    "下雨天在室外充电有无安全隐患？",
    "通常来讲，在室外雨天环境中充电是安全的。但为了保险起见，下暴雨的情况下，还是建议大家暂缓室外充电。"
  ))
  Data.push(new QA(
    "慢充枪拔不出来，有应急解决办法吗？",
    "在后备厢里隐藏了一个应急开关，隐藏在后备厢盖板下面。"
  ))
  Data.push(new QA(
    "长时间不用油有什么影响吗？",
    "增程器方面，检测到28天不启动增程器会自行启动自检一次；汽油方面，根据中国石化的介绍，汽油在3个月内使用都是没问题的。"
  ))
  Data.push(new QA(
    "如果我自行保养更换机油、机滤、空气滤芯、空调滤芯等，会影响理想ONE首任车主增程电动系统十年质保权益吗？",
    "为保证车辆在保养后的整体质量，我们建议您前往我们指定的服务网点，由专业的维修技师使用原厂零部件和机油进行保养，如您自行保养导致所涉及到的相关零部件出现质量问题，则这些相关零部件将不能再享受理想ONE首任车主增程电动系统十年质保权益，其他未涉及到的零部件仍然可以享受理想ONE首任车主增程电动系统十年质保权益。"
  ))
  Data.push(new QA(
    "动力电池衰减到多少，才能免费维修或更换？",
    "在理想ONE首任车主增程电动系统十年质保期内，如果动力蓄电池容量衰减至70%以下，我们将免费为您维修或更换动力蓄电池，以保证您的权益不会减损。当您发现动力蓄电池出现上述容量衰减问题时，您须及时前往理想汽车维修中心，让专业技术人员通过专用仪器进行检测，若确定是质保期内的质量问题，我们将会为您免费维修或更换。"
  ))
  Data.push(new QA(
    "车辆保养到期时是否会有提醒？",
    "会有提醒，当您收到车机端的保养服务需求提示时，您可以通过在车内唤醒“理想同学”或登录理想汽车App进行自助预约，也可以拨打24小时服务热线400-686-0900 联系理想汽车服务专家进行保养预约。"
  ))
  Data.push(new QA(
    "车辆保养是否需要提前预约？",
    "当您收到车机端的保养服务需求提示时，您可以通过在车内唤醒“理想同学”或登录理想汽车App进行自助预约，也可以拨打24小时服务热线400-686-0900 联系理想汽车服务专家进行保养预约。若您未提前进行预约，直接前往服务网点，可能会产生一定的等待时间。"
  ))
  Data.push(new QA(
    "车辆保养时有什么注意事项？",
    "车辆进店前，请您携带智能钥匙、行驶证、驾驶证，按时前往您预约的服务网点进行车辆保养。"
  ))
  Data.push(new QA(
    "车辆保养是否可以自己带零件？",
    "为保证车辆在保养后的整体质量，我们建议您前往我们指定的服务网点，由专业的维修专家使用原厂零部件和机油进行保养，如您自带零件保养导致所涉及到的相关零部件出现质量问题，则这些相关零部件将不能再享受车辆标准质保权益，其他未涉及到的零部件仍然可以享受标准质保权益。"
  ))
  Data.push(new QA(
    "我所在的城市目前还没有直营服务中心，我要如何进行保养？",
    "目前需要您预约前往距离最近的售后服务网点进行保养服务。您可以通过理想汽车App或拨打24小时服务热线400-686-0900 联系理想汽车服务专家，协助您查找最近的服务网点，帮助您进行预约保养。我们会持续在更多城市设立理想汽车服务中心、钣喷中心，以满足更多购车用户就近完成售后保养、维修等需求。"
  ))
}


@Entry
@Component
struct CommonQuestion {
  @State Data: QA[] = [];
  aboutToAppear(): void {
    init(this.Data);
  }

  build() {
    Column(){
      Row(){
        Image($r('app.media.fanhui'))
          .width(26)
          .height(26)
          .onClick(()=>{
            router.back();
          })
          .margin({right:70,left:20})
        Text('常见问题')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height('8%')
      // .margin({bottom:20})
      .backgroundColor('#ffa0c9e0')
      List({space:20}){
        ForEach(this.Data,(item:QA)=>{
          ListItem(){
            AnswerDialogUser({DataItem:item})
          }
          ListItem(){
            Divider()
          }
        })
      }
      .width('100%')
      .height('92%')
      .scrollBar(BarState.Off)
    }
  }
}