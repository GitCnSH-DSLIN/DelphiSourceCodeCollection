program  EMF7;

uses
  Windows, Messages;

   // ö�ٻص�����
function EnhMetaFileProc(hdc: HDC; pHandleTable: PHandleTable;
  pEmfRecord: PEnhMetaRecord; iHandles: Integer; pData: LPARAM): Integer; stdcall;
var
  hBrush: LongWord; // HBRUSH
  hPen: LongWord; // HPEN
  lb: TLogBrush;
begin
  if (pEmfRecord.iType <> EMR_HEADER) and (pEmfRecord.iType <> EMR_EOF) then
    PlayEnhMetaFileRecord(hdc, pHandleTable^, pEmfRecord^, iHandles);

  if (pEmfRecord.iType = EMR_RECTANGLE) then // ����
  begin
    hBrush := SelectObject(hdc, GetStockObject(NULL_BRUSH)); // �ջ�ˢ(�����)
    lb.lbStyle := BS_SOLID;
    lb.lbColor := RGB(0, 255, 0);
    lb.lbHatch := 0;                                               // ������ѡ���»���
    hPen := SelectObject(hdc, ExtCreatePen(PS_SOLID or PS_GEOMETRIC, 5, lb, 0, nil));
    Ellipse(hdc, 100, 100, 200, 200); // �����Բ
    DeleteObject(SelectObject(hdc, hPen)); // ѡ���ϻ���ɾ���»���
    SelectObject(hdc, hBrush);
  end;

  Result := 1; // TRUE
end;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hdcWnd, hdcEMF: HDC;
  hemfOld, hemf: HENHMetaFile;
  ps: TPaintStruct;
  Rect: TRect;
  emh: TEnhMetaHeader;
begin
  Result := 0;
  case Msg of
    WM_CREATE:
      begin
       // Retrieve existing MetaFile and header
        hemfOld := GetEnhMetaFile('..\����18-4\emf3.emf');
        GetEnhMetaFileHeader(hemfOld, SizeOf(TEnhMetaHeader), @emh);

       // Create a new MetaFile DC
        hdcEMF := CreateEnhMetaFile(0, 'emf7.emf', nil, 'EMF7'#0'EMF Demo #7'#0#0);

       // Enumerate the existing MetaFile
        EnumEnhMetaFile(hdcEMF, hemfOld, @EnhMetaFileProc, nil, emh.rclBounds);
        
       // Clean up
        hemf := CloseEnhMetaFile(hdcEMF);
        DeleteEnhMetaFile(hemfOld);
        DeleteEnhMetaFile(hemf);
      end;

    WM_PAINT:
      begin
        hdcWnd := BeginPaint(hWnd, ps);

        GetClientRect(hWnd, Rect);
        Rect.Left := Rect.Right div 4;
        Rect.Right := 3 * Rect.Right div 4;
        Rect.Top := Rect.Bottom div 4;
        Rect.Bottom := 3 * Rect.Bottom div 4;

        hemf := GetEnhMetaFile('emf7.emf'); // ���´�
        PlayEnhMetaFile(hdcWnd, hemf, Rect);
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
  szAppName = 'EMF7';

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
  hWnd := CreateWindow(szAppName, 'Enhanced MetaFile Demo #7',
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
