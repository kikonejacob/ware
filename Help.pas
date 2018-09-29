unit Help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls,main;

type
  TForm6 = class(TForm)
    Panel1: TPanel;
    StaticText1: TStaticText;
    RichEdit1: TRichEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
function ShowQuickhelp:integer;
var
  Form6: TForm6;

implementation

{$R *.dfm}

function ShowQuickhelp:integer;
begin
  form6.Richedit1.Lines.LoadFromFile(GetAppDir+'help.rtf');
  form6.Show;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  Form6.Close;
end;

procedure TForm6.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
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
