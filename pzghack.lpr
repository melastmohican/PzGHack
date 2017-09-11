program PzGHack;

{$MODE Delphi}

uses
  Forms, Interfaces,
  pgedmain in 'src/pgedmain.pas' {MainForm},
  DskUtil in 'src/dskutil.pas',
  PGUnit in 'src/pgunit.pas',
  About in 'src/about.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PzGHack';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
