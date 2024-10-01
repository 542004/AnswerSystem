export default class globalContext {
  private constructor() {
  }

  public static instance: globalContext
  public toolMap: Map<string, Object> = new Map()

  public static getInstance() {
    if (!globalContext.instance) {
      globalContext.instance = new globalContext()
      return globalContext.instance
    } else {
      return globalContext.instance
    }
  }

  getValue(key: string) {
    return this.toolMap.get(key)
  }
  setValue(key:string,value:Object){
    this.toolMap.set(key,value)
  }
}