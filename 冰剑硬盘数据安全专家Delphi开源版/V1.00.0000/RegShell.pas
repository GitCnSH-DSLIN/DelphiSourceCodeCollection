unit RegShell;

interface
procedure Rshell(Ext,path:string);
implementation
uses
  Windows,SysUtils,registry,shlobj;
procedure Rshell;
const
  Name = 'BinjianSE';
var
  reg: TRegistry;
begin
 reg := TRegistry.Create;
 reg.RootKey:=HKEY_CLASSES_ROOT;
 reg.OpenKey(Ext,true);
 reg.WriteString('',Name);
 reg.CloseKey;
 reg.OpenKey(Name+'\shell\open\command', true);
 //���ڴ�.zzz�ļ��Ŀ�ִ�г���
 reg.WriteString('', '"' + path + '" "%1"');
 reg.CloseKey;
 reg.OpenKey(Name+'\DefaultIcon',true);
 //ȡ��ǰ��ִ�г����ͼ��Ϊ.zzz�ļ���ͼ��
 reg.WriteString('',''+ path +',0');
 reg.Free;
 //����ˢ��
 SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

end.
 