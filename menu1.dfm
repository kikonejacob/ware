object Form2: TForm2
  Left = 231
  Top = 151
  BorderStyle = bsSingle
  Caption = 'Menu'
  ClientHeight = 195
  ClientWidth = 214
  Color = 16764159
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 16
    Width = 73
    Height = 16
    Caption = 'Bienvenu !'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 48
    Top = 48
    Width = 129
    Height = 25
    Caption = 'Nouveau jeu'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 48
    Top = 80
    Width = 129
    Height = 25
    Caption = 'Charger une partie'
    TabOrder = 1
  end
  object Button3: TButton
    Left = 48
    Top = 112
    Width = 129
    Height = 25
    Caption = 'Enregistrer la partie'
    TabOrder = 2
  end
  object Button4: TButton
    Left = 48
    Top = 144
    Width = 129
    Height = 25
    Caption = 'Continuer le jeu'
    Enabled = False
    TabOrder = 3
  end
end
