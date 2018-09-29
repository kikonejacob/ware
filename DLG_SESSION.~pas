unit DLG_SESSION;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,main,mysql, ExtCtrls;


function aff_users():integer;
type
  TForm7 = class(TForm)
    PageCtrl: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    email: TEdit;
    psw: TEdit;
    Button1: TButton;
    TabSheet2: TTabSheet;
    ListBox1: TListBox;
    Button2: TButton;
    msg_label: TLabel;
    Bevel1: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  sql:string;
  res:PMYSQL_RES;
  data:PMYSQL_ROW;

const
  id=0;
  pseudo=1;
  nom=3;
  prenom=4;
  mail=2;
begin
  //mydb.Query.PrepareTask();
   //new(res);
  // new(data);

  sql:='SELECT * FROM userlist WHERE email="'+ email.Text+'" AND password="'+psw.Text+'"' ;
  //showmessage(sql);
  res:=requete(sql);
  data:=mysql_fetch_row(res);
  if data<>nil then
  begin
  gw.Players[1].Id:=strtoint(data[id]);
  gw.Players[1].Name:=data[pseudo];
  gw.Players[1].automatic:=false;
  //showmessage( data[pseudo]);
  mysql_free_result(res);
  TabSheet1.TabVisible:=false;
  tabSheet2.TabVisible:=true;
  pagectrl.ActivePageIndex:=1;

  end
  else
  begin
    msg_label.caption:='Email ou mot de passe invalid';
  end;

  aff_users();
  form1.live.Enabled:=true;


end;


function aff_users():integer;
var
  sql:string;
  res:PMYSQL_RES;
  data:PMYSQL_ROW;
  player:Pplayer;

const
  pseudo=0;
  id=1;
  timestamp=2;
  win_parts=3;
var
  i:integer;
  
begin
  //mydb.Query.PrepareTask();
   //new(res);
  // new(data);

  sql:=    'SELECT userlist.pseudo,userlist.id,ware.timestamp,ware.win_parts  FROM userlist,ware ' ;
  sql:=sql+' WHERE userlist.id=pseudoID';
  //showmessage(sql);
  res:=requete(sql);
   //  showmessage(inttostr(res.row_count-1 ));
  if res<>nil then
  begin       
  for i:=0 to res.row_count-1   do
  begin
     data:=mysql_fetch_row(res);
     new(player);
     player.points:=0;
     player.Id:=strtoint(data[id]);
     player.Name:=data[pseudo];
     player.automatic:=false;
     player.WinParts:=strtoint(data[id]);;
     
     form7.ListBox1.Items.AddObject(data[pseudo],Tobject(player));
  end;

  end;

end;


procedure TForm7.Button2Click(Sender: TObject);
var
 playerInfo:Pplayer;
 cmd:pcmd;
begin
  new(playerInfo);
  playerInfo^:= PPlayer( form7.ListBox1.Items.Objects[form7.ListBox1.ItemIndex])^;
  {new(cmd);
  cmd.Cmd:= LIVE_INVITATION;
  startGame(true);
  cmd.intarg:=gw.CurrPlayer;
  send_cmd(cmd, playerInfo.Id) }
  envoyer_demande(playerInfo.Id);
  form7.Close;
end;

end.
