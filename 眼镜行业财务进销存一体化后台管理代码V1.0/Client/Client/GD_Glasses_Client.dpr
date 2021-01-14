program GD_Glasses_Client;

uses
  Forms,
  Windows,
  inifiles,
  SysUtils,
  Data in 'Data.pas' {frm_Data: TDataModule},
  Login in 'Login.pas' {frm_Login},
  Main in 'Main.pas' {frm_Main},
  func in 'func.pas',
  IMCode in 'IMCode.pas',
  Stock_Report in 'Stock_Report.pas' {frm_Stock_Report},
  Stock_Contract in 'Stock_Contract.pas' {frm_Stock_Contract},
  Storage_Select in 'Storage_Select.pas' {frm_Storage_Select},
  Umanage_Fad in 'Umanage_Fad.pas' {frm_Umanage_Fad},
  limit in 'limit.pas' {frm_limit},
  Sale_Contract in 'Sale_Contract.pas' {frm_Sale_Contract},
  Login_Man in 'Login_Man.pas' {frm_Login_Man},
  Goods_Requirement in 'Goods_Requirement.pas' {frm_Goods_Requirement},
  Supply_Monad in 'Supply_Monad.pas' {frm_Supply_Monad},
  Examine_Verify in 'Examine_Verify.pas' {frm_Examine_Verify},
  Man_Check in 'Man_Check.pas' {frm_Man_Check},
  Public_Don in 'Public_Don.pas' {frm_Public_Don},
  Business_Draft in 'Business_Draft.pas' {frm_Business_Draft},
  Goods_Write in 'Goods_Write.pas' {frm_Goods_Write},
  Quality_Check in 'Quality_Check.pas' {frm_Quality_Check},
  Stock_Write_Check in 'Stock_Write_Check.pas' {frm_Stock_Write_Check},
  Quality_Check_Select in 'Quality_Check_Select.pas' {frm_Quality_Check_Select},
  Contract_Check in 'Contract_Check.pas' {frm_Contract_Check},
  ChildShop_Select in 'ChildShop_Select.pas' {frm_ChildShop_Select},
  Stock_Enter_Report in 'Stock_Enter_Report.pas' {frm_Stock_Enter_Report},
  Goods_Requipment_Search in 'Goods_Requipment_Search.pas' {frm_Goods_Requipment_Search},
  Stock_Enter in 'Stock_Enter.pas' {frm_Stock_Enter},
  Stock_Pay in 'Stock_Pay.pas' {frm_Stock_Pay},
  Stock_Fad in 'Stock_Fad.pas' {frm_Stock_Fad},
  Storage_Guide in 'Storage_Guide.pas' {frm_Storage_Guide},
  Company in 'Company.pas' {frm_Company},
  untdatadm in 'untdatadm.pas' {dmmain: TDataModule},
  Unitdwzy in '..\����ģ��\Unitdwzy.pas' {frmzyll},
  Unitygda in '..\����ģ��\Unitygda.pas' {frmygda},
  Unitnewbm in '..\����ģ��\Unitnewbm.pas',
  ubase in 'ubase.pas' {frmbase},
  Umoneystock in 'Umoneystock.pas' {frmmoneystock},
  Uinputselect in 'Uinputselect.pas' {frmselect},
  Ufmgird in 'Ufmgird.pas' {frmgrid},
  fm_icon in 'fm_icon.pas' {Frame1: TFrame},
  Usysteminit in 'Usysteminit.pas' {frmsysteminit},
  Ustockinit in '..\����ģ��\Ustockinit.pas' {frmstockinit},
  fm_Base in '..\����ģ��\��FORM\fm_Base.pas' {fmBase},
  UntStockCheck in '..\����ģ��\������\UntStockCheck.pas',
  fm_Overflow in '..\����ģ��\������\fm_Overflow.pas' {fmOverflow},
  fm_Check in '..\����ģ��\������\fm_Check.pas' {fmCheck},
  fm_Scrap in '..\����ģ��\������\fm_Scrap.pas' {fmScrap},
  fm_SetColumn in '..\����ģ��\��FORM\fm_SetColumn.pas' {fmSetColumn},
  fm_BaseQueryStr in '..\����ģ��\������\fm_BaseQueryStr.pas' {fmBaseQueryStr},
  UntgoodCodeSelStr in '..\����ģ��\������\UntgoodCodeSelStr.pas' {fmgoodCodeSelStr},
  dlg_bsselect in '..\����ģ��\������\dlg_bsselect.pas' {fmbsselect},
  Uinstock in '..\����ģ��\������\Uinstock.pas' {frmin_stock},
  Ustockstates in '..\����ģ��\������\Ustockstates.pas' {frmstockstates},
  Udlgstock in 'Udlgstock.pas' {dlgstock},
  fm_Splash in '..\����ģ��\��FORM\fm_Splash.pas' {FmSplash},
  usystem in 'usystem.pas' {fm_system},
  Uflat in '..\����ģ��\������\Uflat.pas' {fmflat},
  fm_BatchGuest in '..\����ģ��\������\fm_BatchGuest.pas' {fmBatchGuest},
  Unitzcser in '..\����ģ��\��FORM\Unitzcser.pas' {frmzcser},
  Unitthzh in '..\����ģ��\��FORM\Unitthzh.pas',
  UntgoodCodeSelPei in '..\����ģ��\���͹���\UntgoodCodeSelPei.pas' {fmgoodCodeSelPei},
  Unt_PubStrGrid in '..\����ģ��\���͹���\Unt_PubStrGrid.pas',
  UntPosSendBill in '..\����ģ��\���͹���\UntPosSendBill.pas' {FmPosSendBill},
  UntAskGoodsPlan in '..\����ģ��\���͹���\UntAskGoodsPlan.pas' {FmAskGoodsPlan},
  UntPosAskBackBill in '..\����ģ��\���͹���\UntPosAskBackBill.pas' {FmPosAskBackBill},
  UntPosQuestBillStr in '..\����ģ��\���͹���\UntPosQuestBillStr.pas' {FmPosQuestBillStr},
  Untpart in '..\����ģ��\���͹���\Untpart.pas' {fmps_part},
  Untgoodcodedetail in '..\����ģ��\���͹���\Untgoodcodedetail.pas' {fmgoodCodedetail},
  Check_Query in 'Check_Query.pas' {FrmCheck_Query},
  untPubQueryDB in '..\����ģ��\��FORM\untPubQueryDB.pas',
  Untps_query in '..\����ģ��\���͹���\Untps_query.pas' {fmps_query},
  Untdlgselect in '..\����ģ��\���͹���\Untdlgselect.pas' {dlgps_select},
  Untwldw in '..\����ģ��\Untwldw.pas' {fmwldw},
  Untwarn_limit in '..\����ģ��\������\Untwarn_limit.pas' {fmstockwarnlimit},
  Untsalemoney in '..\����ģ��\������\Untsalemoney.pas' {fmsalemoney},
  Untprice in '..\����ģ��\������\Untprice.pas' {fmbaseprice},
  dlg_priceselect in '..\����ģ��\������\dlg_priceselect.pas' {dlgpriceselect},
  dlg_warning_limit in '..\����ģ��\������\dlg_warning_limit.pas' {fm_limit_warning},
  Untcompanyinit in '..\����ģ��\Untcompanyinit.pas' {fm_company},
  Untlimitgoods in '..\����ģ��\������\Untlimitgoods.pas' {fmlimitgoods},
  UntSystemset in '..\����ģ��\UntSystemset.pas' {fmSystemset},
  UntGuestset in '..\����ģ��\UntGuestset.pas' {fmguestset},
  UntgoodscodeRe in '..\����ģ��\������\UntgoodscodeRe.pas' {fmgoodCodeRE},
  UntQuerycontract in '..\����ģ��\������\UntQuerycontract.pas' {fmQuerycontract},
  Unitreportxf in '..\����ģ��\Unitreportxf.pas' {fastrepxf},
  Unitaddreport in '..\����ģ��\Unitaddreport.pas' {Frmaddreport},
  UntEIprices in '..\����ģ��\������\UntEIprices.pas' {fmEIprices},
  Stock_Fad_Query in 'Stock_Fad_Query.pas' {frmStock_Fad_Query},
  untOut_strip in '..\����ģ��\������\untOut_strip.pas' {frm_Out_strip_Query},
  untScrap in 'untScrap.pas' {fm_Scrap_Query},
  untoverflow_query in 'untoverflow_query.pas' {fm_OverFlow_Query},
  untwldwgoodsquery in 'untwldwgoodsquery.pas' {fmwldwgoodsquery},
  Untbatchiput in '..\����ģ��\���͹���\Untbatchiput.pas' {fmBatchinput},
  GD_Chain_Server_TLB in '..\����ģ��\GD_Chain_Server_TLB.pas',
  Untbatchmanager in '..\����ģ��\���͹���\Untbatchmanager.pas' {fmBatchmanager},
  Untselectps in '..\����ģ��\���͹���\Untselectps.pas' {dlgselectps},
  UntSQpspart in '..\����ģ��\���͹���\UntSQpspart.pas' {dlgSQpspart},
  Untbasegrid in '..\����ģ��\Untbasegrid.pas' {fmBasegrid},
  UntWldwStaff in '..\����ģ��\���߷���\UntWldwStaff.pas' {fmWldwStaff},
  UntGoodsStaff in '..\����ģ��\���߷���\UntGoodsStaff.pas' {fmStockAmountStaff},
  dlgGoodsStaff in '..\����ģ��\���߷���\dlgGoodsStaff.pas' {dlgGoodsStaffS},
  UntMsgGoods in '..\����ģ��\���͹���\UntMsgGoods.pas' {dlgmsggoods},
  UntMoneyStaff in '..\����ģ��\���߷���\UntMoneyStaff.pas' {fmMoneyStaff},
  UntGoodsSale in '..\����ģ��\���߷���\UntGoodsSale.pas' {fmGoodsSale},
  UntContactwarn in '..\����ģ��\���߷���\UntContactwarn.pas' {fmContactWarn},
  Unitkqsj in '..\����ģ��\Ա������\Unitkqsj.pas' {frmkqsj},
  Untbcjg in '..\����ģ��\Ա������\Untbcjg.pas' {fmBcJg},
  Unitbcjglr in '..\����ģ��\Ա������\Unitbcjglr.pas' {frmbcjglr},
  Untbcap in '..\����ģ��\Ա������\Untbcap.pas' {fmBcap},
  Untbcaplr in '..\����ģ��\Ա������\Untbcaplr.pas' {fmbcaplr},
  dlgkqdate in '..\����ģ��\Ա������\dlgkqdate.pas' {dlgkqdata},
  Untnewshopgoods in '..\����ģ��\Ա������\Untnewshopgoods.pas' {fmshopgoods},
  Udlgtotalselect in '..\����ģ��\���߷���\Udlgtotalselect.pas' {dlgtotalselect},
  UntTotalStaff in '..\����ģ��\���߷���\UntTotalStaff.pas' {fmTotalStaff},
  Udlgselectdate in '..\����ģ��\������\Udlgselectdate.pas' {dlgselectdate},
  UKqdatamanager in '..\����ģ��\Ա������\UKqdatamanager.pas' {fmKqManager},
  UdlgGoodsSale in '..\����ģ��\���߷���\UdlgGoodsSale.pas' {dlgGoodsSale},
  Ustocking in '..\����ģ��\���߷���\Ustocking.pas' {fmstocking},
  UPosGoods in '..\����ģ��\���͹���\UPosGoods.pas' {fmPosGoods},
  UdlgPosGoods in '..\����ģ��\���͹���\UdlgPosGoods.pas' {dlgPosGoods},
  onlygoods in '..\����ģ��\���߷���\onlygoods.pas' {fmonlygoods},
  UGlassStaff in '..\����ģ��\������\UGlassStaff.pas' {fmGlassStaff},
  UStockType in '..\����ģ��\���߷���\UStockType.pas' {FmStockType},
  UDlgonlygoods in '..\����ģ��\���߷���\UDlgonlygoods.pas' {DlgOnlyGoods},
  UTotalbreed in '..\����ģ��\���߷���\UTotalbreed.pas' {fmTotalBreed},
  UBaseprices in '..\����ģ��\������\UBaseprices.pas' {fmBaseprices},
  UUnPos in '..\����ģ��\���͹���\UUnPos.pas' {fmUnPosSendBill},
  USelgoodCode in '..\����ģ��\���͹���\USelgoodCode.pas' {fmSelgoodCode},
  Unitlmxx in '..\����ģ��\Unitlmxx.pas' {frmlmxx},
  UMsgmanager in '..\����ģ��\UMsgmanager.pas' {fmMsgmanager},
  Unitlmmxlr in '..\����ģ��\Unitlmmxlr.pas' {frmlmmxlr},
  UntZsManager in '..\����ģ��\������\UntZsManager.pas' {fmZSmanager},
  Unitbbs in '..\����ģ��\Unitbbs.pas' {frmbbs},
  Unitbbsmx in '..\����ģ��\Unitbbsmx.pas' {frmbbsmx},
  USetAgion in '..\����ģ��\USetAgion.pas' {fmSetAgion},
  ExitInfo in '..\����ģ��\����ģ��\ExitInfo.pas' {ExitInfoFm},
  ModifyAccount in '..\����ģ��\����ģ��\ModifyAccount.pas' {ModifyAccountFm},
  SysDate in '..\����ģ��\����ģ��\Sysdate.pas' {datewindow},
  Y_DealIn in '..\����ģ��\����ģ��\Y_DealIn.pas' {Y_DealInFm},
  AccountSelect in '..\����ģ��\����ģ��\AccountSelect.pas' {AccountSelectFm},
  w_more in '..\����ģ��\����ģ��\w_more.pas' {w_morefm},
  UYdPosBill in '..\����ģ��\���͹���\UYdPosBill.pas' {FmYdPosBill},
  UDLGYDPOS in '..\����ģ��\���͹���\UDLGYDPOS.pas' {DlgYdPos},
  UOrderGoods in '..\����ģ��\UOrderGoods.pas' {fmOrderQuery},
  UFlatQuery in '..\����ģ��\������\UFlatQuery.pas' {fmFlatQuery},
  Ufinance in '..\����ģ��\����ģ��\Ufinance.pas' {fmMoneyGain},
  UPresent in '..\����ģ��\������\UPresent.pas' {FmPresentQuery},
  UNewShopQuery in '..\����ģ��\������\UNewShopQuery.pas' {fmNewShopQuery},
  UStock_cancel in '..\����ģ��\������\UStock_cancel.pas' {FmCancel},
  UUnfinance in '..\����ģ��\������\UUnfinance.pas' {fmfinanceUnpos},
  UBacthDataQuery in '..\����ģ��\���͹���\UBacthDataQuery.pas' {fmBacthQuery},
  UBacthstaff in '..\����ģ��\���͹���\UBacthstaff.pas' {fmBacthStaff};

{$R *.res}


var
  hMutex:HWND;
  Ret: Integer;
begin
  hMutex:=CreateMutex(nil,False,'WenDingSoftManagerErice');
  Ret:=GetLastError;
  //If Ret<>ERROR_ALREADY_EXISTS Then
  //begin
      Application.Initialize;
      Application.Title := '���������۹���ϵͳ����̨�� Beta 2.8.2';
      FmSplash:=TFmSplash.Create(application);
      FmSplash.Show;
      FmSplash.update ;
      try
       Application.CreateForm(Tfrm_Data, frm_Data);
       Application.CreateForm(Tdmmain, dmmain);
      except
      end;
      FmSplash.close;
      FmSplash.free;
      frm_Login := Tfrm_Login.Create(Application);
      frm_Login.ShowModal;
      frm_login.Close;
      frm_Login.Free;
      ////////////////////////////////  ��ʾԤ������
      if ShowLimit=0 then
      begin
        fm_limit_warning:=tfm_limit_warning.Create(application);
        fm_limit_warning.ShowModal;
        fm_limit_warning.Close;
        fm_limit_warning.Free;
      end;
      ///////////////////////////////////////
      try
        Application.CreateForm(Tfrm_Main, frm_Main);
        Application.Run;
      except
          Application.MessageBox('ϵͳ������ȷ�ϣ�','����',MB_iconwarning);
      end;
  //end
  //else
 // begin
      //Application.MessageBox('�������������У�','��ʾ',MB_iconInformation);
      //ReleaseMutex(hMutex);
  //end;
end.
