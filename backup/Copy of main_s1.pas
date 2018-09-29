unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls,strutils;

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
    procedure im_selDblClick(Sender: TObject);
    procedure Im_CaseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

var
  Form1: TForm1;
  cases:array[1..12] of integer;
  CasesFirst:array[1..12] of boolean;
  Players:array [0..2] of PPlayer;
  CurrPlayer:integer;
  CurrCase:integer;


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
procedure InitGame;
var
  i:integer;
begin
  {cases init}
  for i:=1 to 12 do
  begin
  initcase(i);
  RefreshCase(i);
  end;
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
  RefreshPlayerInfo(0);
  RefreshPlayerInfo(1);
  CurrPlayer:=1;
end;
{fonction qui permet de tirer les points d'une case Waré}
function GetWarePoints(num,PlayerId:integer):integer ;
begin
  If (casesFirst[num]=false)  and (cases[num]=4)  then
  if (num>=Players[playerId].caseBegin) and (num<=Players[playerId].caseEnd) then
  begin
  Players[playerId].points:=Players[playerId].points+4;
  cases[num]:=0;
  end
  else
  Showmessage('Ceci n''est pas votre case');
  result:=0;
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

{fonction qui permet de jouer un pion}
function PlayCase(num:integer;PlayerId:integer):integer;
var
  tours:integer;
  CaseValue,rest:integer;
  i,a:integer;
begin
  result:=0;
 { if IsPlayerCase(num,PlayerId)=false then
  begin
  Shortmsg('Ceci n''est pas votre case',1);
  result:=1;
  exit;
  end; }
  caseValue:=cases[num];
  cases[num]:=0;
  RefreshCase(num);
  tours:= caseValue div 12;
  for i:=1 to tours do
  begin
     for a:=num+1 to (12-num) do
     cases[a]:=cases[a]+1;
     for a:=1 to num do
     cases[a]:=cases[a]+1;
  end;
  rest:=CaseValue-(tours*12);
  if (12-rest)<0 then
  begin
     for i:=num+1 to 12 do
     begin
     cases[i]:=cases[i]+1;
     RefreshCase(i);
     end;
     rest:=rest-12;
  end;

  for i:=num+1 to (num+rest) do
  begin
  cases[i]:=cases[i]+1;
  RefreshCase(i);
  end;
  
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
begin
   with Form1 do
   begin
   If PlayerId=0 then
   p0_point.Caption:=Inttostr(Players[0].points)
   else
   p1_point.Caption:=Inttostr(Players[1].points);
   end;
   result:=0;

end;
{Fonction qui permet de changer de joueur}
function ChangePlayer:integer;
begin
   Case CurrPlayer of
   0: begin
      CurrPlayer:=1;
      Shortmsg('C''est à vous de jouer',0)
      end;
   1: begin
       CurrPlayer:=0;
       Shortmsg('C''est à l''ordi de jouer',0)
       end;
   end;
   result:=0;
end;



procedure TForm1.im_selDblClick(Sender: TObject);
begin
  PlayCase(CurrCase,CurrPlayer)
end;

procedure TForm1.Im_CaseClick(Sender: TObject);
var
  num:integer;
  str:string;
  tours,rest:integer;
begin
  //showmessage('gghg');
  str:=RightStr(Timage(sender).Name,2);
  //showmessage(str);
  If pos(str[1],'0123456789')>0 then
  num:=StrToint(str)
  else
  num:=StrToInt(str[2]);
  //showmessage(inttostr(num));
  CurrCase:=num;
  im_sel.Left:=TControl(Sender).Left;
  im_sel.Top:=TControl(Sender).top;
  im_sel.Visible:=true;
  GetCaseInfo(Cases[num],@tours,@rest);
  Shortmsg(Format('Trajet: %d tour(s) et %d cases',[tours,rest]),0);

end;



procedure TForm1.Button1Click(Sender: TObject);
begin
 InitGame;
end;

end.
