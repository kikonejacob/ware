program ghware;

uses
  Forms,
  main in 'main.pas' {Form1},
  menu1 in 'menu1.pas' {Form2},
  Partend in 'Partend.pas' {Form3},
  Start in 'Start.pas' {Form4},
  CpuGame in 'CpuGame.pas',
  options in 'options.pas' {Form5},
  Help in 'Help.pas' {Form6},
  DLG_SESSION in 'DLG_SESSION.pas' {Form7},
  online in 'online.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GhomeAfro';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
