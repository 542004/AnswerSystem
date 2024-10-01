import {relationalStore, ValueType} from '@kit.ArkData'
import columnInfo from '../viewmodel/ColumnInfo'
export interface RdbHelper{
  getDbName():string

  getRdb(context:Context):Promise<RdbHelper>

  executeSql(sql:string,bindArgs?:Array<ValueType>):Promise<void>

  createTable(tableName:string,columns:Array<columnInfo>):Promise<void>
  deleteTable(tableName:string):Promise<void>
  addTableColumn(tableName:string,column:columnInfo):Promise<void>

  insert(tableName:string,values:relationalStore.ValuesBucket):Promise<number>

  batchInsert(tableName:string,values:Array<relationalStore.ValuesBucket>):Promise<number>

  update(values:relationalStore.ValuesBucket,rebPredicates:relationalStore.RdbPredicates):Promise<number>

  delete(redPredicates:relationalStore.RdbPredicates):Promise<number>

  query(rdbPredicates:relationalStore.RdbPredicates,columns?:Array<string>):Promise<relationalStore.ResultSet>

  queryAll(tableName:string):Promise<relationalStore.ResultSet>

  querySql(sql:string,bindArgs?:Array<ValueType>):Promise<relationalStore.ResultSet>//静态SQL
}