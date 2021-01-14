unit Public_Unit;

interface

const
  WM_SETFONT = $0030; // ���ÿؼ�������Ϣ
  WM_GETICON = $007F; // ȡָ������ͼ����Ϣ
  
type
 //----�Զ���ͼ�����ṹ----
  IconHandle = record
    WindowIcon: Longword;  //���������ͼ����
    FileIcon  : Longword;  //���̶�Ӧ�ļ���ͼ��
  end;

var
  MyFont_Hanlde : LongWord;      // �߼�������

  WindowHanlde  : LongWord;      // Window���
  Window_hdc    : LongWord;      // ��������ϵ�豸����
  ListViewHanlde: LongWord;      // ListView���

  Cur_Item_Count: Integer=0;     // ��ǰ�б���item����
  Cur_Item_Index: Integer=-1;    // ��ǰ��ѡ��item���

  Icon_Handle   : array of IconHandle ; //ͼ��������

procedure  RefurbishFrom;  //--ˢ�´����ض�����--
procedure  DrawIconToForm; //--��ͼ�굽�����Ϸ�--

implementation

uses
  Windows;

const
 //�ļ�ͼ�����λ��
  FileIconLeft = 190;
  FileIconTop  =  6;
 //����ͼ�����λ��
  WinIconLeft = 320;
  WinIconTop  =  6;
 //ˢ�´���ֲ���Χ
  RedrawRect: TRect = (Left: 150; Top: 0; Right: 400; Bottom: 45);

  {--ˢ�´����ض�����--}
procedure RefurbishFrom;
begin
  InvalidateRect(WindowHanlde, @RedrawRect, TRUE);
end;

  {--����ͼ�굽����--}
procedure  DrawIconToForm;
begin
 //------δѡ��item----
  if (Cur_Item_Index < 0) then Exit;
 //------����ͼ��------
  Drawicon(Window_hdc, FileIconLeft, FileIconTop, Icon_Handle[Cur_Item_Index].FileIcon);
  Drawicon(Window_hdc, WinIconLeft, WinIconTop, Icon_Handle[Cur_Item_Index].WindowIcon);
end;

end.
