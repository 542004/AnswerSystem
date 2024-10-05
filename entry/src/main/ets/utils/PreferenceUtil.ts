import preferences from '@ohos.data.preferences';
import { KeyboardAvoidMode } from '@kit.ArkUI';
/**
 * 该项目目前有两个首先项工具类
 * 该工具类初始用于Chat.ets，WelcomePages.ets文件中，分别用于存储对话历史记录和应用启动时是否同一服务
 * （可以还要其他地方使用到，我没有发现）
 * 另一个首先项工具类封装在Common文件夹
 *
 * 后续考虑把两个合并
 */
class PreferenceUtil{
  private pref: preferences.Preferences

  async loadPreference(context){
    try { // 加载preferences
      this.pref = await preferences.getPreferences(context, '成功')
      console.log('加载成功')
    } catch (e) {
      console.log('加载失败')
    }
  }

  async putPreferenceValue(key: string, value: preferences.ValueType){
    if (!this.pref) {
      console.log('Preferences尚未初始化')
      return
    }
    try {
      // 写入数据
      await this.pref.put(key, value)
      await this.pref.flush()
      console.log(`保存Preferences[${key} = ${value}]成功`)
    } catch (e) {
      console.log(`保存Preferences[${key} = ${value}]失败`, JSON.stringify(e))
    }
  }

  async delPreference( key : string) {
    try {
      await this.pref.delete(key)

      await this.pref.flush()
      console.log('销毁成功')
    } catch (err) {
      console.error('销毁失败')
      console.error('err: ', JSON.stringify(err))
    }
  }

  async getPreferenceValue(key: string, defaultValue: preferences.ValueType){
    if (!this.pref) {
      console.log(`Preferences尚未初始化！`)
      return
    }
    try {
      // 读数据
      let value = await this.pref.get(key, defaultValue)
      console.log(`读取Preferences[${key} = ${value}]成功`)
      return value
    } catch (e) {
      console.log(`读取Preferences[${key}]失败`, JSON.stringify(e))
    }
  }

}

const preferenceUtil = new PreferenceUtil()

export default preferenceUtil as PreferenceUtil