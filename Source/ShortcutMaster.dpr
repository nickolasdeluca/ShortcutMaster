program ShortcutMaster;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FMain},
  Utils.Registry in '..\..\CommonLibs\Utils.Registry.pas',
  UShortcutManager in 'UShortcutManager.pas' {FShortcutManager};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.Title := 'Shortcut Master v1';
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFShortcutManager, FShortcutManager);
  Application.Run;
end.
