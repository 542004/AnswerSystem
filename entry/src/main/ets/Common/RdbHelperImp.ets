import { relationalStore, ValueType } from '@kit.ArkData';
import { RdbHelper } from './RdbHelper';
import ColumnInfo from '../viewmodel/ColumnInfo';
import tableHelper from './TableHelper'
import rdb from '@ohos.data.rdb';

export class RdbHelperImp implements RdbHelper{
  private myDatabaseName:string
  private rdbStore:relationalStore.RdbStore= {} as relationalStore.RdbStore
  private storeConfig:relationalStore.StoreConfig={
    name:'',
    securityLevel:relationalStore.SecurityLevel.S1
  } as relationalStore.StoreConfig

  constructor(databaseName:string) {
    this.myDatabaseName=databaseName
  }

  getDbName(){
    return this.myDatabaseName
  }

  getRdb(context:Context):Promise<RdbHelper>{//返回一个Promise<RdbHelper>//成功状态代表this.rdbStore已被获取，失败抛出异常
    this.storeConfig={
      name:this.myDatabaseName,
      securityLevel:relationalStore.SecurityLevel.S1
    }
    return new Promise<RdbHelper>((resolve,reject)=>{
      relationalStore.getRdbStore(context,this.storeConfig).then((dbStore)=>{
        this.rdbStore=dbStore
        resolve(this)//返回RdbHelperImp对象
      }).catch((err:Error)=>{
        reject(err)
      })
    })
  }

  executeSql(sql: string,bindArgs?:Array<ValueType>): Promise<void> {
    return this.rdbStore.executeSql(sql,bindArgs)
  }

  createTable(tableName: string, columns: ColumnInfo[]): Promise<void> {
    let createTableSql=tableHelper.createTableSql(tableName,columns)
    return this.executeSql(createTableSql)
  }

  deleteTable(tableName: string): Promise<void> {
    let deleteTableSql =tableHelper.deleteTableSql(tableName)
    return this.executeSql(deleteTableSql)
  }

  addTableColumn(tableName: string, column: ColumnInfo): Promise<void> {
    let addTableColumnSql = tableHelper.addTableColumnSql(tableName,column)
    return this.executeSql(addTableColumnSql)
  }

  insert(tableName: string, values: relationalStore.ValuesBucket): Promise<number> {
    return this.rdbStore.insert(tableName,values)
  }

  batchInsert(tableName: string, values: relationalStore.ValuesBucket[]): Promise<number> {
    return this.rdbStore.batchInsert(tableName,values)
  }

  update(values: relationalStore.ValuesBucket, rdbPredicates: relationalStore.RdbPredicates): Promise<number> {
    return this.rdbStore.update(values,rdbPredicates)
  }

  delete(rdbPredicates: relationalStore.RdbPredicates): Promise<number> {
    return this.rdbStore.delete(rdbPredicates)
  }

  query(rdbPredicates: relationalStore.RdbPredicates,
    columns?: string[] | undefined): Promise<relationalStore.ResultSet> {
    return this.rdbStore.query(rdbPredicates,columns)
  }

  queryAll(tableName:string): Promise<relationalStore.ResultSet> {
    return this.rdbStore.querySql(`select * from ${tableName}`)
  }

  querySql(sql: string,bindArgs?:Array<ValueType>): Promise<relationalStore.ResultSet> {
    return this.rdbStore.querySql(sql,bindArgs)
  }


}