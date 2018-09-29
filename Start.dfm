object Form4: TForm4
  Left = 190
  Top = 210
  BorderStyle = bsNone
  Caption = 'Form4'
  ClientHeight = 97
  ClientWidth = 372
  Color = 16744703
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 97
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvSpace
    Color = 16744703
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 304
      Height = 13
      Caption = 'Voulez-vous Sauvez la partie avant de commencer une nouvelle'
    end
    object Button1: TButton
      Left = 8
      Top = 56
      Width = 108
      Height = 25
      Caption = 'Annuler'
      ModalResult = 2
      TabOrder = 0
    end
    object Button2: TButton
      Left = 128
      Top = 56
      Width = 108
      Height = 25
      Caption = 'Sauvegarder'
      ModalResult = 1
      TabOrder = 1
      OnClick = Button2Click
    end
    object begin_bt: TButton
      Left = 253
      Top = 56
      Width = 108
      Height = 25
      Caption = 'Commencer le jeu'
      Default = True
      ModalResult = 1
      TabOrder = 2
    end
    object StaticText1: TStaticText
      Left = 2
      Top = 2
      Width = 368
      Height = 17
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Caption = 'Nouveau Jeu'
      Color = clFuchsia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      Transparent = False
      OnMouseDown = Panel1MouseDown
    end
  end
end
