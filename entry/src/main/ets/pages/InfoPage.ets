import userInfo from '../viewmodel/userInfo'
import router from '@ohos.router';
import UserInfoRdbApi from '../Common/UserInfoRdbApi'
import {UserInfoComponent} from '../view/UserInfoComponent';

@Entry
@Component
struct InfoPage{
  @State account :string =(router.getParams() as Record<string,string>)['account']
  @Provide userInfo:userInfo=new userInfo(this.account,'','','','')
  aboutToAppear() {
    console.info(`InfoPage的account有值！${this.account}`)
    UserInfoRdbApi.query(this.account).then((result)=>{
      if(result.length!=0){
        this.userInfo=result[0]
        console.info(`我执行了！`)
      }else{
        UserInfoRdbApi.insertData(this.userInfo)
      }

    })

  }

  build(){
    Column(){
      UserInfoComponent()
    }
  }
}