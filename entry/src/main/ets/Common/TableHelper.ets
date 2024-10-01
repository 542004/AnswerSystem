import ColumnInfo from '../viewmodel/ColumnInfo'

class TableHelper{
  createTableSql(tableName:string,columns:Array<ColumnInfo>):string{
    let sql=`create table if not exists ${tableName}(`
    for(let column of columns){
      sql = sql.concat(`${column.name} ${column.type}`)
      sql = sql.concat(`${column.length && column.length > 0 ? `(${column.length})` : ''}`)
      sql = sql.concat(`${column.primary ? ' primary key' : ''}`)
      sql = sql.concat(`${column.autoincrement ? ' autoincrement' : ''}`)
      sql = sql.concat(`${column.nullable ?  '': ' not null'}`)
      sql = sql.concat(', ')
    }
    sql = `${sql.substring(0,sql.length-2)} )`
    return sql
  }

  addTableColumnSql(tableName:string,column:ColumnInfo):string{
    let sql = `alter table ${tableName} add`
    sql = sql.concat(`${column.name} ${column.type}`)
    sql = sql.concat(`${column.length && column.length > 0 ? `(${column.length})` : ''}`)
    return sql
  }

  deleteTableSql(tableName:string):string{
    return `drop table if exists ${tableName}`
  }
}

const tableHelper = new TableHelper()

export default tableHelper