unit UMain;

interface

uses
  { Winapi }
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  { System }
  System.SysUtils, System.Variants, System.Classes, System.StrUtils,
  { VCL }
  Vcl.Forms, Vcl.Menus, Vcl.ExtCtrls, Vcl.Controls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage;

type
  TFMain = class(TForm)
    btClose: TButton;
    lbDisclaimer: TLabel;
    imLogo: TImage;
    lbGithubLink: TLabel;
    lbAppName: TLabel;
    btExportSettings: TButton;
    btImportSettings: TButton;
    procedure btCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbGithubLinkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btExportSettingsClick(Sender: TObject);
    procedure btImportSettingsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;
  AppDir: String;

implementation

{$R *.dfm}

uses Utils.Registry, UShortcutManager, UDMAtalhos;

procedure TFMain.btCloseClick(Sender: TObject);
begin
  FMain.Hide;
end;

procedure TFMain.btExportSettingsClick(Sender: TObject);
begin
  DMAtalhos.ExportShortcut;
end;

procedure TFMain.btImportSettingsClick(Sender: TObject);
begin
  DMatalhos.ImportShortcut;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DMAtalhos.LoadShortcut;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  FMain.BringToFront;
end;

procedure TFMain.lbGithubLinkClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar('http://'+lbGithubLink.Caption), nil, nil, 0);
end;

Initialization
  AppDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

end.
