import ColumnInfo from '../viewmodel/ColumnInfo';

export const columnUserInfoList: Array<ColumnInfo> = [
  new ColumnInfo('account', 'text', -1, false, true, false),
  new ColumnInfo('nickName', 'text', -1, true, false, false),
  new ColumnInfo('sex', 'text', -1, true, false, false),
  new ColumnInfo('birthDay', 'text', -1, true, false, false),
  new ColumnInfo('signature', 'text', -1, true, false, false)
];