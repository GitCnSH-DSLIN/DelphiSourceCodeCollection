unit BCore;

interface
  Uses SysUtils,BLibrary,Aes,StringsUnit,DecryptCore,IniFiles,Dialogs;
  Function Decrypt(FileName,PW,DiskPW,Path:String):Boolean;
  Function Encrypt(FileName,PW,DiskPW,SaveFile:String):Boolean;
implementation

Function Encrypt;   {����:����}
var
  Temp:string;
  F:Tinifile;
begin
  Temp:=NewTemp;
{*�������}
  if RunCore2('E',FileName,Temp+ExtractFileName(FileName),PW) then
  Begin
  {���DiskPW��Ϊ��}
  if (DiskPW<>'')and(GetIdeSerialNumber<>'') then
  RunCore('E',Temp+ExtractFileName(FileName),DiskPW);

  F:=Tinifile.Create(Temp+INIFileName);
  F.WriteInteger('Pack','Versoin',PackVersoin);
  If (DiskPW<>'') then begin
  F.WriteBool('Pack','DiskEncrypt',true);
  F.WriteString('PassWord','PW',EncryptString(DiskPW,EncryptString(PW,PassWordC,KB256),KB256));
  end else begin
  F.WriteBool('Pack','DiskEncrypt',False);
  F.WriteString('PassWord','PW',EncryptString(PW,PassWordC,KB256));
  end end else begin Result:=false; exit; end;

    // Messagebox(0,pchar('Ӳ��ָ������ʧ�ܣ�δ֪�Ĵ���!'),pchar('����!'),MB_OK+MB_DEFBUTTON1+MB_APPLMODAL+MB_ICONError);
    {***end}
   {�޷�ȡ��Ӳ��ID}
  // begin Messagebox(0,pchar('�޷�ȡ��Ӳ��ָ��!'),pchar('����!'),MB_OK+MB_DEFBUTTON1+MB_APPLMODAL+MB_ICONError);
 //  Result:=False; Exit;
 //  end;
   {*end}
   {���}
   ZipFile(Temp,SaveFile+'.BSE',True,True,GKey);
   Result:=True;
end;
Function Decrypt;
Var
  Temp:String;
  F:TiniFile;
begin
  {��������������ӿ�,��ҪΪ���ݾɵ�������}
  Temp:=NewTemp;
  UnZipFile(Temp,FileName,GKey);
  {����Ҳ��������ļ�}
  {�������ļ�}
  F:=Tinifile.Create(Temp+INIFileName);
  If FileExists(Temp+INIFileName)=False
  then ShowBox('�������𻵻򵵰�����̫��~','����');
  Case F.ReadInteger('Pack','Versoin',0) of
  5:begin
//  ShowMessage('ִ�м��һ');
  Result:=Decrypt5(Temp,PW,DiskPW,Path);
  end;
  else ShowBox('�������𻵻򵵰�����̫��~','����');
  end;
end;
end.
