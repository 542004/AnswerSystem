# 运行环境

DevEco5.0.3

# 页面大致分类

主页面；

历史记录页面；

个人中心页面，个人信息修改页面，偏好设置修改页面，登录界面；

常见问题页面；

理想汽车展示页面，汽车详情页面

# 剩余内容

* Chat组件和菜单弹窗组件的UI设计，最新历史记录BriefHistory由一个人弄好，然后直接调用
  完善Chat组件在view > Chat；在此基础上进行修改即可
  菜单弹窗组件 view > menu

  **Chat效果图**
  ![Chat](../../../../OneDrive/桌面/Chat.png)点击常见问题就跳转到“常见问题**页面**CommonQuestion”

  点击菜单就从左边弹出一个弹窗

* 新建对话功能NewChat
  utils> NewChat

* 历史记录详情UI设计，菜单弹窗中的最新历史记录BriefHistory

  历史详情记录 view > History

  最新历史记录 view > BriefHistory

  历史记录只显示用户的每组对话（第一条提问作为一组对话的标题），**点击后跳转Chat页面并展示历史对话内容**

* 常见问题页面，每行只显示问题，每个问题点击**下拉后展示问题的回答**

  常见问题页面 pages > CommonQuestion

* 个人中心，登录注册界面**美化**即可，主题的修改
  主题包含字号大小即可

  个人中心：view > Mine

  登录注册： pages > Login     pages > Regist

  主题：pages > Theme

# 分工

> 第一次分工没有经验，工作量有多有少，快的可以给工作量大的分担压力，感谢！！！
>
> 对于协助的模块写上一些关键的注释，便于他人阅读
>
> 最后，初始代码绝大部分都是史辰和支雨晨（AI接口的接入，欢迎界面）写的，如果有看不懂代码的地方可以询问作者

## 史辰

历史详情记录 view > History

最新历史记录 view > BriefHistory（提供给林琦峻调用）

## 支雨晨

个人中心：view > Mine

登录注册： pages > Login     pages > Regist

主题：pages > Theme

## 林琦峻

完善Chat组件在view > Chat；（常见问题和新建对话直接调用何嘉豪和黄令群写的就行）
菜单弹窗组件 view > menu （最新历史记录调用史辰的）

## 何嘉豪

新建对话功能NewChat
utils> NewChat（提供给林琦峻调用）

## 黄令群

常见问题页面 pages > CommonQuestion（提供给林琦峻调用）

