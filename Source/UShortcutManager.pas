unit UShortcutManager;

interface

uses
  { Winapi }
  Winapi.Windows, Winapi.Messages,
  { System }
  System.SysUtils, System.Variants, System.Classes,
  { VCL }
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls,
  { Utils }
  Utils.Registry, Vcl.Buttons, Vcl.WinXPanels, Data.DB, Vcl.Grids, Vcl.DBGrids,
  XDBGrid, Datasnap.DBClient;

type
  TFShortcutManager = class(TForm)
    cpBackground: TCardPanel;
    cdNewShortcut: TCard;
    cdRemoveShortcut: TCard;
    lbShortcutName: TLabel;
    edShortcutName: TEdit;
    lbPath: TLabel;
    edPath: TEdit;
    btResetFields: TButton;
    btSaveShortcut: TButton;
    sbSelectFolder: TSpeedButton;
    sbSelectFile: TSpeedButton;
    xgAtalhos: TXDBGrid;
    pnButtons: TPanel;
    btRemover: TButton;
    CDSAtalhos: TClientDataSet;
    DSAtalhos: TDataSource;
    CDSAtalhosAtalho: TStringField;
    CDSAtalhosDiretorio: TStringField;
    procedure btResetFieldsClick(Sender: TObject);
    procedure btSaveShortcutClick(Sender: TObject);
    procedure sbSelectFolderClick(Sender: TObject);
    procedure sbSelectFileClick(Sender: TObject);
    procedure cpBackgroundCardChange(Sender: TObject; PrevCard,
      NextCard: TCard);
    procedure btRemoverClick(Sender: TObject);
  private
    { Private declarations }
    procedure clearFields;
    procedure loadShortcuts;
  public
    { Public declarations }
    procedure setActiveCard(Card: TCard);
  end;

var
  FShortcutManager: TFShortcutManager;
  GridDataset: TDataset;

implementation

{$R *.dfm}

uses UMain;

procedure TFShortcutManager.btRemoverClick(Sender: TObject);
begin
  DeleteValueFromRegistry(CurrentUser, FMain.RegistryKey, False, CDSAtalhosAtalho.AsString);
  CDSAtalhos.Delete;
  FMain.loadShortcuts(True);
end;

procedure TFShortcutManager.btResetFieldsClick(Sender: TObject);
begin
  clearFields;
end;

procedure TFShortcutManager.btSaveShortcutClick(Sender: TObject);
begin
  if String(edShortcutName.Text).IsEmpty or
     String(edPath.Text).IsEmpty then
    Exit;

  WriteToRegistry(CurrentUser,
                  FMain.RegistryKey,
                  True,
                  edShortcutName.Text,
                  IncludeTrailingPathDelimiter(edPath.Text));
  FMain.LoadShortcuts(True);
  clearFields;
end;

procedure TFShortcutManager.clearFields;
begin
  edShortcutName.Clear;
  edPath.Clear;
end;

procedure TFShortcutManager.cpBackgroundCardChange(Sender: TObject; PrevCard,
  NextCard: TCard);
begin
  if NextCard = cdRemoveShortcut then
    loadShortcuts;
end;

procedure TFShortcutManager.loadShortcuts;
var
  ShortcutList: TKeyListValues;
  i: Integer;
  procedure _Add(_Shortcut: String; _Diretorio: String);
  begin
    CDSAtalhos.Open;
    CDSAtalhos.Append;
    CDSAtalhosAtalho.AsString := _Shortcut;
    CDSAtalhosDiretorio.AsString := _Diretorio;
    CDSAtalhos.Post;
  end;
begin
  try
    ShortcutList := ReadFromRegistry(CurrentUser, FMain.RegistryKey);
  finally
    if ShortcutList.Count >= 0 then
    begin
      for i := 0 to ShortcutList.Count -1 do
      begin
        _Add(ShortcutList.Names[i], ShortcutList.Values[i]);
      end;
    end;
  end;
end;

procedure TFShortcutManager.sbSelectFileClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Application);
  Dialog.OkButtonLabel := 'Selecionar';
  Dialog.Options := Dialog.Options + [fdoFileMustExist, fdoDontAddToRecent];
  Dialog.Title := Application.Title;

  if Dialog.Execute then
    edPath.Text := Dialog.FileName;

  FreeAndNil(Dialog);
end;

procedure TFShortcutManager.sbSelectFolderClick(Sender: TObject);
var
  Dialog: TFileOpenDialog;
begin
  Dialog := TFileOpenDialog.Create(Application);
  Dialog.OkButtonLabel := 'Selecionar';
  Dialog.Options := Dialog.Options + [fdoPickFolders, fdoPathMustExist, fdoDontAddToRecent];
  Dialog.Title := Application.Title;

  if Dialog.Execute then
    edPath.Text := Dialog.FileName;

  FreeAndNil(Dialog);
end;

procedure TFShortcutManager.setActiveCard(Card: TCard);
begin
  cpBackground.ActiveCard := Card;

  if Card = cdNewShortcut then
  begin
    FShortcutManager.Height := 125;
    FShortcutManager.Width := 700;
  end
  else
  if Card = cdRemoveShortcut then
  begin
    FShortcutManager.Height := 275;
    FShortcutManager.Width := 700;
  end;
end;

end.
