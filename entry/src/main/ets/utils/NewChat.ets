/**
 * 新建对话功能
 */
import PreferenceUtil from './PreferenceUtil';
export class NewChat {
  // 创建新聊天会话的方法
  static async createNewChat(cun: string[]): Promise<void> {
    // 生成新的对话ID
    const dialogueID = generateDialogueID();
    // 保存当前对话到数据库
    for (let index = 0; index < 100; index++) {
      if (cun[index]) {
        await PreferenceUtil.putPreferenceValue(`talk${dialogueID}.${index}`, cun[index]);
        console.log(`成功存入了一条信息信息为 talk${dialogueID}.${index}` + cun[index])
      }
    }
  }
}
// 生成对话ID
/**
 *生成的id利用了getTime函数,id唯一固定的时间
 */
function generateDialogueID() {
  const now = new Date();
  return `${now.getTime()}`;
}
