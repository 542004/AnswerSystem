export default class ColumnInfo{//表的列信息
  name:string
  type:string
  length?:number
  nullable?:boolean
  primary?:boolean
  autoincrement?:boolean

  constructor(name:string,type:string,length?:number,nullable?:boolean,primary?:boolean,autoincrement?:boolean) {
    this.name=name
    this.type=type
    this.length = length;
    this.nullable = nullable;
    this.primary = primary;
    this.autoincrement = autoincrement;
  }
}