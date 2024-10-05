import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import PrefUtil from '../Common/PrefUtil'
import RdbUtils from '../Common/RdbUtils'
import userInfoApi from '../Common/UserInfoRdbApi'
import {columnUserInfoList} from '../Model/RdbColumnModel'
import commonConstants from '../Common/CommonConstants'
import userInfo from '../viewmodel/userInfo'
import preferenceUtil from '../utils/PreferenceUtil'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam){
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    PrefUtil.createPreferences(this.context,commonConstants.HISTORY_PREF)
    PrefUtil.createPreferences(this.context,commonConstants.USER_PREF)
    preferenceUtil.loadPreference(this.context)
    RdbUtils.initDb(this.context, 'UserInfoDataBase');
    RdbUtils.createDb()

    RdbUtils.createTable('UserInfo', columnUserInfoList).then(() => {
      console.info(`RdbHelper createTable UserInfo success`);
    }).catch((err: Error) => {
      console.error(`RdbHelper dayInfo err : ${JSON.stringify(err)}`);
    });
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/WelcomePages', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
