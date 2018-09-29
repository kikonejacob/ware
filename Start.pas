unit Start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    begin_bt: TButton;
    Label1: TLabel;
    StaticText1: TStaticText;
    procedure Button2Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function StartMenu(msg:string;EnableSave,EnableCancel:boolean):integer;


var
  Form4: TForm4;

implementation

uses main;

{$R *.dfm}
function StartMenu(msg:string;EnableSave,EnableCancel:boolean):integer;
begin
  with form4 do
  begin
  Label1.Caption:=msg;
  button2.Visible:=EnableSave;
  button1.Visible:=EnableCancel;
  result:=ShowModal;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form1.Enregistrerlapartie1.Click;
end;

procedure TForm4.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
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
