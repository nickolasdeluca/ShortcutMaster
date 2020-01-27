program ShortcutMaster;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {FMain},
  UShortcutManager in 'UShortcutManager.pas' {FShortcutManager},
  UDMAtalhos in 'UDMAtalhos.pas' {DMAtalhos: TDataModule},
  Utils.Registry in '..\..\CommonLibs\Utils.Registry.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm := False;
  Application.Title := 'Shortcut Master v1';
  Application.CreateForm(TDMAtalhos, DMAtalhos);
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
