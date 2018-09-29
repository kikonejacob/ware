unit Partend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,main, pngimage, ExtCtrls;

type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    p0_title: TLabel;
    p1_title: TLabel;
    p0_points: TLabel;
    p0_cases: TLabel;
    p1_points: TLabel;
    p1_cases: TLabel;
    whowin: TLabel;
    Bevel1: TBevel;
    P0_winparts: TLabel;
    P1_winparts: TLabel;
    P_count: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function AffEndPart(gw:PGameInfo):integer;

var
  Form3: TForm3;

implementation

{$R *.dfm}

function AffEndPart(gw:PGameInfo):integer;
var i,count0,count1:integer;
    Winner:integer;
    P0W,P1W:integer;
begin
  with form3 do
  begin
  p0_title.caption:=gw.Players[0].Name;
  p0_points.caption:= format('Points: %d',[gw.Players[0].points]);
  p0_cases.caption:= format('Cases obtenus: %d',[gw.Players[0].points div 4]);

   if gw.Players[0].points=gw.Players[1].points   then
   whowin.Caption:='Match nul !'
   else
   if gw.Players[0].points>gw.Players[1].points  then
    whowin.Caption:='Vous perdez cette partie'
   else
   begin
    whowin.Caption:='*** VOUS REMPORTEZ LA PARTIE  !!! ***';
    Winner:=1;
   end;


  p1_title.caption:=gw.Players[1].Name;
  p1_points.caption:= format('Points: %d',[gw.Players[1].points]);
  p1_cases.caption:= format('Cases obtenus: %d',[gw.Players[1].points div 4]);

  count0:=0;
  count1:=0;
  for i:=gw.players[0].caseBegin to gw.players[0].caseEnd do
  count0:=count0+gw.cases[i];
  for i:=gw.players[1].caseBegin to gw.players[1].caseEnd do
  count1:=count1+gw.cases[i];
  P0W:=gw.players[0].WinParts;
  P1W:=gw.players[1].WinParts;

  if winner=1 then  inc(P0W) else  inc(P1W);
  P_count.Caption:=inttostr(gw.PartCount+1)+' partie(s) jouée(s) au total' ;
  P0_winparts.Caption:=inttostr(P0W)+' partie(s) remportée(s)';
  P1_winparts.Caption:=inttostr(P1W)+' partie(s) remportée(s)';

  if (count0=0) or (count1=0)  then
  begin
     Caption:='Fin du jeu';
     If P0W<P1W then
     whowin.Caption:='_*_*_VOUS_ÊTES_UN_CHAMPION_DU_JEU_*_*_ '
     else
     whowin.Caption:='_*_*_VOUS_PERDEZ_LE_JEU_*_*_ ' 


  end
  else
     form3.Caption:='Find de la partie No '+inttostr(gw.PartCount+1);

  

  end;
  result:=form3.ShowModal;

end;

end.
