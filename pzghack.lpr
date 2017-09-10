program PzGHack;

{$MODE Delphi}

uses
  Forms, Interfaces,
  pgedmain in 'src/pgedmain.pas' {MainForm},
  DskUtil in 'src/Dskutil.pas',
  PGUnit in 'src/Pgunit.pas',
  About in 'src/About.pas' {AboutBox};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'PzGHack';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
