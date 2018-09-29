unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,main;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    Label2: TLabel;
    Speed1: TComboBox;
    Label3: TLabel;
    Difficulty: TComboBox;
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function Aff_Option:integer;
var
  Form5: TForm5;

implementation

{$R *.dfm}

function Aff_Option:integer;
begin
 
 with form5 do
 begin
 edit1.Text:=gw.Players[1].Name;
 Fill_Config;
 Speed1.ItemIndex:=Config.ReadInteger('Info','Speed',1);
 Difficulty.ItemIndex:=Config.ReadInteger('Info','Difficulty',0);
 Result:=Form5.ShowModal;
 If Result=mrOk then
 gw.Players[1].Name:=edit1.Text;
 refreshPlayerInfo(1);
 fill_config;
 config.WriteString('Info','UserName',gw.Players[1].Name);
 Config.WriteInteger('Info','Speed',Speed1.ItemIndex);
 Config.WriteInteger('Info','Difficulty',Difficulty.ItemIndex);
 gw.Difficulty:=Difficulty.ItemIndex;
 end;
end;

procedure TForm5.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If ssleft In Shift Then
      Begin
         //Le mouvement de la fenêtre n'est autorisé que si 1 => y <= 24
            ReleaseCapture;
            Perform(WM_SYSCOMMAND, $F012, 0);
        
      End ;


end;

end.
