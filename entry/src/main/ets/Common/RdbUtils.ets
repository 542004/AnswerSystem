import { relationalStore, ValueType } from '@kit.ArkData';
import ColumnInfo from '../viewmodel/ColumnInfo';
import { RdbHelper } from './RdbHelper';
import { RdbHelperImp } from './RdbHelperImp';
import { Context } from '@kit.AbilityKit';

let dbContext:Context
let myDatabaseName:string=''

export class RdbUtils{
  private rdbHelpers=new Map<string ,RdbHelper>()

  initDb(context:Context,databaseName:string){
    dbContext=context
    myDatabaseName=databaseName
  }

  createDb():Promise<RdbHelper>{
    return new Promise<RdbHelper>((resolve,reject)=>{
      let dbName=myDatabaseName
      if(!dbContext|| !dbName||dbName.length===0){
        reject('init err')
        return
      }
      let dbHelper = this.rdbHelpers.get(dbName)
      if(!dbHelper){
        let rdbHelper:RdbHelper =new RdbHelperImp(dbName)
        rdbHelper.getRdb(dbContext).then((rdbHelper)=>{
          this.rdbHelpers.set(dbName,rdbHelper)
          console.info(`create rdbHelper success`)
          resolve(rdbHelper)
        }).catch((err:Error)=>{
          console.error('create rdbHelper failed')
          reject(err)
        })
      }
      else{
        resolve(dbHelper)
      }
    })
  }

  deleteDb(context:Context,dbName:string):Promise<void>{
    this.rdbHelpers.delete(dbName)
    return relationalStore.deleteRdbStore(context,dbName)
  }

  createTable(tableName:string,columns:Array<ColumnInfo>):Promise<void>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.createTable(tableName,columns)
    })
  }

  isCreateTable(tableName:string,columns:Array<ColumnInfo>):Promise<boolean>{
    return this.createTable(tableName,columns).then(()=>{
      return true
    }).catch((err:Error)=>{
      return false
    })
  }

  deleteTable(tableName:string):Promise<void>{
    return this.createDb().then(dbHelper=>{
      return dbHelper.deleteTable(tableName)
    })
  }

  addTableColumn(tableName:string,column:ColumnInfo):Promise<void>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.addTableColumn(tableName,column)
    })
  }

  executeSql(sql:string,bindArgs?:Array<ValueType> ):Promise<void>{
    return this.createDb().then(dbHelper=>{
      return dbHelper.executeSql(sql,bindArgs)
    })
  }

  insert(tableName:string,value:relationalStore.ValuesBucket):Promise<number>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.insert(tableName,value)
    })
  }

  batchInsert(tableName:string,values:Array<relationalStore.ValuesBucket>):Promise<number>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.batchInsert(tableName,values)
    })
  }

  update(values:relationalStore.ValuesBucket,rdbPredicates:relationalStore.RdbPredicates):Promise<number>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.update(values,rdbPredicates)
    })
  }

  delete(rdbPredicates:relationalStore.RdbPredicates):Promise<number>{
    return this.createDb().then((dbHelper)=>{
      return dbHelper.delete(rdbPredicates)
    })
  }

  query(rdbPredicates:relationalStore.RdbPredicates):Promise<relationalStore.ResultSet>{
    return this.createDb().then(dbHelper=>{
      return dbHelper.query(rdbPredicates)
    })
  }

  queryAll(tableName:string):Promise<relationalStore.ResultSet>{
    return this.createDb().then(dbHelper=>{
      return dbHelper.queryAll(tableName)
    })
  }

  queryBySql(sql:string,bindArgs?:Array<ValueType>):Promise<relationalStore.ResultSet>{
    return this.createDb().then(dbHelper=>{
      return dbHelper.querySql(sql,bindArgs)
    })
  }

}
let rdbUtils=new RdbUtils()

export default rdbUtils as RdbUtils