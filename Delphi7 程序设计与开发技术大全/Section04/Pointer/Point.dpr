program Point;         //ָ��ʾ������

{$Apptype console}
type
  PInt=^Integer;					//����ָ������
var
  I,K:Integer;
  PI:Pint;						  	//����ָ��
  P:Pointer;					  	//������ָ��
begin
  I:=3;
  K:=5;
  PI:=@K;                 //����ָ��ָ����������
  writeln('K=',PI^);
  P:=@I;
  K:=Integer(P^);         //������ָ��ָ����������
  writeln('K=',K);
  PI:=P;                  //ָ��֮�丳ֵ
  writeln('PI^:',PI^);
  readln;
end.
