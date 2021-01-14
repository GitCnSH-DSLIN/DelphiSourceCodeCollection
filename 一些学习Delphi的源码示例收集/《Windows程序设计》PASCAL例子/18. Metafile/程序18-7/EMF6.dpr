program  EMF6;

uses
  Windows, Messages;

   // ö�ٻص�����
function EnhMetaFileProc(hdc: HDC; pHandleTable: PHandleTable;
  pEmfRecord: PEnhMetaRecord; iHandles: Integer; pData: LPARAM): Integer; stdcall;
var
  pEmfr: PEnhMetaRecord;
begin
  GetMem(pEmfr, pEmfRecord.nSize);
  CopyMemory(pEmfr, pEmfRecord, pEmfRecord.nSize);

  if (pEmfr.iType = EMR_RECTANGLE) then pEmfr.iType := EMR_ELLIPSE; // ���θ�Ϊ��Բ
  PlayEnhMetaFileRecord(hdc, pHandleTable^, pEmfr^, iHandles); // ����

  FreeMem(pEmfr);
  Result := 1; // TRUE
end;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hdcWnd: HDC;
  hemf: HENHMetaFile;
  ps: TPaintStruct;
  Rect: TRect;
begin
  Result := 0;
  case Msg of
    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

        GetClientRect(hWnd, Rect);
        Rect.Left := Rect.Right div 4;
        Rect.Right := 3 * Rect.Right div 4;
        Rect.Top := Rect.Bottom div 4;
        Rect.Bottom := 3 * Rect.Bottom div 4;

        hemf := GetEnhMetaFile('..\����18-4\emf3.emf');
        EnumEnhMetaFile(hdcWnd, hemf, @EnhMetaFileProc, nil, Rect); // ö��
        DeleteEnhMetaFile(hemf);

        EndPaint(hWnd, ps);
      end;


    WM_DESTROY:
      begin
        PostQuitMessage(0); // �˳�
      end;

    else
      Result := DefWindowProc(hWnd, Msg, wParam, lParam); // ��׼����
  end;
end; 

  
const
  szAppName = 'EMF6';

var
  hWnd: LongWord;
  Msg: TMsg;
  WndClass: TWndClass;
  
begin
 // ���ṹ��
  WndClass.style := CS_HREDRAW or CS_VREDRAW;
  WndClass.lpfnWndProc := @WndProc;
  WndClass.cbClsExtra := 0;
  WndClass.cbWndExtra := 0;
  WndClass.hInstance := hInstance;
  WndClass.hIcon := LoadIcon(0, IDI_APPLICATION);
  WndClass.hCursor := LoadCursor(0, IDC_ARROW);
  WndClass.hbrBackground := GetStockObject(WHITE_BRUSH);
  WndClass.lpszMenuName := nil;
  WndClass.lpszClassName := szAppName;

 // ע�ᴰ����
  if (RegisterClass(WndClass) = 0) then
  begin
    MessageBox(0, 'This program requires Windows NT!', szAppName, MB_ICONERROR);
    Exit;
  end;

 // ��������                      
  hWnd := CreateWindow(szAppName, 'Enhanced MetaFile Demo #6',
                       WS_OVERLAPPEDWINDOW,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       CW_USEDEFAULT, CW_USEDEFAULT,
                       0, 0, hInstance, nil);

 // ��ʾ����
  ShowWindow(hWnd, CmdShow);
  UpdateWindow(hWnd);
    
 // ��Ϣѭ��
  while GetMessage(Msg, 0, 0, 0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
  end;

end.
