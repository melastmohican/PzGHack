program PzGHack;

uses
  Forms,
  pgedmain in 'SRC\pgedmain.pas' {MainForm},
  DskUtil in 'SRC\Dskutil.pas',
  PGUnit in 'SRC\Pgunit.pas',
  About in 'SRC\About.pas' {AboutBox};

{$R *.RES}
{$R VER.RES}

begin
  Application.Initialize;
  Application.Title := 'PzGHack';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
