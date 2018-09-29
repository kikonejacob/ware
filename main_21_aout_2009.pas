unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,strutils, Menus, ActnList,start,inifiles,
  XPMan,pngimage, mySQLClient,mysql,dateutils;


type
PPlayer=^gPlayer;
gPlayer=record
  points:integer;
  caseBegin:integer;
  caseEnd:integer;
  Id:integer;
  Name:string;
  WinParts:integer;
  automatic:boolean;
  netstatus:integer;
end;
type
PGameInfo=^GameInfo;
GameInfo=record
   Players:   array[0..1] of PPlayer;
   Cases:     array[1..12] of integer;
   CasesFirst:array[1..12] of boolean;
   FirstPlayer:integer;
   PartCount:integer;
   Difficulty:integer;
   CurrCase:integer;
   CurrPlayer:integer;
end;
type
  TCaseplayer = class(TThread)
  private
    { Déclarations privées }
    Num:integer;
    PlayerId:integer;
    CanChangePlayer:boolean;
  protected
    procedure Execute; override;
  published
     constructor Create(inum,iPlayerId:integer;iCanChangePlayer:boolean);
end;

type Pcmd=^dcmd;
dcmd=record
  id:integer;
  senderID:integer;
  Cmd:integer;
  intarg:integer;
  strarg:string;
  comment:string;
  timestamp:int64;
end;




type
  TForm1 = class(TForm)
    Im3: TImage;
    Im4: TImage;
    Im6: TImage;
    Im1: TImage;
    Im_case: TImage;
    Im_plateau: TImage;
    im_sel: TImage;
    Im5: TImage;
    Im2: TImage;
    Im12: TImage;
    Im11: TImage;
    Im10: TImage;
    Im9: TImage;
    Im8: TImage;
    Im7: TImage;
    p1_title: TLabel;
    p1_point: TLabel;
    p0_title: TLabel;
    p0_point: TLabel;
    s_msg: TLabel;
    Button1: TButton;
    s_player: TLabel;
    p0_bar: TImage;
    p1_bar: TImage;
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    l7: TLabel;
    l8: TLabel;
    l9: TLabel;
    l10: TLabel;
    l11: TLabel;
    l12: TLabel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    Charcherunepartie1: TMenuItem;
    Enregistrerlapartie1: TMenuItem;
    N1: TMenuItem;
    Quitter1: TMenuItem;
    N2: TMenuItem;
    theme1: TMenuItem;
    th1: TMenuItem;
    th2: TMenuItem;
    th3: TMenuItem;
    th4: TMenuItem;
    th5: TMenuItem;
    th6: TMenuItem;
    N3: TMenuItem;
    InfoLabel: TLabel;
    Timer1: TTimer;
    Difficult1: TMenuItem;
    df_0: TMenuItem;
    df_1: TMenuItem;
    df_2: TMenuItem;
    N4: TMenuItem;
    OpenD: TOpenDialog;
    CPU_Timer: TTimer;
    begin_bt: TButton;
    SaveD: TSaveDialog;
    Label1: TLabel;
    Button2: TButton;
    P0_busy: TImage;
    P0_Win: TLabel;
    P1_Win: TLabel;
    DoCancel: TMenuItem;
    N5: TMenuItem;
    Option1: TMenuItem;
    XPManifest1: TXPManifest;
    Commentjouer1: TMenuItem;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    P1: TLabel;
    Label3: TLabel;
    Connection1: TMenuItem;
    Live: TTimer;
    mydb: TmySQLClient;

    procedure im_selDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Im1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Im_caseClick(Sender: TObject);
    procedure im_selMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Im_caseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure About1Click(Sender: TObject);
    procedure Quitter1Click(Sender: TObject);
    procedure Enregistrerlapartie1Click(Sender: TObject);
    procedure Charcherunepartie1Click(Sender: TObject);
    procedure theme1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Difficult1Click(Sender: TObject);
    procedure File1Click(Sender: TObject);
    procedure df_0Click(Sender: TObject);
    procedure CPU_TimerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure begin_btClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DoCancelClick(Sender: TObject);
    procedure Im1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Option1Click(Sender: TObject);
    procedure Commentjouer1Click(Sender: TObject);
    procedure im_selMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Connection1Click(Sender: TObject);
    procedure LiveTimer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    
  end;
function RefreshCase(num:integer):integer;
function RefreshPlayerInfo(PlayerId:integer):integer;
function Shortmsg(msg:string;mtype:integer):integer;
function ChangePlayer(Continue:boolean):integer;
function AffSelInfo(num:integer;playerId:integer):integer;

function CheckCPU_WarePoint:integer;
function Check_PartEnd:integer;
function GetAppDir:string;
function RefreshGameInfo:integer;
procedure SaveUndo;
function _cnv(val:integer):integer;
function Msgbox(text:string):integer;
function Check_NoCaseToPlay:boolean;
function GetResPath(ResName:string):string;
procedure Fill_Config;
procedure Fill_ThemeIni;
function GetCasePlayEnd(num:integer):integer;
function GetCaseInfo(Casevalue:integer;tours,rest:Pinteger):integer;
function PlayCaseEx(num:integer;PlayerId:integer;CanChangePlayer:boolean):integer;
function IsPlayerCase(num,PlayerId:integer):boolean;
Procedure WaitPause;
procedure StopGame;
Procedure DoAnimSleep;

function db_connect(silent:boolean=false):integer;
function requete(sql:string):PMYSQL_RES;
function send_cmd(cmd:Pcmd;destID:integer):integer;
procedure startGame(first:boolean);
function initGame():integer;
function envoyer_demande(pseudoID:integer):integer;
function envoyer_jeu(destID,caseID:integer):integer;

var
  Form1: TForm1;
  Gw:PGameInfo;
  my_con:PMYSQL;
  tmpGw:PGameInfo;
  mydb: TmySQLClient;
 (* cases:array[1..12] of integer;
  CasesFirst:array[1..12] of boolean;
  Players:array [0..2] of PPlayer;
  CurrPlayer:integer;{Joueur actuelle}
  CurrCase:integer; {Case actuelle}   *)
  CPU_busy:boolean; {Indique que l'ordi est occupé}
  CaseValue,iNum:integer;{pour PlayCase}
  TimerCmd:integer;{Pour playCase}
  TimerCase:integer;
  ImChoice:boolean;{Pour PlayCase}
  Gamethread:TCaseplayer;
  PartState:integer;
  CPU_Player_Busy:boolean;
  ThemePath:string;
  ThemeIni:TiniFile;
  Config:TiniFile;
  // donnees pour connexion
  sessionID,CpuSessionID:integer;
  last_cmd:integer;


const

  PS_ENDING=4;
  PS_PAUSE=5;
  PS_END=3;
  PS_CPU_BUSY=1;
  PS_PLAYING=0;

const
  LIVE_INVITATION=1;
  LIVE_ABORT=2;
  LIVE_REFUSE=3;
  LIVE_ACCEPT=4;
  LIVE_PLAY_CASE=5;

implementation

{$R *.dfm}
uses PartEnd,CPuGame,options,help, DLG_SESSION;

{function qui permet d'initialiser une case}
function initCase(gw:PGameInfo;num:integer):integer;
begin
  gw.cases[num]:=4;
  gw.casesFirst[num]:=true;
  result:=0;
end;

procedure refreshCases;
var
  i:integer;
begin
  for i:=1 to 12 do
  begin
  RefreshCase(i);
  end;
end;

{fonction qui permet d'initialiser un GameInfo}
function FillGameInfo(gw:PGameInfo;first:boolean):integer;
var
  i:integer;
begin

  for i:=1 to 12 do
  begin
  initcase(gw,i);
  end;
  {Players init}
  If first then
  begin
  New(gw.Players[0]);
  gw.Players[0].caseBegin:=7;
  gw.Players[0].caseEnd:=12;
  gw.Players[0].WinParts:=0;
  gw.Players[0].Id:=0;
  gw.Players[0].name:='Ordinateur';
  gw.Players[0].points:=0;
  New(gw.Players[1]);
  gw.Players[1].caseBegin:=1;
  gw.Players[1].caseEnd:=6;
  gw.Players[1].Id:=0;
  gw.Players[1].points:=0;
  Fill_Config;
  gw.Players[1].name:=config.ReadString('Info','UserName','Vous');
  gw.Players[1].WinParts:=0;
  gw.Difficulty:=config.ReadInteger('Info','Difficulty',0);
  gw.PartCount:=0;
  end;
end;


function initGame():integer;
begin
  New(gw);
  FillGameInfo(gw,true);
  PartState:=PS_END;
  form1.Cpu_timer.Enabled:=false;
end;
{fonction qui permet d'initialiser le jeur}
procedure startGame(first:boolean);
var
  i:integer;
begin
  PartState:=PS_END;
  form1.Cpu_timer.Enabled:=false;
  {cases init}
  new(tmpgw);
  {If first then
  begin
  New(gw);
  FillGameInfo(gw,true);
  end;
  }
  CPU_busy:=false;
  //Sleep(500);
  RefreshCases;


  RefreshPlayerInfo(0);
  RefreshPlayerInfo(1);
  

  If first then
  begin
  Randomize;
  gw.CurrPlayer:=Random(2);
  //showmessage(inttostr(gw.CurrPlayer));
  end;
  gw.FirstPlayer:=gw.CurrPlayer;
  RefreshGameInfo;
  CPU_busy:=false;
  changePlayer(true);
  PartState:=PS_PLAYING;
  form1.Cpu_timer.Enabled:=true;
  form1.im_plateau.Picture.LoadFromFile(GetResPath('plateau.png'));
   //-------------
   form1.begin_bt.Visible:=false;
   form1.StaticText2.Visible:=true;
end;
{fonction qui permet de tirer les points d'une case Waré}
function GetWarePoints(num,PlayerId:integer;Force:boolean):integer ;
begin
  result:=0;
  If (gw.casesFirst[num]=false)  and (gw.cases[num]=4)  then
  if (num>=gw.Players[playerId].caseBegin) and (num<=gw.Players[playerId].caseEnd) then
  begin
  gw.Players[playerId].points:=gw.Players[playerId].points+4;
  gw.cases[num]:=0;
  end
  else
  If force=true then
  begin
  gw.Players[playerId].points:=gw.Players[playerId].points+4;
  gw.cases[num]:=0;
  end
  else
  begin
  Shortmsg('Ceci n''est pas votre case',1);
  result:=1;
  end;
  RefreshCase(num);
  RefreshPlayerInfo(PlayerId);
  
end;
{Fonction qui permet de verifier si la case jouée appartient au player}
function IsPlayerCase(num,PlayerId:integer):boolean;
begin
  result:= (num>=gw.Players[playerId].caseBegin) and (num<=gw.Players[playerId].caseEnd)
end;

function GetCaseInfo(Casevalue:integer;tours,rest:Pinteger):integer;
begin
   tours^:= CaseValue div 12;
   rest^:=CaseValue-(tours^*12);

end;

function PlayCaseEx(num:integer;PlayerId:integer;CanChangePlayer:boolean):integer;
begin
  if (PlayerId<>Gw.CurrPlayer) then
  begin
  Shortmsg('C''est pas à vous de jouer',1);
  result:=1;
  exit;
  end;
  if gw.Cases[num]=0 then
  begin
  Shortmsg('Aucun pion à jouer',1);
  CPU_Player_busy:=false;
  result:=1;
  Exit;
  end;
  if ((playerId=1)  and (gw.Players[0].automatic=false)) then
  begin
    envoyer_jeu(gw.Players[0].Id,(num+gw.Players[0].casebegin-1))
  end;

 Gamethread:=TCaseplayer.Create(num,PlayerId,CanChangePlayer);
end;

{fonction qui permet de jouer un pion}
function PlayCase(num:integer;PlayerId:integer;CanChangePlayer:boolean):integer;
var
  tours:integer;
  rest:integer;
  i,a:integer;
begin
  result:=0;
  SaveUndo;
  if (IsPlayerCase(num,PlayerId)=false) then
  if (CPU_busy=false) then
  begin
  Shortmsg('Ceci n''est pas votre case',1);
  result:=1;
  exit;
  end;
  CPU_busy:=true;
 
  caseValue:=gw.cases[num];
  gw.cases[num]:=0;
  RefreshCase(num);
  If (Num=12) and (CaseValue>0) then
  iNum:=1
  else
  if CaseValue>0 then
  iNum:=Num+1 ;

  while not(caseValue=0) and (PartState<>PS_ENDING)   do
  begin
  //showmessage('ghgh');
    if not CPU_busy then
    exit;
    gw.Cases[iNum]:=gw.Cases[iNum]+1;
    gw.CasesFirst[iNum]:=false;
    RefreshCase(iNum);
    dec(CaseValue);

    If (iNum=12) and (Casevalue>0)then
    iNum:=1
    else
    if Casevalue>0 then
    inc(iNum);
    //Application.ProcessMessages;
    //sleep(500);
    DoanimSleep;
    If casevalue>0 then{au ca ou c'est la fin du jeu}
    checkCPU_WAREpoint;
    {Pour la pause}
    if PartState=PS_PAUSE then
    waitPause;
  end;
  {Pour finir la partie}
  If PartState=PS_ENDING then
  begin
     PartState:=PS_END;
     exit;
  end;
  {au cas ou on tombe dans une case non vide}
  form1.im_sel.Visible:=false;
  if gw.Cases[iNum]>1 then
  begin
  AffSelInfo(inum,playerId);
 // sleep(1000);
  If gw.Cases[inum]=4 then
  GetWarepoints(iNum,playerId,true)
  else
  begin
    if (playerId=1) or (gw.Players[0].automatic=false) then
    begin
     TimerCmd:=2;    timerCase:=iNum;
    
     while (timercmd=2) and (PartState<>PS_ENDING) do
     begin
        if not CPU_busy then
        exit;
        with form1 do
        begin
        if imChoice=false then
        im_sel.Picture.LoadFromFile(GetResPath('sel2.png'))
        else
        im_sel.Picture.LoadFromFile(GetResPath('sel.png'));
        imChoice:=imChoice=false;
        GetCaseInfo(gw.Cases[iNum],@tours,@rest);
        Shortmsg(Format('Le jeu continue dans la case %d [ %d tour(s), %d case(s) ]',[iNum,tours,rest]),0);
        sleep(500);
        end;
        {Pour la pause}
        if PartState=PS_PAUSE then
        waitPause;
     end;
     {Pour finir la partie}
     If PartState=PS_ENDING then
     begin
        PartState:=PS_END;
        exit;
     end;
      PlayCase(iNum,PlayerId,false)
     end
     else
     begin
     GetCaseInfo(gw.Cases[iNum],@tours,@rest);
     Shortmsg(Format('Le jeu  continue dans la case %d [ %d tour(s) , %d case(s) ]',[iNum,tours,rest]),0);
     //Shortmsg('le jeu de l''ordi continue dans la case '+inttostr(iNum),0);
     sleep(1000);
     PlayCase(iNum,PlayerId,false);
     end;

   end;

  end;



  if CanChangePlayer then
  changePlayer(false);
  CPU_busy:=false;
  //check_partend;
  
end;

{Fonction qui permet d'avoir le chemin des dossiers des ressources}
function GetResPath(ResName:string):string;
var
  FolderStr:string;
begin
  Fill_themeini;
  FolderStr:=ThemeIni.ReadString('Info','ResPath',GetAppDir+'res\');
  If ExtractFileDrive(FolderStr)='' then
  FolderSTr:=GetAppDir+FolderStr;
  result:= FolderStr+ResName;
  //showmessage(result);
end;
{Fonction qui permet d'avoir le chemin d'une application}
function GetAppDir:string;
begin
   result:=ExtractFilePath(Application.ExeName);
end;

{Fonction qui permet d'afficher  l'image d'un case}
function RefreshCase(num:integer):integer;
var
   Im:Timage;
begin

   with Form1 do
   begin
   Im:=Timage(Form1.FindComponent('im'+inttostr(num)));
   if (gw.Cases[num]=4) and (gw.CasesFirst[num]=false) then
   Im.Picture.LoadFromFile(GetResPath('pw.png'))
   else
   if gw.Cases[num]=0 then
   Im.Picture:=nil
   else
   begin
   //showmessage(GetAppDir+'res\p'+inttostr(Cases[num])+'.png');
   Im.Picture.LoadFromFile(GetResPath('p'+inttostr(gw.Cases[num])+'.png'));
   end;
   end;
   result:=0;
   
end;
{Fonction qui permet d'afficher un message }
function Shortmsg(msg:string;mtype:integer):integer;
begin
   with Form1 do
   begin
   s_msg.Caption:=msg;
   case mtype of
   0:s_msg.Font.Color:=0;
   1:s_msg.Font.Color:=rgb(255,0,0);
   end;
   end;

end;

{Fonction qui permet de rafraicheur les informations sur le jeu}
function RefreshGameInfo:integer;
const
  str= 'Nombres de parties jouées: %d   Engageur: %s';
begin
  refreshPlayerInfo(0);
  refreshPlayerInfo(1);

  with Form1 do
  begin
  InfoLabel.Caption:=Format(str,[gw.PartCount,gw.Players[gw.FirstPlayer].name]);
  P0_bar.Picture.LoadFromFile(GetResPath('Player1.png'));
  P1_bar.Picture.LoadFromFile(GetResPath('Player2.png'));
  end;


end;

{Fonction qui permet de rafraicheur sur un utilisateur}
function RefreshPlayerInfo(PlayerId:integer):integer;
var
  i:integer;
begin
   with Form1 do
   begin
   If PlayerId=0 then
   begin
   p0_point.Caption:=Inttostr(gw.Players[0].points);
   p0_win.Caption:=Format('Nombre de parties remportées: %d',[gw.Players[0].winparts]);
   end
   else
   begin
   p1_point.Caption:=Inttostr(gw.Players[1].points);
   p1_win.Caption:=Format('Nombre de parties remportées: %d',[gw.Players[1].winparts]);
   end;

   for i:=gw.Players[PlayerId].caseBegin to gw.Players[PlayerId].caseEnd do
   begin
   if PlayerId=0 then
   TLabel(FindComponent('l'+inttostr(i))).Font.Color:=rgb(255,0,0)
   else
   TLabel(FindComponent('l'+inttostr(i))).Font.Color:=rgb(0,180,0);
   end;
   p0_title.Caption:=gw.Players[0].Name;
   p1_title.Caption:=gw.Players[1].Name;
    p0_bar.Visible:=true;
   p1_bar.Visible:=true;
   p0_title.Visible:=p0_bar.Visible;
   p0_Point.Visible:=p0_bar.Visible;
   p1_title.Visible:=p1_bar.Visible;
   p1_Point.Visible:=p1_bar.Visible;

   end;
   result:=0;


end;
{Fonction qui permet de changer de joueur}
function ChangePlayer(Continue:boolean):integer;
begin
   CPU_Player_Busy:=false;
  
   gw.CurrCase:=1;

   if Continue=false then  // si c'est pa le premier engagement
   begin
      Case gw.CurrPlayer of
      0: begin
         gw.CurrPlayer:=1;
         
         form1.s_player.Caption:='C''est à vous de jouer';
         form1.s_player.Font.Color:=rgb(0,150,0);

         end;
      1: begin
         gw.CurrPlayer:=0;
         form1.s_player.Caption:='C''est à l''ordi de jouer';
         form1.s_player.Font.Color:=rgb(255,0,0);
         //Computerplay;
         end;
      end;
   end
   else
   begin
      Case gw.CurrPlayer of
      0: begin
         form1.s_player.Caption:='L''ordi commence le jeu';
         form1.s_player.Font.Color:=rgb(255,0,0);
         //Computerplay;
      end;
      1: begin
         form1.s_player.Caption:='C''est a vous de commencer le jeu';
         form1.s_player.Font.Color:=rgb(0,150,0);
      end;
      end;
   end;
   result:=0;
   Shortmsg('',0);
   form1.im_sel.Visible:=false;
   form1.Im_case.Visible:=false;
   sleep(500);
end;

{Fonction qui permet de savoir sur quelle case va se terminé un play}
function GetCasePlayEnd(num:integer):integer;
var
  iNum,CaseValue:integer;
begin

  CaseValue:=gw.Cases[num];
  iNum:=0;

  If (num=12) and (CaseValue>0) then
  iNum:=1
  else
  if CaseValue>0 then
  inum:=num+1
  else
  iNum:=0;
  while not (CaseValue=0) do
  begin
  Dec(caseValue);
  If (iNum=12)  and (casevalue>0)then
  iNum:=1
  else
  if CaseValue>0 then
  inc(Inum);

  end;
  result:=inum;
end;

{fonction qui permet montrer le trajet d'une case}
function AffSelInfo(num:integer;playerId:integer):integer;
var
  iNum:integer;
begin
  with form1 do
  begin
  im_sel.visible:=false;
  im_sel.Left:=TControl(FindComponent('im'+inttostr(num))).Left;
  im_sel.Top:=TControl(FindComponent('im'+inttostr(num))).top;
  im_Sel.Picture.LoadFromFile(GetResPath(Format('P%d_sel.png',[PlayerId])));
  im_sel.Visible:=true;
  iNum:=GetCasePlayEnd(num);

  If Inum>0 then
  begin
  im_case.Visible:=false;
  im_case.Left:=TControl(FindComponent('im'+inttostr(iNum))).Left;
  im_case.Top:=TControl(FindComponent('im'+inttostr(iNum))).top;
  im_case.Visible:=true;
  end
  else
  im_case.visible:=false;

    
  end;
  //form1.Realign;

end;
{fonction qui permet de voir si l'ordi na pas une case magique}
function CheckCPU_WarePoint:integer;
var
  i:integer;
begin
  for i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
  begin
    If gw.Cases[i]=4 then
    GetWarePoints(i,0,true)
  end;
  result:=0;
end;

{fonction qui permet de savoir s'il n'y a pas de carte à joué}
function Check_NoCaseToPlay:boolean;
var
    i,value:integer;

begin
    value:=0;
    if gw=nil then exit;
    for i:=gw.Players[gw.CurrPlayer].caseBegin to gw.Players[gw.CurrPlayer].caseEnd do
    begin
    value:=value+ gw.cases[i];
    end;
    If value=0  then
    begin
    if gw.currPlayer=1 then
    Shortmsg('vous n''avez aucun pion à jouer',1);
    sleep(500);
    ChangePlayer(false);
    end;

end;

{fonction qui permet de voir s'il reste 4 points}
function Check_PartEnd:integer;
var
  value,i:integer;
  count0,count1:integer;
begin
  Value:=0;
  if gw=nil then
  exit;
  for i:=1 to 12  do
  begin
  value:=value+gw.cases[i];
  end;
  If (value=4) or (value<4)then
  begin
  PartState:=PS_END;
  Shortmsg('fin de la partie',0);
  sleep(2000) ;
  gw.Players[gw.FirstPlayer].points:=gw.Players[gw.FirstPlayer].points+4;
  
  if AffEndpart(gw)=mrok then
  begin
  if gw.Players[0].points<>gw.Players[1].points   then
    if gw.Players[0].points>gw.Players[1].points  then
    inc(gw.Players[0].WinParts)
    else
    inc(gw.Players[1].WinParts);



  for i:=gw.players[0].caseBegin to gw.players[0].caseEnd do
  count0:=count0+gw.cases[i];
  for i:=gw.players[1].caseBegin to gw.players[1].caseEnd do
  count1:=count1+gw.cases[i];
     if not((count0=0) or (count1=0)) then
     begin
     gw.Players[1].caseBegin:=1;
     gw.Players[1].caseEnd:=gw.Players[1].points div 4;
     gw.Players[1].points:=0;
     gw.PartCount:=gw.PartCount+1;
     gw.Players[0].caseBegin:=gw.Players[1].caseEnd+1;
     gw.Players[0].caseEnd:=12;
     gw.Players[0].points:=0;

     FillgameInfo(gw,false);
     startGame(false);
     end
     else
     begin
     StopGame;
     startGame(true);
     end;
     
  end
  else
  begin
   Shortmsg('Fin de la partie',-1);
  end;


  end;



end;

procedure SaveUndo;
var
 i:integer;
begin
 if CPU_Busy then
 exit;
 if tmpgw=nil then New(tmpgw);
 FillGameInfo(tmpgw,true);
 for i:=1 to 12  do
 begin
 tmpgw.Cases[i]:=gw.cases[i];
 //Messagebox(0,PChar((format('%d  %d',[i,gw.Cases[i]]))),'',0);
 tmpgw.CasesFirst[i]:=gw.casesFirst[i];
 end;
 tmpgw.CurrCase:=gw.CurrCase;
 tmpgw.CurrPlayer:=gw.CurrPlayer;
 tmpgw.FirstPlayer:=gw.FirstPlayer;
 tmpgw.Difficulty:=gw.Difficulty;
 tmpgw.PartCount:=gw.PartCount;
 for i:=0 to 1  do
 begin;
 tmpgw.Players[i].id:=gw.Players[i].id;
 tmpgw.Players[i].points:=gw.Players[i].points;
 tmpgw.Players[i].Name:=gw.Players[i].Name;
 tmpgw.Players[i].caseBegin:=gw.Players[i].caseBegin;
 tmpgw.Players[i].caseEnd:=gw.Players[i].caseEnd;
 end;
end;

function SaveGame(path:string):integer;
var

  Gamefile:TfileStream;
  i,len:integer;
  str:string;
begin



 
  Gamefile:=TFileStream.Create(Path,fmCreate or fmShareExclusive);
  Gamefile.Position:=0;

  if tmpgw=nil then
  showmessage('hjhj');
  GameFile.WriteBuffer(tmpgw.PartCount,Sizeof(integer));
  GameFile.WriteBuffer(tmpgw.firstplayer,Sizeof(integer));
  GameFile.WriteBuffer(tmpgw.difficulty,Sizeof(integer));
  GameFile.WriteBuffer(tmpgw.currplayer,Sizeof(integer));
  GameFile.WriteBuffer(tmpgw.currcase,Sizeof(integer));

  for i:=0 to 1 do
  begin

     GameFile.WriteBuffer(tmpgw.Players[i].caseBegin,Sizeof(integer)) ;
     GameFile.WriteBuffer(tmpgw.Players[i].caseEnd,Sizeof(integer));
     GameFile.WriteBuffer(tmpgw.Players[i].points,Sizeof(integer));
     len:=Length(gw.Players[i].name);
     GameFile.WriteBuffer(len,Sizeof(integer)) ;
     GameFile.WriteBuffer(tmpgw.Players[i].name[1],len);
     GameFile.WriteBuffer(tmpgw.Players[i].WinParts,Sizeof(integer));
  end;
  for i:=1 to 12  do
  begin
  //Messagebox(0,PChar((format('%d  %d',[i,tmpgw.Cases[i]]))),'',0);
  GameFile.WriteBuffer(tmpgw.cases[i],Sizeof(integer));
  GameFile.WriteBuffer(tmpgw.casesFirst[i],Sizeof(integer));
  end;

  

  GameFile.Free;
end;

function LoadGameFromFile(Filestr:string):integer;
var
  Gamefile:TfileStream;
  i,len:integer;
  val:integer;
  str:string;
begin
  New(gw);
  FillGameInfo(gw,true);

  Gamefile:=TFileStream.Create(FileStr,fmOpenRead or fmShareExclusive);
  Gamefile.Position:=0;
  StopGame;
  //showmessage('hjhjh');
  GameFile.ReadBuffer(gw.PartCount,Sizeof(integer));
  GameFile.ReadBuffer(gw.firstplayer,Sizeof(integer));
  GameFile.ReadBuffer(gw.difficulty,Sizeof(integer));
  GameFile.ReadBuffer(gw.currplayer,Sizeof(integer));
  GameFile.ReadBuffer(gw.currcase,Sizeof(integer));

  for i:=0 to 1 do
  begin
  GameFile.ReadBuffer(gw.Players[i].caseBegin,Sizeof(integer)) ;
  GameFile.ReadBuffer(gw.Players[i].caseEnd,Sizeof(integer));
  GameFile.ReadBuffer(gw.Players[i].points,Sizeof(integer));
  GameFile.ReadBuffer(val,Sizeof(integer)) ;
  GameFile.ReadBuffer(gw.Players[i].name[1],val);
  GameFile.ReadBuffer(gw.Players[i].winparts,Sizeof(integer));
  end;

  for i:=1 to 12  do
  begin

  GameFile.ReadBuffer(gw.cases[i],Sizeof(integer));
  //Messagebox(0,PChar((format('%d  %d',[i,gw.Cases[i]]))),'',0);
  GameFile.ReadBuffer(gw.casesFirst[i],Sizeof(integer))
  end;


  startGame(false);

  GameFile.Free;

end;

{fonction qui permet de corriger le numero d'une case}
function _cnv(val:integer):integer;
var
  tours:integer;
begin
  tours:=val div 12;

  result:=val-(12*tours);
  If result=0 then
  result:=val;
end;
function Msgbox(text:string):integer;
begin
   result:=Application.MessageBox(Pchar(text),'',0);
end;

procedure StopGame;
var
   i:integer;
begin
   if  CPU_Busy=true then
   begin
   PartState:=PS_ENDING;
   while not (PartState=PS_END) do
   i:=0;
   CPU_Busy:=false;
   end;
end;

procedure PauseGame;
begin
   PartState:=PS_PAUSE;
end;
Procedure WaitPause;
var
  i:integer;
begin
  while PartState=PS_PAUSE do
  i:=0;
end;


procedure Fill_Config;
begin
  If Config=nil then
  Config:=TiniFIle.Create(GetAppDir+'config.ini');
  ThemePath:=Config.ReadString('AppConfig','themepath',GetAppDir+'res\default.ini')
end;
procedure Fill_ThemeIni;
begin
  Fill_Config;
  If ThemeIni=nil then
  ThemeIni:=TIniFIle.Create(ThemePath);
end;

Procedure DoAnimSleep;
begin
   Fill_Config;
   Case COnfig.ReadInteger('Info','Speed',1) of
   0:Sleep(800);
   1:Sleep(500);
   2:Sleep(400);
   3:Sleep(300);
   4:Sleep(100);
   5:Sleep(0);
   end;
end;


procedure TForm1.im_selDblClick(Sender: TObject);
begin
  If PartState=PS_END then
  exit;
  If (timercmd=2) and(CPU_busy) and (gw.Currplayer=1) then
  begin
  timercmd:=-1;
  //shortmsg('',0);
  form1.im_sel.Picture.LoadFromFile(GetResPath('sel.png'));
   if ((gw.Currplayer=1)  and (gw.Players[0].automatic=false)) then
  begin
    envoyer_jeu(gw.Players[0].Id,(TimerCase+gw.Players[0].casebegin-1))
  end;

  end
  else
  PlayCaseEx(gw.CurrCase,1,true)
end;


procedure TForm1.Button1Click(Sender: TObject);
var
 NewConfirm:boolean;
begin
 NewConfirm:=false;
 //Im_plateau.Picture.LoadFromFile(GetResPath('plateau3.png'));
 If PartState<>PS_END then
 begin
   PauseGame;
   if StartMenu('Voulez-vous sauver la partie avant de commencer une nouvelle ?',true,true)=mrok then
   begin
   StopGame;
   startGame(true);
   im_plateau.Picture.LoadFromFile(GetResPath('plateau.png'));
   NewConfirm:=true;
   end
   else
   PartState:=PS_PLAYING;
   {if gamethread<>nil then
   gamethread.Resume;}
 end
 else
 begin
 begin_bt.Visible:=true;
 //NewConfirm:=true;
 end;

 If NewConfirm then
 begin
 p0_bar.Visible:=true;
 
 p1_bar.Visible:=true;
 
 p0_title.Visible:=p0_bar.Visible=false;
 p0_Point.Visible:=p0_bar.Visible=false;
 p1_title.Visible:=p1_bar.Visible=false;
 p1_Point.Visible:=p1_bar.Visible=false;
 Shortmsg('',0);
  { if gamethread<>nil then
   begin
   CPU_busy:=false;
   //Showmessage('ghghg');
   gamethread.Terminate;
   while not gamethread.Terminated do
   CPU_busy:=false;
   end;}
    //Application.ProcessMessages;

 end;
 StaticText2.Visible:=true;

end;

procedure TForm1.Im1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  num:integer;
  str:string;
  tours,rest:integer;
  Showmsg:boolean;
begin
  //showmessage('gghg');
  if PartState=PS_END then
  exit;
  str:=RightStr(Timage(sender).Name,2);
  //showmessage(str);
  If pos(str[1],'0123456789')>0 then
  num:=StrToint(str)
  else
  num:=StrToInt(str[2]);
  //showmessage(inttostr(num));
  Showmsg:=true;
  If ssShift in Shift then
  begin
  Showmsg:=(GetWarepoints(num,1,false)=0);
  end;
  {Au cas ou l'ordi est occupé}
  If (CPU_busy=false) and (gw.CurrPlayer=1) then
  begin
  GetCaseInfo(gw.Cases[num],@tours,@rest);
  gw.CurrCase:=num;
  im_sel.Cursor:=crDefault;
  AffSelInfo(num,gw.CurrPlayer);
  if Showmsg then
  Shortmsg(Format('Trajet: %d tour(s) et %d cases [%d Pion(s)]',[tours,rest,gw.Cases[num]]),0);
  end;
end;

procedure TForm1.Im_caseClick(Sender: TObject);
begin
  Im_case.Visible:=false;
end;

procedure TForm1.im_selMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ssShift in Shift then
  begin
  GetWarepoints(gw.CurrCase,gw.Currplayer,false);
  end;
  
end;

procedure TForm1.Im_caseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ssShift in Shift then
  begin
  GetWarepoints(gw.CurrCase,gw.Currplayer,false);
  end;
  
end;

procedure TForm1.About1Click(Sender: TObject);
const
  str='GhomeAfro 1.0'+#10#13+#10#13+'Contact: ghomeafro@yahoo.fr'+#10#13+#10#13
       +'(C) Copyright 2008 Kikoné Kiswendsida';
begin
  Application.MessageBox(str ,'About',0);
end;

procedure TCasePlayer.Execute;
begin
  PlayCase(num,PlayerId,CanChangePlayer);
  
end;
constructor TCasePlayer.Create(inum,iPlayerId:integer;iCanChangePlayer:boolean);
begin
  inherited Create(true);
  num:=inum;
  playerId:=iPlayerId;
  canChangePlayer:=icanChangePlayer;
  resume;
end;

procedure TForm1.Quitter1Click(Sender: TObject);
begin
  form1.Close;
end;

procedure TForm1.Enregistrerlapartie1Click(Sender: TObject);
begin
  PauseGame;
  if not DirectoryExists(GetAppDIr+'Saved\') then
  CreateDir(GetAppDIr+'Saved\');
  SaveD.InitialDir:=GetAppDir+'Saved\';
  try
  If SaveD.Execute then
  begin
  SaveGame(SaveD.FileName{'c:\jkgame.gcf'});
  end;
  except
  Shortmsg('Impossible d''enregistrer le jeu !' ,1);
  end;
  PartState:=PS_PLAYING;
end;

procedure TForm1.Charcherunepartie1Click(Sender: TObject);
begin
 if not DirectoryExists(GetAppDIr+'Saved\') then
 CreateDir(GetAppDIr+'Saved\');
 OpenD.InitialDir:=GetAppDIr+'Saved\';
 try
 If OpenD.Execute then
 loadGameFromFile(OpenD.FileName);
 except
 Shortmsg('Impossible de charger le jeu !',1);
 end;
end;

procedure TForm1.theme1Click(Sender: TObject);
var
   sr: TSearchRec;
begin
   if FindFirst('*.gh.theme', faAnyFile, sr) = 0 then
   begin
      repeat
        if (sr.Attr and faAnyFile) = sr.Attr then
        begin
        
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  StopGame;
  CanClose:=true;

end;

procedure TForm1.Difficult1Click(Sender: TObject);
begin

    df_0.Checked:=gw.Difficulty=0;
    df_1.Checked:=gw.Difficulty=1;
    df_2.Checked:=gw.Difficulty=2;

end;

procedure TForm1.File1Click(Sender: TObject);
begin
   difficult1.Enabled:=gw<>nil;
   Option1.Enabled:=gw<>nil;
   Enregistrerlapartie1.Enabled:=tmpgw<>nil;
   if (gw<>nil)then
   docancel.Enabled:=((gw.CurrPlayer=1) and (tmpgw<>nil) and (CPu_busy=true));
end;

procedure TForm1.df_0Click(Sender: TObject);
begin
  if df_0.Checked then
  gw.Difficulty:=0;
  if df_1.Checked then
  gw.Difficulty:=1;
  if df_2.Checked then
  gw.Difficulty:=2;
  config.WriteInteger('Info','Difficulty',gw.Difficulty)
end;

procedure TForm1.CPU_TimerTimer(Sender: TObject);
begin

if gw.Players[0].automatic=true then
begin
   If PartState=PS_PLAYING then
   begin
     Check_PartEnd;
     If (gw.CurrPlayer=0)  and (not CPU_busy) and (CPU_Player_Busy=false) then
     begin
     CPU_Player_Busy:=true;
     P0_busy.Visible:=true;
     Computerplay(gw.Difficulty);
     end;
     If CPU_Player_Busy then
     P0_busy.Visible:=true
     else
     P0_busy.Visible:=false;
     {If P0_Busy.Tag=0 then
     P0_Busy.Tag:=1
     else
     P0_Busy.Tag:=0;
     P0_busy.Picture.LoadFromFile(GetresPath(Format('P0_busy%d.png',[P0_Busy.Tag])));

       }

    end;
end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  If (PartState<>PS_END) and (CPU_Busy=false) then
  begin
  Check_NoCaseToPlay;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PartState:=PS_END;

   if (not(db_Connect(true)=0)) then
   begin
      Connection1.Enabled:=false;
      live.Enabled:=false;

      last_cmd:=-1;
   end
   else
   begin

  New(gw);
  FillGameInfo(gw,true);
  
   end;

end;

procedure TForm1.begin_btClick(Sender: TObject);
begin
   
   startGame(true);
  
   
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
begin
  for i:= gw.Players[1].caseBegin to gw.Players[1].caseEnd  do
  begin
  Showmessage(inttostr(TestPlay(i,1,CaseArray(gw.cases),4))+'result case'+inttostr(i));
  end;
end;

procedure TForm1.DoCancelClick(Sender: TObject);
var
 i:integer;
begin
 stopGame;
 for i:=1 to 12 do
 begin
 gw.Cases[i]:=tmpGw.Cases[i];
 gw.CasesFirst[i]:=tmpgw.CasesFirst[i];
 end;
 for i:=0 to 1 do
 gw.Players[0].points:=tmpgw.players[0].points;
 gw.CurrPlayer:=tmpgw.CurrPlayer;
 startGame(false);

end;

procedure TForm1.Im1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

   if gw=nil then
   exit;

   If ssShift in Shift then
   TImage(Sender).Cursor:=crHandPoint
   else
   TImage(Sender).Cursor:=crDefault;
end;

procedure TForm1.Option1Click(Sender: TObject);
begin
  If gw=nil then
  exit;
  Aff_option;
end;

procedure TForm1.Commentjouer1Click(Sender: TObject);
begin
  ShowQuickHelp;
end;

procedure TForm1.im_selMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if gw=nil then
   exit;

   If ssShift in Shift then
   TImage(Sender).Cursor:=crHandPoint
   else
   if gw.CurrPlayer=0 then
   TImage(Sender).Cursor:=crHourGlass
   else
   TImage(Sender).Cursor:=crDefault;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:integer;
begin
   {Continue}
   If (key=vk_return)  And (PartState<>PS_END) and (CPU_Busy=true) and (timercmd=2) then
   begin
   im_selDblClick(sender)
   end;
   {Move Left}
   If (key=VK_LEFT)  And (PartState<>PS_END) and (CPU_Busy=false) and (gw.CurrPlayer=1) then
   begin
    if (gw.currCase=1) then
    gw.CurrCase:=12
    else
    gw.CurrCase:=gw.CurrCase-1;
    AffSelInfo(gw.CurrCase,gw.CurrPlayer);
   end;
   {Move right}
   If (key=VK_RIGHT)  And (PartState<>PS_END) and (CPU_Busy=false) and (gw.CurrPlayer=1) then
   begin
    if (gw.currCase=12) then
    gw.CurrCase:=1
    else
    gw.CurrCase:=gw.CurrCase+1;
    AffSelInfo(gw.CurrCase,gw.CurrPlayer);
   end;
   {Play}
   If (key=VK_RETURN)  And (PartState<>PS_END) and (CPU_Busy=false) and (gw.CurrPlayer=1) then
   begin
   im_selDblClick(sender)
   end;
   {Get Magic}
   If ((key=VK_DOWN)  And (ssShift in shift))	 then
   begin
      //showmessage('gghg');
    for i:=gw.Players[1].caseBegin to  gw.Players[1].caseEnd do
    begin
       GetWarepoints(i,1,false);
    end;

   end;

end;

procedure TForm1.Connection1Click(Sender: TObject);
begin
    last_cmd:=-1;
     form7.showmodal();

end;

function _str(numeric:integer):string;
begin
  result:=inttostr(numeric);
end;


function send_cmd(cmd:Pcmd;destID:integer):integer;
var
   sql:string;
   my_time:integer;
begin
  my_time:=DateTimeToUnix(now);
  //cmd.senderID:=gw.players[1].id ;
  sql:=    'INSERT INTO ware_board (`pseudoID`,`destID`,`cmd`,`str_arg`,`int_arg`,`comment`,`timestamp`,`status`)' ;
  sql:=sql+' VALUES("'+_str(cmd.senderID)+'","'+_str(destID)+ '","'+_str(cmd.Cmd)+'","'+cmd.strarg+'","'+_str(cmd.intarg)+'","'+cmd.comment+'","'+_str(my_time)+'","-1")';
  //showmessage(sql);
  requete(sql);
end;

function traiter_invitation(msg:Pcmd):integer;
var
 newmsg:Pcmd;
 sql:string;
begin
  if (msg.senderID=gw.players[0].Id)  then
  begin
    sql:=' UPDATE  ware_board SET status=0 WHERE id='+inttostr(msg.id);
    requete(sql);
    exit;
  end;

  if (messagebox(application.Handle,Pchar('Voulez vous ajouer avec '+_str(msg.senderID)),'INVITATION', MB_YESNO)=IDYES)then
  begin
    new(newmsg);
    newmsg.senderID:=gw.players[1].Id;
    newmsg.Cmd:=LIVE_ACCEPT;
    gw.Players[0].automatic:=false;
    gw.Players[0].Id:=msg.senderID;
    gw.CurrPlayer:=msg.intarg;

    send_cmd(newmsg,msg.senderID);
    showmessage('msgid'+inttostr(msg.id));
    sql:=' UPDATE  ware_board SET status=0 WHERE id='+inttostr(msg.id);
    requete(sql);

   // StartPlaying(msg.intarg);//le player engageur;
    Shortmsg('En attente de '+_str(msg.senderID),0);
    startGame(false);
  end
  else
  begin
    new(newmsg);
    newmsg.senderID:=gw.players[1].Id;
    newmsg.Cmd:=LIVE_REFUSE;
    Send_cmd(newmsg,msg.senderID);
  end;


end;

function traiter_accept(msg:pcmd):integer;
var sql:string;
begin
  //wait_dialog.close;
  Application.messagebox(pchar(inttostr(msg.senderID)+' vous a accepter votre demande'),'',0);
  sql:=' UPDATE  ware_board SET status=0 WHERE id='+inttostr(msg.id);
  requete(sql);

  startGame(false);
end;
function traiter_refuse(msg:Pcmd):integer;
var
  sql:string;
begin

  messagebox(0,pchar(_str(msg.senderID)+ 'a refusé votre demande au jeu'),'REFUS',0);
    sql:=' UPDATE  ware_board SET status=0 WHERE id='+inttostr(msg.id);
    requete(sql);

  //wait_dialog.close;
end;
{
function traiter_func(msg:pcmd);
begin

end;
}
function envoyer_demande(pseudoID:integer):integer;
var
 cmd:Pcmd;
begin
 new(cmd);
 cmd.Cmd:=LIVE_INVITATION;
 cmd.senderID:=gw.players[1].Id;
 gw.Players[0].automatic:=false;
 gw.Players[0].Id:=pseudoID ;
 FillGameInfo(gw,false);
 Randomize;
 gw.CurrPlayer:=random(2);
 //showmessage(inttostr(gw.currplayer));
 if gw.CurrPlayer=0 then  cmd.intarg:= 1    else    cmd.intarg:= 0; 
 send_cmd(cmd,pseudoID);
 shortmsg('Attente accord de '+_str(gw.players[0].Id),0);



end;

function envoyer_abort(pseudoID:integer):integer;
var
  cmd:Pcmd;
begin
  new(cmd);
  cmd.Cmd:=LIVE_ABORT;
  cmd.senderID:=gw.players[1].Id;
  send_cmd(cmd,pseudoID);

end;
function traiter_abort(msg:Pcmd):integer;
begin
  messagebox(0,'Le jeu a été abandonné par votre adversaire','Arret du jeu',0);

end;

function envoyer_jeu(destID,caseID:integer):integer;
var
  cmd:Pcmd;
begin
  new(cmd);
  cmd.Cmd:=LIVE_PLAY_CASE;
  cmd.senderID:=gw.players[1].Id;
  cmd.intarg:=CaseID;
  send_cmd(cmd,destID);

end;
//met a jour le status du message
function update_msg_status(msg:pcmd) :integer;
var
  sql:string;
begin
  sql:='UPDATE ware_board SET status=0';
  sql:=sql+' WHERE id='+_str(msg.id );
  mysql_query(my_con,Pchar(sql));
end;

function traiter_jeu(msg:Pcmd):integer;
begin
  if (gw.currplayer=0) then
  begin
    //showmessage('Jeu'+inttostr(msg.intarg));
    PlayCaseEx(msg.intarg,0,true);
    update_msg_status(msg);
  end;
  
end;


function traiter_cmd(cmd:Pcmd):integer;
begin
  case cmd.cmd  of
  LIVE_INVITATION:
                 begin
                 traiter_invitation(cmd);
                 end;
  LIVE_ABORT:
                 begin
                 traiter_abort(cmd);
                 end;
  LIVE_REFUSE:
                 begin
                 traiter_refuse(cmd);
                 end;
  LIVE_ACCEPT:
                 begin
                 traiter_accept(cmd);
                 end;
  LIVE_PLAY_CASE:
                 begin
                 traiter_jeu(cmd);
                 end;
  end;
end;

procedure TForm1.LiveTimer(Sender: TObject);
const
   id=0; pseudoID=1; destID=2;cmd=3; str_arg=4; int_arg=5; comment=6;  timestamp=7;

var
   msg:pcmd;
   sql:string;
   my_res:PMYSQL_RES;
   data:PMYSQL_ROW;
begin
   sql:=    ' SELECT * FROM ware_board';
   sql:=sql+' WHERE  destID='+_str(gw.players[1].Id);
   sql:=sql+' AND status=-1';
   sql:=sql+' ORDER BY timestamp ASC';
   //showmessage(sql);
   my_res :=requete(sql);
   data := mysql_fetch_row(my_res);
   if data<>nil then
   begin
   if last_cmd<> strToint(string(data[id])) then
   begin
   new(msg);
   msg.id:=strToint(string(data[id]));
   msg.senderID:=strToint(string(data[pseudoID]));
   msg.intarg:=strToint(string(data[int_arg]));
   msg.Cmd:=strToint(string(data[cmd]));
   msg.strarg:=string(data[str_arg]);
   msg.comment:=string(data[comment]);
   msg.timestamp:=strToint(string(data[timestamp]));
   last_cmd:=strToint(string(data[id]));;
   traiter_cmd(msg);                                   
   end;
   
   end;
   
   sql:=' UPDATE ware SET timestamp='+ _str(DateTimeToUnix(time()));
   sql:=sql+' WHERE pseudoID='+_str(gw.players[1].Id) ;
   //showmessage(sql);
   requete(sql);


end;

function db_connect(silent:boolean=false):integer;
var
    myErrorMsg : AnsiString;
    Time_out:integer;
begin
  my_con:= mysql_init(nil);

  Time_out:=10;
  Mysql_options(my_con,Mysql_Opt_Connect_Timeout, Pchar(inttostr(Time_out))) ;
  if mysql_real_connect(my_con, 'localhost', 'root', '', 'gssv2008', 0, nil, 0) <> nil then
  begin
        // Connection réussie
        result:=0;
  end else
  begin
        // Echec de connection
        result:=1;
        myErrorMsg := mysql_error(my_con);
        if not silent then showmessage(myErrorMsg);
  end;

end;

function requete(sql:string):PMYSQL_RES;
var
    myErrorMsg : AnsiString;
    retour:integer;
begin
  retour:=mysql_query(my_con,pchar(sql));
  if (not(retour=0)) then
  begin
  myErrorMsg := mysql_error(my_con);
  showmessage(myErrorMsg);
  end  else
  begin
    result := mysql_store_result(my_con);
  end;

end;




end.
