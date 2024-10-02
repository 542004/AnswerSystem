import http from '@ohos.net.http';
import hilog from '@ohos.hilog';
import { HttpResponse} from '../Model/HttpResponse';
/**
 * 请求AI的api
 */
class HttpUtils {
  request(question: string): Promise<string> {
    return new Promise((resolve, reject) => {
      hilog.info(0x0000, 'testTag', 'HttpUtils request invoke. question: %{public}s', question);

      let httpRequest = http.createHttp();

      httpRequest.request(
        "https://spark-api-open.xf-yun.com/v1/chat/completions",
        {
          method: http.RequestMethod.POST,
          header: {
            "Content-Type": "application/json",
            "Authorization": "Bearer jJnzYjOputBwdNrsIKki:nFzJGyqUhWJFoirXVcYl"
          },
          extraData : {
            "model": "general",
            "messages": [
              {
                "role": "user",
                "content": question
              }
            ]
          }
        },
        (err, data: http.HttpResponse) => {
          if (err) {
            hilog.error(0x0000, 'testTag', 'Failed to request ALiYun. Cause: %{public}s', JSON.stringify(err) ?? '');
            httpRequest.destroy();
            reject('错误');
          } else {
            hilog.error(0x0000, 'testTag', 'Request ALiYun success. data: %{public}s', JSON.stringify(data.result));
            let resp: HttpResponse = JSON.parse(data.result.toString());
            httpRequest.destroy();
            if (resp && resp.choices && resp.choices.length > 0 && resp.choices[0].message) {
              resolve(resp.choices[0].message.content);
            } else {
              resolve('输入出现错误，请重新输入')
            }

          }
        }
      );
    });
  }
}

export default new HttpUtils();
