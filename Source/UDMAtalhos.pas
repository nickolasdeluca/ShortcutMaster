unit UDMAtalhos;

interface

uses
  Winapi.Windows, Winapi.ShellAPI,
  System.SysUtils, System.Classes, System.StrUtils,
  Data.DB, Datasnap.DBClient,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.Forms, Vcl.Dialogs;

type
  TDMAtalhos = class(TDataModule)
    CDSAtalhos: TClientDataSet;
    CDSAtalhosAtalho: TStringField;
    CDSAtalhosDiretorio: TStringField;
    DSAtalhos: TDataSource;
    tiTrayManager: TTrayIcon;
    popShortcuts: TPopupMenu;
    N2: TMenuItem;
    miCreateShortcut: TMenuItem;
    btRemoveShortcut: TMenuItem;
    N1: TMenuItem;
    miCloseApplication: TMenuItem;
    miOpcoes: TMenuItem;
    procedure CDSAtalhosAfterPost(DataSet: TDataSet);
    procedure CDSAtalhosBeforeDelete(DataSet: TDataSet);
    procedure miClick(Sender: TObject);
    procedure miCreateShortcutClick(Sender: TObject);
    procedure btRemoveShortcutClick(Sender: TObject);
    procedure miCloseApplicationClick(Sender: TObject);
    procedure tiTrayManagerDblClick(Sender: TObject);
    procedure CDSAtalhosAfterDelete(DataSet: TDataSet);
  private
    { Private declarations }
    procedure AddAtalho(_Shortcut, _Diretorio: String);
  public
    { Public declarations }
    procedure LoadShortcut;
    procedure ReloadShortcut;
    procedure SaveShortcut(Shortcut: String; Directory: String);
    procedure DeleteShortcut(Shortcut: String);
    procedure ExportShortcut;
    procedure ImportShortcut;
  end;

  TFileOperation = (Edit, Explore, Find, Open, Print, NULL, RunAs);
  const
    cFileOperation : array[TFileOperation] of string = ('edit', 'explore', 'find', 'open', 'print', 'NULL', 'runas');

const
  RegistryKey = 'SOFTWARE\ShortcutMaster\List';

var
  DMAtalhos: TDMAtalhos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Utils.Registry, UMain, UShortcutManager;

{$R *.dfm}

{ TDMAtalhos }

procedure TDMAtalhos.btRemoveShortcutClick(Sender: TObject);
begin
  Application.CreateForm(TFShortcutManager, FShortcutManager);
  FShortcutManager.setActiveCard(FShortcutManager.cdRemoveShortcut);
  FShortcutManager.Show;
end;

procedure TDMAtalhos.CDSAtalhosAfterDelete(DataSet: TDataSet);
begin
  ReloadShortcut;
end;

procedure TDMAtalhos.CDSAtalhosAfterPost(DataSet: TDataSet);
begin
  if not(RegistryValueExists(CurrentUser, RegistryKey, False, CDSAtalhosAtalho.AsString)) then
    WriteToRegistry(CurrentUser, RegistryKey, True, CDSAtalhosAtalho.AsString, CDSAtalhosDiretorio.AsString);
end;

procedure TDMAtalhos.CDSAtalhosBeforeDelete(DataSet: TDataSet);
begin
  DeleteValueFromRegistry(CurrentUser, RegistryKey, False, CDSAtalhosAtalho.AsString);
end;

procedure TDMAtalhos.DeleteShortcut(Shortcut: String);
begin
  if Assigned(CDSAtalhos) then
    if CDSAtalhos.Locate('Atalho', Shortcut, []) then
      CDSAtalhos.Delete;
end;

procedure TDMAtalhos.ExportShortcut;
var
  Dialog: TFileOpenDialog;
begin
  if CDSAtalhos.IsEmpty then
    Exit;

  Dialog := TFileOpenDialog.Create(Application);
  Dialog.OkButtonLabel := 'Selecionar';
  Dialog.Options := Dialog.Options + [fdoDontAddToRecent];
  with Dialog.FileTypes.Add do
  begin
    FileMask := '*.SMconfigs';
    DisplayName := 'Arquivo de configuração do Shortcut Master v1';
  end;
  Dialog.Title := Application.Title;

  if Dialog.Execute then
    CDSAtalhos.SaveToFile(IfThen(ExtractFileExt(Dialog.FileName) = '', Dialog.FileName+'.SMConfigs'), dfXML);

  FreeAndNil(Dialog);
end;

procedure TDMAtalhos.ImportShortcut;
var
  Dialog: TFileOpenDialog;
begin
  if not(CDSAtalhos.IsEmpty) then
    CDSAtalhos.EmptyDataSet;

  Dialog := TFileOpenDialog.Create(Application);
  Dialog.OkButtonLabel := 'Selecionar';
  Dialog.Options := Dialog.Options + [fdoFileMustExist, fdoDontAddToRecent];
  with Dialog.FileTypes.Add do
  begin
    FileMask := '*.SMconfigs';
    DisplayName := 'Arquivo de configuração do Shortcut Master v1';
  end;
  Dialog.Title := Application.Title;

  if Dialog.Execute then
    CDSAtalhos.LoadFromFile(Dialog.FileName);

  CDSAtalhos.First;

  while not(CDSAtalhos.Eof) do
  begin
    CDSAtalhos.Edit;
    CDSAtalhos.Post;

    CDSAtalhos.Next;
  end;

  FreeAndNil(Dialog);
  ReloadShortcut;
end;

procedure TDMAtalhos.miClick(Sender: TObject);
var
  MenuHint: String;
begin
  MenuHint := TMenuItem(Sender).Hint;
  if MenuHint.IsEmpty then
    Exit;

  if DirectoryExists(MenuHint) then
    ShellExecute(0, PWideChar(cFileOperation[Explore]), PWideChar(MenuHint), '', nil, SW_SHOWNORMAL)
  else
  if FileExists(MenuHint) then
    ShellExecute(0, PWideChar(cFileOperation[Open]), PWideChar(MenuHint), '', PWideChar(ExtractFileDir(MenuHint)), SW_SHOW);
end;

procedure TDMAtalhos.miCloseApplicationClick(Sender: TObject);
begin
  FMain.Close;
end;

procedure TDMAtalhos.miCreateShortcutClick(Sender: TObject);
begin
  Application.CreateForm(TFShortcutManager, FShortcutManager);
  FShortcutManager.setActiveCard(FShortcutManager.cdNewShortcut);
  FShortcutManager.Show;
end;

procedure TDMAtalhos.ReloadShortcut;
var
  I: Integer;
begin
  CDSAtalhos.EmptyDataSet;

  for I := popShortcuts.Items.Count-1 downto 0 do
  begin
    if popShortcuts.Items[i].Tag = 1 then
      popShortcuts.Items.Delete(i);
  end;

  LoadShortcut;
end;

procedure TDMAtalhos.AddAtalho(_Shortcut: String; _Diretorio: String);
var
  popItem: TMenuItem;
begin
  CDSAtalhos.Open;
  CDSAtalhos.Append;
  CDSAtalhosAtalho.AsString := _Shortcut;
  CDSAtalhosDiretorio.AsString := _Diretorio;
  CDSAtalhos.Post;

  popItem := TMenuItem.Create(popShortcuts);
  popItem.Caption := _Shortcut;
  popItem.Hint := _Diretorio;
  popItem.Tag := 1;
  popItem.OnClick := miClick;

  popShortcuts.Items.Add(popItem);
end;

procedure TDMAtalhos.LoadShortcut;
var
  ShortcutList: TKeyListValues;
  i: Integer;
begin
  try
    ShortcutList := ReadFromRegistry(CurrentUser, RegistryKey);
  finally
    if ShortcutList.Count >= 0 then
    begin
      for i := 0 to ShortcutList.Count-1 do
      begin
        AddAtalho(ShortcutList.Names[i], ShortcutList.Values[i]);
      end;
    end;
  end;
end;

procedure TDMAtalhos.SaveShortcut(Shortcut, Directory: String);
begin
  if Assigned(CDSAtalhos) then
    AddAtalho(Shortcut, Directory);
end;

procedure TDMAtalhos.tiTrayManagerDblClick(Sender: TObject);
begin
  FMain.Show;
end;

end.
