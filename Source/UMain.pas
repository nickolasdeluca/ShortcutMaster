unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Forms, Vcl.Menus, Vcl.ExtCtrls, Vcl.Controls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TFMain = class(TForm)
    btFechar: TButton;
    lbDisclaimer: TLabel;
    imLogo: TImage;
    tiTrayManager: TTrayIcon;
    popShortcuts: TPopupMenu;
    N1: TMenuItem;
    miCloseApplication: TMenuItem;
    lbGithubLink: TLabel;
    lbAppName: TLabel;
    miCreateShortcut: TMenuItem;
    N2: TMenuItem;
    btRemoveShortcut: TMenuItem;
    procedure btFecharClick(Sender: TObject);
    procedure tiTrayManagerDblClick(Sender: TObject);
    procedure miCloseApplicationClick(Sender: TObject);
    procedure miClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbGithubLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miCreateShortcutClick(Sender: TObject);
    procedure btRemoveShortcutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure loadShortcuts(Reload: Boolean);
    const RegistryKey = 'SOFTWARE\ShortcutMaster\List';
  end;

  TFileOperation = (Edit, Explore, Find, Open, Print, NULL, RunAs);
  const
    cFileOperation : array[TFileOperation] of string = ('edit', 'explore', 'find', 'open', 'print', 'NULL', 'runas');

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses Utils.Registry, UShortcutManager;

procedure TFMain.btFecharClick(Sender: TObject);
begin
  FMain.Hide;
end;

procedure TFMain.btRemoveShortcutClick(Sender: TObject);
begin
  Application.CreateForm(TFShortcutManager, FShortcutManager);
  FShortcutManager.setActiveCard(FShortcutManager.cdRemoveShortcut);
  FShortcutManager.Show;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  LoadShortcuts(False);
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  FMain.BringToFront;
end;

procedure TFMain.lbGithubLinkClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar('http://'+lbGithubLink.Caption), nil, nil, 0);
end;

procedure TFMain.loadShortcuts(Reload: Boolean);
var
  i:Integer;
  ShortcutList: TKeyListValues;
  procedure _Add(_Caption: String; _Hint: String);
  var
    popItem: TMenuItem;
  begin
    popItem := TMenuItem.Create(popShortcuts);
    popItem.Caption := _Caption;
    popItem.Hint := _Hint;
    popItem.Tag := 1;
    popItem.OnClick := miClick;

    popShortcuts.Items.Insert(0, popItem);
  end;
begin
  if Reload then
  begin
    for i := popShortcuts.Items.Count-1 downto 0 do
    begin
      if popShortcuts.Items[i].Tag = 1 then
        popShortcuts.Items.Delete(i);
    end;
  end;

  try
    ShortcutList := ReadFromRegistry(CurrentUser, RegistryKey);
  finally
    if ShortcutList.Count >= 0 then
    begin
      for i := ShortcutList.Count-1 downto 0 do
      begin
        _Add(ShortcutList.Names[i], ShortcutList.Values[i]);
      end;
    end;
  end;

end;

procedure TFMain.miClick(Sender: TObject);
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

procedure TFMain.miCloseApplicationClick(Sender: TObject);
begin
  FMain.Close;
end;

procedure TFMain.miCreateShortcutClick(Sender: TObject);
begin
  Application.CreateForm(TFShortcutManager, FShortcutManager);
  FShortcutManager.setActiveCard(FShortcutManager.cdNewShortcut);
  FShortcutManager.Show;
end;

procedure TFMain.tiTrayManagerDblClick(Sender: TObject);
begin
  FMain.Show;
end;

end.
