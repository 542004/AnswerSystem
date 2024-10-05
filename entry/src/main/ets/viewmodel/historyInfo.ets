export default class historyInfo{
  account:string=''
  hisConv:Array<string>=[]//历史数据

  constructor(account:string) {
    this.account=account
  }
}