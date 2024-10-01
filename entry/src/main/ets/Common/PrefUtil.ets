import globalContext from './GlobalContext'
import {preferences} from '@kit.ArkData'
import {Context} from '@ohos.abilityAccessCtrl'

export class PrefUtil{
  createPreferences(context:Context,preferenceName:string){
    let valuePreferences:Function=(()=>{
      let preference:Promise<preferences.Preferences>=preferences.getPreferences(context,preferenceName)
      return preference
    })
    globalContext.getInstance().setValue(preferenceName,valuePreferences)
  }

  saveValue(key:string ,value:Object,preferenceName:string){
    let PreferenceGetter:Function=globalContext.getInstance().getValue(preferenceName)as Function
    PreferenceGetter().then(async (preference:preferences.Preferences)=>{
      await preference.put(key,value)
      preference.flush()
    }).catch((err:Error)=>{
      console.error('获取preferences失败,err:'+err)
    })
  }

  async getValue(key:string,preferenceName:string){
    let value:string=''
    let preferenceGetter:Function=globalContext.getInstance().getValue(preferenceName) as Function
    value=await (await preferenceGetter()).get(key,value)
    return value
  }

  async hasKey(key:string,preferenceName:string){
    let preferenceGetter:Function=globalContext.getInstance().getValue(preferenceName)as Function
    let judge:boolean=await(await preferenceGetter()).has(key)
    return judge
  }

  async deleteValue(key:string,preferenceName:string){
    let preferenceGetter:Function=globalContext.getInstance().getValue(preferenceName)as Function
    await(await preferenceGetter()).delete(key)
    await(await preferenceGetter()).flush()
    console.info('我的键值被删除了！')
  }

  async clearCity(preferenceName:string){
    let codePreferenceGetter:Function=globalContext.getInstance().getValue(preferenceName)as Function
    await(await codePreferenceGetter()).clear()
    await(await codePreferenceGetter()).flush()
    console.info('我的键值全被删除了！')
  }
}

export default new PrefUtil()