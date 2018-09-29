unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls,strutils, Menus, ActnList,start,inifiles,
  XPMan ;


type
PPlayer=^gPlayer;
gPlayer=record
  points:integer;
  caseBegin:integer;
  caseEnd:integer;
  Id:integer;
  Name:string;
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
    XPManifest1: TXPManifest;
    begin_bt: TButton;
    SaveD: TSaveDialog;
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
function ComputerPlay:integer;
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

var
  Form1: TForm1;
  Gw:PGameInfo;
  tmpGw:PGameInfo;
 (* cases:array[1..12] of integer;
  CasesFirst:array[1..12] of boolean;
  Players:array [0..2] of PPlayer;
  CurrPlayer:integer;{Joueur actuelle}
  CurrCase:integer; {Case actuelle}   *)
  CPU_busy:boolean; {Indique que l'ordi est occupé}
  CaseValue,iNum:integer;{pour PlayCase}
  TimerCmd:integer;{Pour playCase}
  ImChoice:boolean;{Pour PlayCase}
  Gamethread:TCaseplayer;
  PartState:integer;
  CPU_Player_Busy:boolean;
  ThemePath:string;
  ThemeIni:TiniFile;
  Config:TiniFile;


const
  PS_END=3;
  PS_CPU_BUSY=1;
  PS_PLAYING=0;

implementation

{$R *.dfm}
uses PartEnd;

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
  gw.Players[0].Id:=0;
  gw.Players[0].name:='l''ordinateur';
  gw.Players[0].points:=0;
  New(gw.Players[1]);
  gw.Players[1].caseBegin:=1;
  gw.Players[1].caseEnd:=6;
  gw.Players[1].Id:=0;
  gw.Players[1].points:=0;
  gw.Players[1].name:='vous';
  gw.Difficulty:=0;
  gw.PartCount:=0;
  end;
end;

{fonction qui permet d'initialiser le jeur}
procedure InitGame(first:boolean);
var
  i:integer;
begin
  PartState:=PS_END;
  form1.Cpu_timer.Enabled:=false;
  {cases init}
  new(tmpgw);
  If first then
  begin
  New(gw);
  FillGameInfo(gw,true);
  end;
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
  gw.FirstPlayer:=gw.CurrPlayer;
  end;
  RefreshGameInfo;
  CPU_busy:=false;
  changePlayer(true);
  PartState:=PS_PLAYING;
  form1.Cpu_timer.Enabled:=true;
 
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

  while not(caseValue=0) and (PartState<>PS_END)   do
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
    sleep(500);
    If casevalue>0 then{au ca ou c'est la fin du jeu}
    checkCPU_WAREpoint;
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
    if playerId=1 then
    begin
     TimerCmd:=2;
    
     while (timercmd=2) and (PartState<>PS_END) do
     begin
        if not CPU_busy then
        exit;
        with form1 do
        begin
        if imChoice=false then
        im_sel.Picture.LoadFromFile(GetAppDir+'res\sel2.png')
        else
        im_sel.Picture.LoadFromFile(GetAppDir+'res\sel.png');
        imChoice:=imChoice=false;
        Shortmsg('le jeu continue dans la case '+inttostr(iNum),0);
        sleep(500);
        end;
     end;
      PlayCase(iNum,PlayerId,false)
     end
     else
     begin
     Shortmsg('le jeu de l''ordi continue dans la case '+inttostr(iNum),0);
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
  showmessage(result);
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
   Im.Picture.LoadFromFile(GetAppDir+'res\pw.png')
   else
   if gw.Cases[num]=0 then
   Im.Picture:=nil
   else
   begin
   //showmessage(GetAppDir+'res\p'+inttostr(Cases[num])+'.png');
   Im.Picture.LoadFromFile(GetAppDir+'res\p'+inttostr(gw.Cases[num])+'.png');
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

  Form1.InfoLabel.Caption:=Format(str,[gw.PartCount,gw.Players[gw.FirstPlayer].name]);



end;

{Fonction qui permet de rafraicheur sur un utilisateur}
function RefreshPlayerInfo(PlayerId:integer):integer;
var
  i:integer;
begin
   with Form1 do
   begin
   If PlayerId=0 then
   p0_point.Caption:=Inttostr(gw.Players[0].points)
   else
   p1_point.Caption:=Inttostr(gw.Players[1].points);

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
   if Continue=false then
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
{fonction qui permet à l'ordinteur de jouer}
function ComputerPlay:integer;
var
   i,a,iNum,Importance:integer;
   tours,rest,j:integer;

begin
   Importance:=0;
   {Tactic 1: cherche une case au hasard pour jouer}
  
   randomize;
   

   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   if (gw.Cases[i]>0) then
   begin
     iNum:=i;
     j:=random(2);
     if j=0 then
     begin
     importance:=0;
     //msgbox('tactic1');
     break;
     end;
   end;

   {Tactic 2: rechercher si on ne peut pas avoir de 4 magic en jouant une case}
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     j:=0;
     for a:= i+1 to (i+gw.Cases[i]) do
     begin
       //showmessage(inttostr(a));

       If ((gw.Cases[_cnv(a)]+tours+1)=4)and(
          (_cnv(a)>=gw.Players[0].caseBegin) and
           (_cnv(a)<=gw.Players[0].caseEnd)) then
       begin
       inc(j);
       iNum:=i;
      
       if importance<j then
       begin
       iNum:=i;
       Importance:=j;
       //msgbox('tactic2')
       end;
       end;
      end;
   end;
   //msgbox('Jacob');
   {Tactic 3: recherche si la case ne tombe sur quatre magic}
   For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     if (gw.Cases[_cnv(i+gw.cases[i]+1)]+tours+1)=4 then
     if importance=0 then
     begin
     Importance:=1;
     inum:=i;
     //msgbox('tactic3');
     break;
     end;
   end;

   {Tactic 4: recherche si one ne peut pas avoir une case de 3 points en jouant une case}
    For i:=gw.Players[0].caseBegin to gw.Players[0].caseEnd do
    begin
       j:=0;
       for a:= i+1 to (gw.Cases[i]+i) do
       begin

         If ((gw.Cases[_cnv(a)]+tours+1)=3) and (
            (_cnv(a)>=gw.Players[0].caseBegin) and
           (_cnv(a)<=gw.Players[0].caseEnd)) then
         begin
         inc(j);
         if (importance=0) and (j>=1) then
         begin
         iNum:=i;
         Importance:=j;
         ///msgbox('tactic4');
         end;
         end;

       end;
    end;

   //msgbox(inttostr(iNum));
   Shortmsg('l''ordi joue la case'+inttostr(iNum),0);
   AffSelInfo(iNum,0);
   Application.ProcessMessages;
   sleep(1000);

   PlayCaseEx(iNum,0,true);
   

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
    If value=0 then
    begin
    Shortmsg('vous n''avez aucun pion à jouer',1);
    sleep(500);
    ChangePlayer(false);
    end;

end;

{fonction qui permet de voir s'il reste 4 points}
function Check_PartEnd:integer;
var
  value,i:integer;
begin
  Value:=0;
  if gw=nil then
  exit;
  for i:=1 to 12  do
  begin
  value:=value+gw.cases[i];
  end;
  If value=4 then
  begin
  Shortmsg('fin de la partie',0);
  sleep(2000) ;
  PartState:=PS_END;
  gw.Players[gw.FirstPlayer].points:=gw.Players[gw.FirstPlayer].points+4;
  if AffEndpart(gw)=mrok then
  begin
  gw.Players[1].caseBegin:=1;
  gw.Players[1].caseEnd:=gw.Players[1].points div 4;
  gw.Players[1].points:=0;
  gw.PartCount:=gw.PartCount+1;
  gw.Players[0].caseBegin:=gw.Players[1].caseEnd+1;
  gw.Players[0].caseEnd:=12;
  gw.Players[0].points:=0;

  FillgameInfo(gw,false);
  InitGame(false);
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
  end;

  for i:=1 to 12  do
  begin

  GameFile.ReadBuffer(gw.cases[i],Sizeof(integer));
  //Messagebox(0,PChar((format('%d  %d',[i,gw.Cases[i]]))),'',0);
  GameFile.ReadBuffer(gw.casesFirst[i],Sizeof(integer))
  end;


  initGame(false);

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


procedure TForm1.im_selDblClick(Sender: TObject);
begin
  If PartState=PS_END then
  exit;
  If (timercmd=2) and(CPU_busy) and (gw.Currplayer=1) then
  begin
  timercmd:=-1;
  shortmsg('',0);
  form1.im_sel.Picture.LoadFromFile(GetAppDir+'res\sel.png');
  end
  else
  PlayCaseEx(gw.CurrCase,1,true)
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
 if gamethread<>nil then
 begin
 CPU_busy:=false;
 //Showmessage('ghghg');
 gamethread.Terminate;
 while not gamethread.Terminated do
 CPU_busy:=false;
 end;
 Application.ProcessMessages;
 Im_plateau.Picture.LoadFromFile(GetResPath('plateau3.png'));
 begin_bt.Visible:=true;
 p0_bar.Visible:=false;
 p1_bar.Visible:=false;
 p0_title.Visible:=p0_bar.Visible;
 p0_Point.Visible:=p0_bar.Visible;
 p1_title.Visible:=p1_bar.Visible;
 p1_Point.Visible:=p1_bar.Visible;
 //form4.Show;

 

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
  If CPU_busy=false then
  begin
  GetCaseInfo(gw.Cases[num],@tours,@rest);
  gw.CurrCase:=num;
  AffSelInfo(num,gw.CurrPlayer);
  if Showmsg then
  Shortmsg(Format('Trajet: %d tour(s) et %d cases, Pions:%d',[tours,rest,gw.Cases[num]]),0);
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
  If SaveD.Execute then
  SaveGame(SaveD.FileName{'c:\jkgame.gcf'});
end;

procedure TForm1.Charcherunepartie1Click(Sender: TObject);
begin
 If OpenD.Execute then
 loadGameFromFile(OpenD.FileName);
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
  if CPU_busy then
  CPU_busy:=false;
  
  if Gamethread<>nil then
  GameThread.Terminate;

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
end;

procedure TForm1.df_0Click(Sender: TObject);
begin
  if df_0.Checked then
  gw.Difficulty:=0;
  if df_1.Checked then
  gw.Difficulty:=1;
  if df_2.Checked then
  gw.Difficulty:=2;
end;

procedure TForm1.CPU_TimerTimer(Sender: TObject);
begin
   If PartState=PS_PLAYING then
   begin
     Check_PartEnd;
     If (gw.CurrPlayer=0)  and (not CPU_busy) and (CPU_Player_Busy=false) then
     begin
     CPU_Player_Busy:=true;
     Computerplay;
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
end;

procedure TForm1.begin_btClick(Sender: TObject);
begin
   begin_bt.Visible:=false;
   InitGame(true);
   im_plateau.Picture.LoadFromFile(GetResPath('plateau.png'));
end;

end.
