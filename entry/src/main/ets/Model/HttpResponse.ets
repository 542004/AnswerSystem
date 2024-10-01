/**
 * 接入AI接口时 接受数据
 */
export class HttpResponse {
  code : number = 0
  message1 : string = ''
  sid : string = ''
  choices : choice[] = []
}

class choice {
  message : message = {role : '',content : ''}
  index : number = 0
}

class message {
  role : string = ''
  content : string = ''
}