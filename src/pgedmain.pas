unit pgedmain;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ExtCtrls,
  About,DskUtil,PGUnit, Buttons, StdCtrls;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    MainMenu: TMainMenu;
    mFile: TMenuItem;
    mOpen: TMenuItem;
    mSave: TMenuItem;
    N1: TMenuItem;
    mExit: TMenuItem;
    mHelp: TMenuItem;
    mAbout: TMenuItem;
    Timer: TTimer;
    OpenDlg: TOpenDialog;
    Toolbar: TPanel;
    SpeedButton1: TSpeedButton;
    AppSpace: TPanel;
    Panel1: TPanel;
    UnitPages: TPageControl;
    AxisPage: TTabSheet;
    AlliesPage: TTabSheet;
    GameName: TPanel;
    ScenarioName: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    AxisList: TListBox;
    AlliesList: TListBox;
    Panel2: TPanel;
    EdStr: TEdit;
    UDStr: TUpDown;
    EdAmmo: TEdit;
    UDAmmo: TUpDown;
    EdEntr: TEdit;
    UDEntr: TUpDown;
    EdExp: TEdit;
    UDExp: TUpDown;
    EdMove: TEdit;
    UDMove: TUpDown;
    EdKills: TEdit;
    UDKill: TUpDown;
    EdSupr: TEdit;
    UDSupr: TUpDown;
    Label7: TLabel;
    CBType: TComboBox;
    EdXPos: TEdit;
    UDXPos: TUpDown;
    EdYPos: TEdit;
    UDYPos: TUpDown;
    CKVisible: TCheckBox;
    CKMove: TCheckBox;
    CBTrans: TComboBox;
    Label8: TLabel;
    EdName: TEdit;
    CBFlag: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Supression: TLabel;
    SaveBtn: TSpeedButton;
    ScenarioList: TListBox;
    EdAxPrest: TEdit;
    EdAlPrest: TEdit;
    UDPreAx: TUpDown;
    Label14: TLabel;
    UDPreAl: TUpDown;
    Label15: TLabel;
    CBCarrier: TComboBox;
    Carrier: TLabel;
    RGMount: TRadioGroup;
    RBMtNone: TRadioButton;
    RBMtTrans: TRadioButton;
    RBMtCarrier: TRadioButton;
    GameDate: TPanel;
    TurnsNum: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    HumanNum: TPanel;
    Label19: TLabel;
    GameType: TPanel;
    Label20: TLabel;
    ActivePlayer: TPanel;
    procedure TimerTimer(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure mOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListClick(Sender: TObject);
    procedure mAboutClick(Sender: TObject);
    procedure UnitPagesChanging(Sender: TObject; var AllowChange: Boolean);
    procedure SaveBtnClick(Sender: TObject);
  private
    { Private declarations }
    OldIndex: Integer;
    procedure GetScenarioName;
    procedure GetUnits;
    procedure ClearLists;
    procedure ReadRecord;
    procedure SaveRecord(pRec: PUnitRec);
    procedure SaveData;
  public
    { Public declarations }
  end;

const
  cTh: PChar = 'th ';
  PrestigeOffset = 20254;
  NUMTURNS = -4134;
  NUMPLAYERS = -4121;
  ATVPLAYER = -4120;
  CAMPAIGNFLAG = -3724;

var
  MainForm: TMainForm;
  Units: TList;
  MapNumber: Word;
  UnitOffs: LongInt;
  URec: PUnitRec;
  UCopyRec: PUnitRec;
  FHandle: Integer;
  cBuf: PChar;
  AxisUnits, AlliedUnits : TList;
  iAxisCount, iAlliedCount : Integer;
  pTurns: ^Byte;
  pHumans: ^Byte;
  pActive: ^Byte;
  pScenario: ^Byte;

implementation

{$R *.lfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
 FHandle := HFILE_ERROR;
 cBuf := NIL;
 OldIndex := -1;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
 if cBuf <> NIL then
  begin
   StrDispose(cBuf);
   cBuf := NIL;
  end;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
 StatusBar.Panels[0].Text := TimeToStr(Now);
end;

procedure TMainForm.mExitClick(Sender: TObject);
begin
 SaveData;
 Close;
end;

procedure TMainForm.mOpenClick(Sender: TObject);
var
  sb: TStringBuffer;
  pos: Longint;
  pPre: PPrestigeRec;
  tst: Char;
  i: Integer;
  lSize,lRead: LongInt;
begin
if OpenDlg.Execute then
 begin
  sb.str := OpenDlg.FileName + #0;
  FHandle := ReadAllFile(sb.cArray, fmOpenReadWrite or fmShareExclusive, FHandle, cBuf);
  if cBuf = nil then
   begin
    MessageDlg('Cannot open ' + ExtractFileName(OpenDlg.FileName), mtError, [mbOK], 0);
   end
  else
   begin
    GameName.Caption := StrPas(cBuf + 1);
    GameDate.Caption := StrPas(cBuf + 15);
    GetScenarioName;
    New(pTurns);
    StrMove(PChar(pTurns),cBuf + (lSize + NUMTURNS),SizeOf(Byte));
    TurnsNum.Caption := IntToStr(pTurns^);
    New(pHumans);
    StrMove(PChar(pHumans),cBuf + (lSize + NUMPLAYERS),SizeOf(Byte));
    If (pHumans^ = 1) then HumanNum.Caption := 'One Human Player';
    If (pHumans^ = 0) then HumanNum.Caption := 'Two Human Players';
    New(pActive);
    StrMove(PChar(pActive),cBuf + (lSize + ATVPLAYER),SizeOf(Byte));
    If (pActive^ = 1) then ActivePlayer.Caption := 'Allied'
    else ActivePlayer.Caption := 'Axis';
    New(pScenario);
    StrMove(PChar(pScenario),cBuf + (lSize + CAMPAIGNFLAG),SizeOf(Byte));
    If (pScenario^ = 1) then GameType.Caption := 'Campaign'
    else GameType.Caption := 'Scenario';
    New(pPre);
    StrMove(PChar(pPre),cBuf + UnitOffs+PrestigeOffset,SizeOf(TPrestigeRec));
    EdAxPrest.Text := IntToStr(pPre^.Axis);
    EdAlPrest.Text := IntToStr(pPre^.Allies);
    Dispose(pPre);
    Dispose(pTurns);
    Dispose(pHumans);
    Dispose(pActive);
    Dispose(pScenario);
    GetUnits;
   end;
 end;
end;

procedure TMainForm.GetScenarioName;
var
 sName : string;
 iSep :  Integer;
 iCode : Integer;
begin
 MapNumber := Byte((cBuf + 196)^);
 sName := ScenarioList.Items[MapNumber - 1];
 iSep := Pos(#9, sName);
 Val(Copy(sName, iSep + 1, 99), UnitOffs, iCode);
 Delete(sName, iSep, 99);
 ScenarioName.Caption := sName;
end;

procedure TMainForm.GetUnits;
var
 pCurrUnit : PChar;
 iCount:    Integer;
begin
 ClearLists;
 AlliedUnits := TList.Create;
 AxisUnits := TList.Create;
 AlliesList.Items.Clear;
 AxisList.Items.Clear;
 iCount := 0;
 pCurrUnit := cBuf + UnitOffs;
 repeat
    New(URec);
    StrMove(PChar(URec), pCurrUnit, SizeOf(TUnitRec) - SizeOf(LongInt));
    URec^.iOffset := LongInt(pCurrUnit - cBuf);
    if iCount mod 2 <> 0 then
     begin
      if(URec^.cName[0] <> #0) then
       begin
        AlliedUnits.Add(URec);
        AlliesList.Items.Add(URec^.cName);
       end
     end
    else
     begin
      if(URec^.cName[0] <> #0) then
       begin
        AxisUnits.Add(URec);
        AxisList.Items.Add(URec^.cName);
       end;
     end;
    iCount := iCount + 1;
    pCurrUnit := pCurrUnit + SizeOf(TUnitRec) - SizeOf(LongInt);
 until iCount > 398;
end;

procedure TMainForm.ClearLists;
begin
 AlliedUnits.Free;
 AxisUnits.Free;
end;

procedure TMainForm.ListClick(Sender: TObject);
begin
 if FHandle <> HFILE_ERROR then
 begin
  if(TListBox(Sender).ItemIndex <> OldIndex) and (OldIndex > -1) then
   begin
    SaveRecord(URec);
    WriteRecord(FHandle, URec^.iOffset, PChar(URec), SizeOf(TUnitRec) - SizeOf(LongInt));
   end;
  ReadRecord;
 end;
end;

procedure TMainForm.mAboutClick(Sender: TObject);
begin
 AboutBox.ShowModal;
end;

procedure TMainForm.ReadRecord;
begin
 if UnitPages.ActivePage = AxisPage then
  begin
   URec := AxisUnits.Items[AxisList.ItemIndex];
   OldIndex := AxisList.ItemIndex;
  end
 else
  begin
   URec := AlliedUnits.Items[AlliesList.ItemIndex];
   OldIndex := AlliesList.ItemIndex;
  end;
 EdName.Text := StrPas(URec^.cName);
 CBType.ItemIndex := URec^.wUnitType-1;
 CBTrans.ItemIndex := URec^.wTransportType;
 CBFlag.ItemIndex := uRec^.bCountry-1;
 EdXPos.Text := IntToStr(URec^.wXPos);
 EdYPos.Text := IntToStr(URec^.wYPos);
 EdStr.Text := IntToStr(URec^.bStrength);
 EdAmmo.Text := IntToStr(URec^.bAmmo);
 EdEntr.Text := IntToStr(URec^.bEntrenchment);
 EdExp.Text := IntToStr(Word2Exp(URec^.wExperience));
 EdMove.Text := IntToStr(URec^.bMove);
 EdKills.Text := IntToStr(URec^.wKills);
 EdSupr.Text := IntToStr(URec^.bSupressed);
 if (uRec^.lVisible) then CKVisible.State := cbChecked
 else CKVisible.State := cbUnChecked;
 case uRec^.bMounted of
  0: RBMtNone.Checked := True;
  1: RBMtTrans.Checked := True;
  2: RBMtCarrier.Checked := True;
 end;
 //if (uRec^.bMounted) then CKMount.State := cbChecked
 //else CKMount.State := cbUnChecked;
 if (uRec^.lMoved) then CKMove.State := cbChecked
 else CKMove.State := cbUnChecked;
end;

procedure TMainForm.SaveRecord(pRec: PUnitRec);
begin
 StrPCopy(pRec^.cName,EdName.Text);
 pRec^.wUnitType := CBType.ItemIndex + 1;
 pRec^.wTransportType := CBTrans.ItemIndex ;
 pRec^.bCountry := CBFlag.ItemIndex + 1;
 pRec^.wXPos := StrToInt(EdXPos.Text);
 pRec^.wYPos := StrToInt(EdYPos.Text);
 pRec^.bStrength := StrToInt(EdStr.Text);
 pRec^.bAmmo := StrToInt(EdAmmo.Text);
 pRec^.bEntrenchment := StrToInt(EdEntr.Text);
 pRec^.wExperience := Exp2Word(StrToInt(EdExp.Text));
 pRec^.bMove := StrToInt(EdMove.Text);
 pRec^.wKills := StrToInt(EdKills.Text);
 pRec^.bSupressed := StrToInt(EdSupr.Text);
 pRec^.lVisible := CKVisible.Checked;
 //pRec^.lMounted := CKMount.Checked;
 if RBMtNone.Checked then pRec^.bMounted := 0
 else if RBMtTrans.Checked then pRec^.bMounted := 1
 else if RBMtCarrier.Checked then pRec^.bMounted := 2;
 pRec^.lMoved   := CKMove.Checked;
end;

procedure TMainForm.SaveData;
var
 pPre: PPrestigeRec;
begin
 if FHandle <> HFILE_ERROR then
  begin
   SaveRecord(URec);
   WriteRecord(FHandle, URec^.iOffset, PChar(URec), SizeOf(TUnitRec) - SizeOf(LongInt));
   New(pPre);
   pPre^.Axis := StrToInt(EdAxPrest.Text);
   pPre^.Allies := StrToInt(EdAlPrest.Text);
   WriteRecord(FHandle, UnitOffs+PrestigeOffset, PChar(pPre), SizeOf(TPrestigeRec));
   Dispose(pPre);
  end;
end;

procedure TMainForm.UnitPagesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
 SaveData;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
 SaveData;
end;

end.
