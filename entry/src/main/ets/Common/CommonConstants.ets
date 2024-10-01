import CommonConstantsInfo from '../viewmodel/CommonConstantsInfo'
export default class CommonConstants{
  static readonly HISTORY_PREF:string='historyPreference'
  static readonly USER_PREF:string='userPreference'
  static readonly SETTINGS_PREF:string='settingsPreference'
  static readonly USER_INFO ={
    columns:[
      'account',
      'nickName',
      'sex',
      'birthDay',
      'signature'
    ]
  } as CommonConstantsInfo

}