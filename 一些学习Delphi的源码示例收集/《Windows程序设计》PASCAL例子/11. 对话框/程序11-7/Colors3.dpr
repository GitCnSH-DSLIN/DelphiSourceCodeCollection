program  Colors3;

uses
  Windows, CommDlg;

var
  cc: TChooseColor;
  crCustColors: array[0..16] of COLORREF;

begin
  cc.lStructSize := SizeOf(TChooseColor);
  cc.hwndOwner := 0;
  cc.hInstance := 0;
  cc.rgbResult := RGB($80, $80, $80);
  cc.lpCustColors := @crCustColors;
  cc.Flags := CC_RGBINIT or CC_FULLOPEN;
  cc.lCustData := 0;
  cc.lpfnHook := nil;
  cc.lpTemplateName := nil;
  ChooseColor(cc);
(* ע��ChooseColor������,��һ����������Ϣѭ�� *)
end.
