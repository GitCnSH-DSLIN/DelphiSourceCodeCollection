program  Splitter;

{$R '..\Other\Other.res' '..\Other\Other.txt'}

uses
  Windows,

  { ������ע�ᴰ���� }
  MainForm    in  'MainForm.pas',   // ����������   'Splitter_MainForm_Mazi'
  HintForm    in  'HintForm.pas',   // ������ʾ��   'Splitter_HintForm_Mazi'

  { ϵͳԤ���崰���� }
  Panels      in  'Panels.pas',     // ��׼�Ի���    WC_DIALOG
  EditCtrl    in  'EditCtrl.pas',   // �༭��ؼ�   'EDIT'
  ListBox     in  'ListBox.pas',    // �б��ؼ�   'LISTBOX'
  Buttons     in  'Buttons.pas',    // ��ť�ؼ�     'BUTTON'
  GroupBox    in  'GroupBox.pas',   // ��ѡ��ť��   'BUTTON'
  ComboBox    in  'ComboBox.pas',   // ������ؼ�   'COMBOBOX'

  { Comctl32ͨ�ÿؼ� }
  Tooltip     in  'Tooltip.pas',    // ������ʾ�ؼ�  'tooltips_class32'
  TabCtrl     in  'TabCtrl.pas',    // ��ҳ��ǩ�ؼ�  'SysTabControl32'
  ImageList   in  'ImageList.pas',  // ͼ���б�ؼ�  (��ҳ��ǩ�ϵ�ͼ��)

  { comdlg32ͨ�öԻ� }
  DialogBox   in  'DialogBox.pas',  // �ļ�ѡ�񱣴�Ի���

  { �ļ����� }
  CutFile     in   'CutFile.pas',   // �и��ļ��߳�
  JoinFile    in   'JoinFile.pas',  // �ϲ��ļ��߳�

  { ������Ԫ }
  PanelMouse  in  'PanelMouse.pas', // ����Panel3�������Ϣ
  PaintLabel  in  'PaintLabel.pas', // ����Panels�ϸ�������
  ButtonClick in  'ButtonClick.pas',// ����Panels�ϰ�ť����
  ListMouse   in  'ListMouse.pas',  // ����ListBox�����Ϣ
  ListUnit    in  'ListUnit.pas',   // ListBox��غ���,����
  PublicUnit  in  'PublicUnit.pas'; // ���ù��õ� ����,����  

var
  theMessage: TMsg;

begin
//...�����ؼ�...//
  Create_OurFont;
  Create_MainForm;
  Create_ImageList;
  Create_TabCtrl;
  Create_Panels;
  Create_Buttons;
  Create_Edits;
  Create_GroupBox;
  Create_ComboBox;
  Create_ListBox;
  Create_Tooltip;
  Create_HintForm;

//...��Ϣѭ��...//
  while GetMessage(theMessage, 0, 0, 0) do
  begin
    TranslateMessage(theMessage);
    DispatchMessage(theMessage);
  end;

//...�����߳�...//
  if (CurState = 1) then Stop_Cut
  else if (CurState = 2) then Stop_Join;

{ �˴������ٵ���InitCommonControlsʹcomctl32.dll�Զ�װ��,
  ��Ϊ�������Ѿ�������comctl32.dll�е�ImageList_Create. }
end.
