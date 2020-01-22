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
  XDBGrid;

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
    XDBGrid1: TXDBGrid;
    procedure btResetFieldsClick(Sender: TObject);
    procedure btSaveShortcutClick(Sender: TObject);
    procedure sbSelectFolderClick(Sender: TObject);
    procedure sbSelectFileClick(Sender: TObject);
  private
    { Private declarations }
    procedure clearFields;
  public
    { Public declarations }
    procedure setActiveCard(Card: TCard);
  end;

var
  FShortcutManager: TFShortcutManager;

implementation

{$R *.dfm}

uses UMain;

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
                  edPath.Text);
  FMain.LoadShortcuts(True);
  clearFields;
end;

procedure TFShortcutManager.clearFields;
begin
  edShortcutName.Clear;
  edPath.Clear;
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
    FShortcutManager.Height := 350;
    FShortcutManager.Width := 700;
  end;
end;

end.
