import { relationalStore } from '@kit.ArkData';
import userInfo from '../viewmodel/userInfo';
import CommonConstants  from './CommonConstants';
import RdbUtils from './RdbUtils';

class userInfoApi {

  async insertData(userInfo: userInfo): Promise<void> {
    let account:string=userInfo.account
    let nickName:string=userInfo.nickName
    let sex:string=userInfo.sex
    let birthDay:string=userInfo.birthDay
    let signature :string=userInfo.signature
    let sql:string="insert into UserInfo values(?,?,?,?,?)"
    RdbUtils.executeSql(sql,[account,nickName,sex,birthDay,signature]).then(()=>{
      console.info('successfully insert')
    }).catch((err:Error)=>{
      console.error(`fail to update :${err}`)
    })
  }

  deleteDataByAccount(userInfo: userInfo): Promise<number>{
    let tableName = 'UserInfo';
    let predicates = new relationalStore.RdbPredicates(tableName);
    predicates.equalTo('account', userInfo.account);
    return RdbUtils.delete(predicates).then(result => {
      return result
    });
  }

  /**
   * update taskInfo
   *
   * @param taskInfo
   * @param callback
   */
  async updateDataByAccount(userInfo: userInfo): Promise<void>{
    let account :string=userInfo.account
    let nickName:string=userInfo.nickName
    let sex:string=userInfo.sex
    let birthDay:string=userInfo.birthDay
    let signature :string=userInfo.signature
    let sql:string="update UserInfo set nickName=?, sex=?, birthDay=?, signature=? where account = ?"
    console.info('update run')
    RdbUtils.executeSql(sql,[nickName,sex,birthDay,signature,account]).then(()=>{
      console.info('successfully updated')
      RdbUtils.queryBySql("select * from UserInfo").then((resultSet)=>{
        let count = resultSet.rowCount;
        if ( count==0 ) {
          const result: userInfo[] = [];
          console.info('查询出空值')
          return result;
        } else {
          const result: userInfo[] = [];
          console.info(`查询语句执行.....`)
          while(resultSet.goToNextRow()){
            console.info(`查询结果${resultSet.getString(resultSet.getColumnIndex('account'))}`)
            console.info(`查询结果2${resultSet.getString(resultSet.getColumnIndex('nickName'))}`)
          }
          resultSet.close()

          return result;
        }
      })
    }).catch((err:Error)=>{
      console.error(`fail to update :${err}`)
    })


  }

  /**
   * query taskInfo
   *
   * @param date
   * @param callback
   */
  async query(account: string): Promise<userInfo[]> {
    let sql:string="select * from UserInfo where account = ?"
    return RdbUtils.queryBySql(sql,[account]).then(resultSet => {
      let count = resultSet.rowCount;
      if ( count==0 ) {
        const result: userInfo[] = [];
        console.info('查询出空值')
        return result;
      } else {
        const result: userInfo[] = [];
        let i :number=0
        console.info(`查询语句执行.....`)
        while(resultSet.goToNextRow()) {
          let tmp:userInfo = new userInfo(account,'','','','');
          tmp.account = resultSet.getString(resultSet.getColumnIndex('account'))
          tmp.nickName=resultSet.getString(resultSet.getColumnIndex('nickName'))
          tmp.sex=resultSet.getString(resultSet.getColumnIndex('sex'))
          tmp.birthDay=resultSet.getString(resultSet.getColumnIndex('birthDay'))
          tmp.signature=resultSet.getString(resultSet.getColumnIndex('signature'))
          result[i] = tmp;
          i++
          console.info('successfully query')
        }
        resultSet.close()

       return result;
      }
    })
  }
}

function generateBucket(userInfo: userInfo): relationalStore.ValuesBucket {
  let valueBucket = {} as relationalStore.ValuesBucket;
  CommonConstants.USER_INFO.columns?.forEach((item: string) => {
    if (item !== 'account') {
      switch (item) {
        case 'nickName':
          valueBucket[item] = userInfo.nickName;
          break;
        case 'sex':
          valueBucket[item] = userInfo.sex;
          break;
        case 'birthDay':
          valueBucket[item] = userInfo.birthDay;
          break;
        case 'signature':
          valueBucket[item] = userInfo.signature;
          break;
        default:
          break;
      }
    }
  });
  return valueBucket;
}

let UserInfoApi=new userInfoApi()

export default UserInfoApi