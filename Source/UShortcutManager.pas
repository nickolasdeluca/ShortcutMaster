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
  public
    { Public declarations }
    procedure setActiveCard(Card: TCard);
  end;

var
  FShortcutManager: TFShortcutManager;
  GridDataset: TDataset;

implementation

{$R *.dfm}

uses UMain, UDMAtalhos;

procedure TFShortcutManager.btRemoverClick(Sender: TObject);
begin
  DMAtalhos.DeleteShortcut(DMAtalhos.CDSAtalhosAtalho.AsString);
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

  DMAtalhos.SaveShortcut(edShortcutName.Text, edPath.Text);
  DMAtalhos.ReloadShortcut;
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
    DMAtalhos.ReloadShortcut;
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
    edPath.Text := IncludeTrailingPathDelimiter(Dialog.FileName);

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
