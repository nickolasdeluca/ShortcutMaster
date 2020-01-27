object FShortcutManager: TFShortcutManager
  Left = 0
  Top = 0
  Caption = 'Gerenciador de Atalhos'
  ClientHeight = 236
  ClientWidth = 684
  Color = 9915136
  Constraints.MaxHeight = 275
  Constraints.MaxWidth = 700
  Constraints.MinHeight = 125
  Constraints.MinWidth = 700
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cpBackground: TCardPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 236
    Align = alClient
    ActiveCard = cdRemoveShortcut
    Caption = 'cpBackground'
    TabOrder = 0
    OnCardChange = cpBackgroundCardChange
    object cdNewShortcut: TCard
      Left = 1
      Top = 1
      Width = 682
      Height = 234
      Caption = 'cdNewShortcut'
      CardIndex = 0
      TabOrder = 0
      object lbShortcutName: TLabel
        Left = 8
        Top = 11
        Width = 94
        Height = 13
        Caption = 'Nome do Shortcut'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lbPath: TLabel
        Left = 56
        Top = 33
        Width = 46
        Height = 13
        Caption = 'Diret'#243'rio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object sbSelectFolder: TSpeedButton
        Left = 584
        Top = 30
        Width = 21
        Height = 21
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF457B98447A96447A96447A96447A96447A96447A9644
          7A96447A96447A96447A96447A96447A96447A96447A96FF00FF487F9C78BEE2
          85CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CE
          F585CEF54B82A0FF00FF48809C70B3D685CEF585CEF585CEF585CEF585CEF585
          CEF585CEF585CEF585CEF585CEF585CEF585CEF5528BA9FF00FF467C9968A9CA
          85CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CE
          F585CEF55A97B6FF00FF447A96609DBE85CEF585CEF585CEF585CEF585CEF585
          CEF585CEF585CEF585CEF585CEF585CEF585CEF563A3C4FF00FF447A965692B1
          85CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CEF585CE
          F585CEF56BACCFFF00FF447A964E87A685CEF585CEF585CEF585CEF585CEF585
          CEF585CEF585CEF585CEF585CEF585CEF585CEF572B6DAFF00FF447A96447A96
          447A96447A96447A96447A964B83A16AADCF84CCF385CEF585CEF585CEF585CE
          F585CEF57AC0E5FF00FF447A9665B0DB65B0DB65B0DB65B0DB65B0DB5EA4CC4F
          8BAB447A96447A96447A96447A96447A96447A96447A96FF00FF447A9665B0DB
          65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0
          DB65B0DB447A96FF00FF447A9665B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65
          B0DB65B0DB65B0DB65B0DB65B0DB65B0DB65B0DB447A96FF00FF447A9665B0DB
          65B0DB65B0DB65B0DB62AAD44F7CA2447A96447A96447A96447A96447A96447A
          96447A96447A96FF00FF447A9665B0DB65B0DB65B0DB62AAD44F7CA2FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF447A96447A96
          447A96447A96447A96FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbSelectFolderClick
      end
      object sbSelectFile: TSpeedButton
        Left = 605
        Top = 30
        Width = 21
        Height = 21
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF898675779B5F8A8575FF00
          FFFF00FFFF00FFFF00FFFF00FF9C8B789C8B789C8B789C8B789C8B789C8B789C
          8B78769C5E769C5E769C5E769C5E769C5EFF00FFFF00FFFF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFB9CDAD769C5E769C5E769C5EFFFFFF769C5E769C
          5E769C5EFF00FFFF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFF88A97376
          9C5E769C5E769C5EFFFFFF769C5E769C5E769C5E898675FF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFF799E62769C5EFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FF769C5E7A9862FF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFF88A97376
          9C5E769C5E769C5EFFFFFF769C5E769C5E769C5E898675FF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFB9CDAD769C5E769C5E769C5EFFFFFF769C5E769C
          5E769C5EFF00FFFF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFF9FBF893
          B180769C5E769C5E769C5E769C5E769C5EFF00FFFF00FFFF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF9BBCEAF89AA757FA3698AAA759C8B
          78FF00FFFF00FFFF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78FF00FFFF00FFFF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B
          78FF00FFFF00FFFF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF9C8B789C8B789C8B789C8B789C8B78FF00FFFF00FFFF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78FFFFFFF9F8F7AD9E8FFF00
          FFFF00FFFF00FFFF00FFFF00FF9C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFF9C8B78F9F8F7AD9F8FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9C8B78
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78AC9D8EFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FF9C8B789C8B789C8B789C8B789C8B789C8B789C
          8B789C8B78FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        OnClick = sbSelectFileClick
      end
      object edShortcutName: TEdit
        Left = 108
        Top = 8
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object edPath: TEdit
        Left = 108
        Top = 30
        Width = 475
        Height = 21
        TabOrder = 1
      end
      object btResetFields: TButton
        Left = 107
        Top = 51
        Width = 122
        Height = 25
        Caption = 'Novo Shortcut'
        TabOrder = 2
        TabStop = False
        OnClick = btResetFieldsClick
      end
      object btSaveShortcut: TButton
        Left = 228
        Top = 51
        Width = 122
        Height = 25
        Caption = 'Salvar Shortcut'
        TabOrder = 3
        TabStop = False
        OnClick = btSaveShortcutClick
      end
    end
    object cdRemoveShortcut: TCard
      Left = 1
      Top = 1
      Width = 682
      Height = 234
      Caption = 'cdRemoveShortcut'
      CardIndex = 1
      TabOrder = 1
      object xgAtalhos: TXDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 672
        Height = 180
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        DataSource = DMAtalhos.DSAtalhos
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Atalho'
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Diretorio'
            Title.Caption = 'Diret'#243'rio'
            Width = 500
            Visible = True
          end>
      end
      object pnButtons: TPanel
        AlignWithMargins = True
        Left = 5
        Top = 190
        Width = 672
        Height = 34
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnButtons'
        ShowCaption = False
        TabOrder = 1
        object btRemover: TButton
          AlignWithMargins = True
          Left = 275
          Top = 0
          Width = 122
          Height = 34
          Margins.Left = 275
          Margins.Top = 0
          Margins.Right = 275
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Remover Atalho'
          TabOrder = 0
          OnClick = btRemoverClick
        end
      end
    end
  end
end
