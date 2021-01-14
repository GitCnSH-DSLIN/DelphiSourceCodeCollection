unit ObjectBase;

interface
uses
  Windows,Classes,Grobal2;
Const
  MAXSAY = 5;
type
  TActionInfo = packed record
    start   :Word;//0x14              // ���� ������
    frame   :Word;//0x16              // ������ ����
    skip    :Word;//0x18
    ftime   :Word;//0x1A              // ������ ����
    usetick :Word;//0x1C              // ���ƽ, �̵� ���ۿ��� ����
  end;
  pTActionInfo = ^TActionInfo;
  THumanAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActRun:        TActionInfo;   //8
    ActRushLeft:   TActionInfo;
    ActRushRight:  TActionInfo;
    ActWarMode:    TActionInfo;   //1
    ActHit:        TActionInfo;   //6
    ActHeavyHit:   TActionInfo;   //6
    ActBigHit:     TActionInfo;   //6
    ActFireHitReady: TActionInfo; //6
    ActSpell:      TActionInfo;   //6
    ActSitdown:    TActionInfo;   //1
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
  end;
  pTHumanAction = ^THumanAction;
  TMonsterAction = packed record
    ActStand:      TActionInfo;   //1
    ActWalk:       TActionInfo;   //8
    ActAttack:     TActionInfo;   //6 0x14 - 0x1C
    ActCritical:   TActionInfo;   //6 0x20 -
    ActStruck:     TActionInfo;   //3
    ActDie:        TActionInfo;   //4
    ActDeath:      TActionInfo;
  end;
  pTMonsterAction = ^TMonsterAction;
  TActor = class
    m_nRecogId       :Integer;
    m_nCurrX         :Integer;
    m_nCurrY         :Integer;
    m_btDir                   :Byte;       //��ǰվ������ 0x0C
    m_btSex                   :Byte;       //�Ա� 0x0D
    m_btRace                  :Byte;       //0x0E
    m_btHair                  :Byte;       //ͷ������ 0x0F
    m_btDress                 :Byte;       //�·����� 0x10
    m_btWeapon                :Byte;       //��������
    m_btHorse                 :Byte;       //������
    m_btEffect                :Byte;       //��ʹ����
    m_btJob                   :Byte;       //ְҵ 0:��ʿ  1:��ʦ  2:��ʿ
    m_wAppearance             :Word;       //0x14
    m_btDeathState            :Byte;
    m_nFeature                :Integer;    //0x18
    m_nFeatureEx              :Integer;
    m_nState                  :Integer;
    m_boDeath                 :Boolean;    //0x20
    m_boSkeleton              :Boolean;    //0x21
    m_boDelActor              :Boolean;    //0x22
    m_boDelActionAfterFinished :Boolean;   //0x23
    m_sDescUserName           :String;     //�������ƣ���׺
    m_sUserName               :String;     //0x28
    m_nNameColor              :Integer;    //0x2C
    m_Abil                    :TAbility;   //0x30
    m_nGold                   :Integer;    //�������0x58
    m_nGameGold               :Integer;    //��Ϸ������
    m_nGamePoint              :Integer;    //��Ϸ������
    m_nHitSpeed               :ShortInt;   //�����ٶ� 0: �⺻, (-)���� (+)����
    m_boVisible               :Boolean;    //0x5D
    m_boHoldPlace             :Boolean;    //0x5E

    m_SayingArr               :array[0..MAXSAY-1] of String;
    m_SayWidthsArr            :array[0..MAXSAY-1] of Integer;
    m_dwSayTime               :LongWord;
    m_nSayX                   :Integer;
    m_nSayY                   :Integer;
    m_nSayLineCount           :Integer;

    m_nRx            :Integer;
    m_nRy            :Integer;
    m_nCurrentEvent  :Integer;
    m_nChrLight      :Integer;
    m_boDigFragment  :BOOL;
    m_nCurrentAction          :Integer;
    m_boGrouped               :Boolean;

    m_dwDeleteTime            :LongWord;

    m_dwWaitMagicRequest      :LongWord;
    m_nWaitForRecogId         :Integer;
    m_nWaitForFeature         :Integer;
    m_nWaitForStatus          :Integer;
    
    m_Action         :pTMonsterAction;
  protected
    m_nStartFrame             :Integer;
    m_nEndFrame               :Integer;
    m_nCurrentFrame           :Integer;
     m_nOldx                   :Integer;
     m_nOldy                   :Integer;
     m_nOldDir                 :Integer; //0x214 0x218 0x21C
     m_nActBeforeX             :Integer;
     m_nActBeforeY             :Integer;  //0x220 0x224
     m_nWpord                  :Integer;     
  public
    m_MsgList: TList;
    constructor Create; dynamic;
    destructor Destroy; override;
    procedure  SendMsg (wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
    procedure  UpdateMsg(wIdent:Word; nX,nY, ndir,nFeature,nState:Integer;sStr:String;nSound:Integer);
    procedure  Say(sMsg:String);
    procedure  FeatureChanged();
    function ActionFinished():BOOL;
    procedure  CleanCharMapSetting(nX,nY:Integer);
    procedure  CleanUserMsgs;
  end;
  THumActor = class (TActor)

  end;
  TNpcActor = class (TActor)

  end;
implementation

{ TActor }

function TActor.ActionFinished():BOOL;
begin
  Result:=True;
end;

procedure TActor.CleanCharMapSetting(nX, nY: Integer);
begin
  m_nCurrX := nX;
  m_nCurrY := nY;
  m_nRx := nX;
  m_nRy := nY;
  m_nOldx := nX;
  m_nOldy := nY;
  m_nCurrentAction := 0;
  m_nCurrentFrame := -1;
  CleanUserMsgs;
end;

procedure TActor.CleanUserMsgs;
var
  I:Integer;
  Msg:pTChrMsg;
begin
    I:= 0;
    while TRUE do begin
      if I >= m_MsgList.Count then break;
      Msg:=m_MsgList.Items[I];
      if (Msg.Ident >= 3000) and //Ŭ���̾�Ʈ���� ���� �޼�����
         (Msg.Ident <= 3099) then begin
        Dispose(Msg);
        m_MsgList.Delete (I);
        Continue;
      end;
      Inc(I);
    end;
end;

constructor TActor.Create;
begin
  m_MsgList:=TList.Create;
end;

destructor TActor.Destroy;
begin
  m_MsgList.Free;
  inherited;
end;

procedure TActor.FeatureChanged;
begin

end;

procedure TActor.Say(sMsg: String);
begin

end;

procedure TActor.SendMsg(wIdent: Word; nX, nY, ndir, nFeature,
  nState: Integer; sStr: String; nSound: Integer);
begin

end;

procedure TActor.UpdateMsg(wIdent: Word; nX, nY, ndir, nFeature,
  nState: Integer; sStr: String; nSound: Integer);
begin

end;

end.
