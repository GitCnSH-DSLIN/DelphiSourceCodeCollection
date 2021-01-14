program  EMF3;

uses
  Windows, Messages;

   // ������Ϣ�������
function WndProc(hWnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  hdcWnd, hdcEMF: HDC;
  hemf: HENHMetaFile;
  ps: TPaintStruct;
  Rect: TRect;
  lb: TLogBrush;
begin
  Result := 0;
 // ���ֲ�ͬ����Ϣ
  case Msg of
    WM_CREATE:
      begin
        hdcEMF := CreateEnhMetaFile(0, 'emf3.emf', nil, 'EMF3'#0'EMF Demo #3'#0#0);
        SelectObject(hdcEMF, CreateSolidBrush(RGB(0, 0, 255)));

        lb.lbStyle := BS_SOLID;
        lb.lbColor := RGB(255, 0, 0);
        lb.lbHatch := 0;
        SelectObject(hdcEMF, ExtCreatePen(PS_SOLID or PS_GEOMETRIC, 5, lb, 0, nil));

        if ((GetVersion() and $80000000) <> 0) then
          Rectangle(hdcEMF, 100, 100, 201, 201)  // Windows 98
        else
          Rectangle(hdcEMF, 101, 101, 202, 202); // Windows NT

        MoveToEx(hdcEMF, 100, 100, nil);
        LineTo(hdcEMF, 200, 200);
        MoveToEx(hdcEMF, 200, 100, nil);
        LineTo(hdcEMF, 100, 200);
        DeleteObject(SelectObject(hdcEMF, GetStockObject(BLACK_PEN)));
        DeleteObject(SelectObject(hdcEMF, GetStockObject(WHITE_BRUSH)));
        hemf := CloseEnhMetaFile(hdcEMF);
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
        hemf := GetEnhMetaFile('emf3.emf');
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
  szAppName = 'EMF3';

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
  hWnd := CreateWindow(szAppName, 'Enhanced MetaFile Demo #3',
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
