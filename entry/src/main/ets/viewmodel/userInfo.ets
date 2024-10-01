export default class userInfo {
  account: string = ''
  nickName: string = ''
  sex: string = ''
  birthDay:string=''
  signature:string=''

  constructor(account: string, nickName: string, sex: string,birthDay:string,signature:string) {
    this.account = account
    this.nickName = nickName
    this.sex = sex
    this.birthDay=birthDay
    this.signature=signature
  }
}