unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls,strutils, Menus;


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
    p_user: TLabel;
    p1_point: TLabel;
    p0_title: TLabel;
    p0_point: TLabel;
    s_msg: TLabel;
    Button1: TButton;
    s_player: TLabel;
    Image1: TImage;
    Image2: TImage;
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
  private
    { Private declarations }
  public
    { Public declarations }
    
  end;
PPlayer=^gPlayer;
gPlayer=record
  points:integer;
  caseBegin:integer;
  caseEnd:integer;
  Id:integer;
end;
function RefreshCase(num:integer):integer;
function RefreshPlayerInfo(PlayerId:integer):integer;
function Shortmsg(msg:string;mtype:integer):integer;
function ChangePlayer:integer;
function AffSelInfo(num:integer;playerId:integer):integer;
function ComputerPlay:integer;
function CheckCPU_WarePoint:integer;
function Check_PartEnd:integer;
function GetAppDir:string;

var
  Form1: TForm1;
  cases:array[1..12] of integer;
  CasesFirst:array[1..12] of boolean;
  Players:array [0..2] of PPlayer;
  CurrPlayer:integer;
  CurrCase:integer;
  CPU_busy:boolean;
  CaseValue,iNum:integer;{pour PlayCase}
  TimerCmd:integer;
  ImChoice:boolean;
  LastSel:integer;


implementation

{$R *.dfm}

{function qui permet d'initialiser une case}
function initCase(num:integer):integer;
begin
  cases[num]:=4;
  casesFirst[num]:=true;
  result:=0;
end;
{fonction qui permet d'initialiser le jeur}
procedure InitGame(newPlayers:boolean);
var
  i:integer;
begin
  {cases init}
  for i:=1 to 12 do
  begin
  initcase(i);
  RefreshCase(i);
  end;
  If NewPlayers=true then
  begin
  {Players init}
  New(Players[0]);
  Players[0].caseBegin:=7;
  Players[0].caseEnd:=12;
  Players[0].Id:=0;
  Players[0].points:=0;
  New(Players[1]);
  Players[1].caseBegin:=1;
  Players[1].caseEnd:=6;
  Players[1].Id:=0;
  Players[1].points:=0;
  end;
  RefreshPlayerInfo(0);
  RefreshPlayerInfo(1);
  CurrPlayer:=0;
  changePlayer;
  
  CPU_busy:=false;
end;
{fonction qui permet de tirer les points d'une case Waré}
function GetWarePoints(num,PlayerId:integer;Force:boolean):integer ;
begin
  result:=0;
  If (casesFirst[num]=false)  and (cases[num]=4)  then
  if (num>=Players[playerId].caseBegin) and (num<=Players[playerId].caseEnd) then
  begin
  Players[playerId].points:=Players[playerId].points+4;
  cases[num]:=0;
  end
  else
  If force=true then
  begin
  Players[playerId].points:=Players[playerId].points+4;
  cases[num]:=0;
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
  result:= (num>=Players[playerId].caseBegin) and (num<=Players[playerId].caseEnd)
end;

function GetCaseInfo(Casevalue:integer;tours,rest:Pinteger):integer;
begin
   tours^:= CaseValue div 12;
   rest^:=CaseValue-(tours^*12);
end;

function PlayCaseEx(num:integer;PlayerId:integer;CanChangePlayer:boolean):integer;
begin
  TCaseplayer.Create(num,PlayerId,CanChangePlayer);
end;

{fonction qui permet de jouer un pion}
function PlayCase(num:integer;PlayerId:integer;CanChangePlayer:boolean):integer;
var
  tours:integer;
  rest:integer;
  i,a:integer;
begin
  result:=0;
 
  if (IsPlayerCase(num,PlayerId)=false) then
  if (CPU_busy=false)  then
  begin
  Shortmsg('Ceci n''est pas votre case',1);
  result:=1;
  exit;
  end;
   CPU_busy:=true;
  caseValue:=cases[num];
  cases[num]:=0;
  RefreshCase(num);
  If Num=12 then
  iNum:=1
  else
  iNum:=Num+1 ;

  while not(caseValue=0) do
  begin
  //showmessage('ghgh');

    Cases[iNum]:=Cases[iNum]+1;
    CasesFirst[iNum]:=false;
    RefreshCase(iNum);
    dec(CaseValue);

    If (iNum=12) and (Casevalue>0)then
    iNum:=1
    else
    if Casevalue>0 then
    inc(iNum);
    //Application.ProcessMessages;
    sleep(500);
    checkCPU_WAREpoint;
  end;
  {au cas ou on tombe dans une case non vide}
  form1.im_sel.Visible:=false;
  if Cases[iNum]>1 then
  begin
  AffSelInfo(inum,playerId);
 // sleep(1000);
  If Cases[inum]=4 then
  GetWarepoints(iNum,playerId,true)
  else
  begin
    if playerId=1 then
    begin
     TimerCmd:=2;
    
     while timercmd=2 do
     begin
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
     sleep(500);
     PlayCase(iNum,PlayerId,false);
     end;

   end;

  end;
  if CanChangePlayer then
  changePlayer;

  CPU_busy:=false;
  check_partend;
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
   if (Cases[num]=4) and (CasesFirst[num]=false) then
   Im.Picture.LoadFromFile(GetAppDir+'res\pw.png')
   else
   if Cases[num]=0 then
   Im.Picture:=nil
   else
   begin
   //showmessage(GetAppDir+'res\p'+inttostr(Cases[num])+'.png');
   Im.Picture.LoadFromFile(GetAppDir+'res\p'+inttostr(Cases[num])+'.png');
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

{Fonction qui permet de rafraicheur sur un utilisateur}
function RefreshPlayerInfo(PlayerId:integer):integer;
var
  i:integer;
begin
   with Form1 do
   begin
   If PlayerId=0 then
   p0_point.Caption:=Inttostr(Players[0].points)
   else
   p1_point.Caption:=Inttostr(Players[1].points);

   for i:=Players[PlayerId].caseBegin to Players[PlayerId].caseEnd do
   begin
   if PlayerId=0 then
   TLabel(FindComponent('l'+inttostr(i))).Font.Color:=rgb(255,0,0)
   else
   TLabel(FindComponent('l'+inttostr(i))).Font.Color:=rgb(0,255,0);
   end;

   end;
   result:=0;


end;
{Fonction qui permet de changer de joueur}
function ChangePlayer:integer;
begin
   sleep(500);
   Case CurrPlayer of
   0: begin
      CurrPlayer:=1;
      form1.s_player.Caption:='C''est à vous de jouer';
      form1.s_player.Font.Color:=rgb(0,255,0);
      end;
   1: begin
      CurrPlayer:=0;
      form1.s_player.Caption:='C''est à l''ordi de jouer';
      form1.s_player.Font.Color:=rgb(255,0,0);
      Computerplay;
      end;
   end;
   result:=0;

end;

{Fonction qui permet de savoir sur quelle case va se terminé un play}
function GetCasePlayEnd(num:integer):integer;
var
  iNum,CaseValue:integer;
begin

  CaseValue:=Cases[num];

  If num=12 then
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
  for i:=Players[0].caseBegin to Players[0].caseEnd do
  begin
    If Cases[i]=4 then
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
   For i:=Players[0].caseBegin to Players[0].caseEnd do
   begin
     GetCaseInfo(i,@tours,@rest);
     j:=0;
     for a:= i+1 to players[0].caseEnd do
     begin
     If (Cases[a]+tours+1)=4 then
     j:=j+1
     end;
     if j>=importance then
     begin
     Importance:=j;
     iNum:=i;
     end;
   end;
   if importance=0 then
   For i:=Players[0].caseBegin to Players[0].caseEnd do
   if Cases[i]>0 then
   begin
     iNum:=i;
     break;
   end;
   //showmessage(inttostr(iNum));
   Shortmsg('l''ordi joue la case'+inttostr(iNum),0);
   AffSelInfo(iNum,0);
   sleep(500);
   PlayCaseEx(iNum,0,true);


end;

{fonction qui permet de voir s'il reste 4 points}
function Check_PartEnd:integer;
var
  value,i:integer;
begin
  Value:=0;
  for i:=1 to 12  do
  begin
  value:=value+cases[i];
  end;
  If value=4 then
  begin
  Shortmsg('fin de la partie',0);
  sleep(2000) ;
  Players[1].caseBegin:=1;
  Players[1].caseEnd:=Players[1].points div 4;
  Players[1].points:=0;
  Players[0].caseBegin:=Players[1].caseEnd+1;
  Players[0].caseEnd:=12;
  Players[0].points:=0;
  InitGame(false);
  end
  else
  begin
    value:=0;
    for i:=Players[CurrPlayer].caseBegin to Players[CurrPlayer].caseEnd do
    begin
    value:=value+ cases[i];
    end;
    If value=0 then
    begin
    Shortmsg('vous n''avez aucun pion à jouer',1);
    sleep(500);
    ChangePlayer;
    end;
  end;

  
end;


procedure TForm1.im_selDblClick(Sender: TObject);
begin
  If (timercmd=2) and(CPU_busy) and (Currplayer=1) then
  begin
  timercmd:=-1;
  shortmsg('',0);
  form1.im_sel.Picture.LoadFromFile(GetAppDir+'res\sel.png');

  end
  else
  PlayCaseEx(CurrCase,1,true)
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 InitGame(true);
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
  GetCaseInfo(Cases[num],@tours,@rest);
  CurrCase:=num;
  AffSelInfo(num,CurrPlayer);
  if Showmsg then
  Shortmsg(Format('Trajet: %d tour(s) et %d cases',[tours,rest]),0);
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
  GetWarepoints(CurrCase,Currplayer,false);
  end;
  
end;

procedure TForm1.Im_caseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ssShift in Shift then
  begin
  GetWarepoints(CurrCase,Currplayer,false);
  end;
  
end;

procedure TForm1.About1Click(Sender: TObject);
const
  str='GhomeAfro 1.0'+#10#13+'contact:ghomeafro@yahoo.fr'+#10#13+#10#13
       +'(c)copyright 2008 Kikoné KiswendSida';
begin
  MessageBox(0,str ,'',0);
end;

procedure TCasePlayer.Execute;
begin
  PlayCase(num,PlayerId,CanChangePlayer);
end;
constructor TCasePlayer.Create(inum,iPlayerId:integer;iCanChangePlayer:boolean);
begin
  
  num:=inum;
  playerId:=iPlayerId;
  canChangePlayer:=icanChangePlayer;
  inherited Create(false);
end;

end.
