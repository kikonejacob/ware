object Form5: TForm5
  Left = 189
  Top = 132
  BorderStyle = bsNone
  Caption = 'Option'
  ClientHeight = 177
  ClientWidth = 322
  Color = 16744703
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 322
    Height = 177
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvSpace
    Color = 16744703
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    object Label1: TLabel
      Left = 8
      Top = 32
      Width = 51
      Height = 13
      Caption = 'Votre nom:'
    end
    object Bevel1: TBevel
      Left = 8
      Top = 136
      Width = 321
      Height = 1
      Shape = bsTopLine
    end
    object Label2: TLabel
      Left = 160
      Top = 80
      Width = 71
      Height = 13
      Caption = 'Rapidit'#233' du jeu'
    end
    object Label3: TLabel
      Left = 8
      Top = 80
      Width = 81
      Height = 13
      Caption = 'Difficult'#233's du jeu:'
    end
    object Edit1: TEdit
      Left = 8
      Top = 48
      Width = 297
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object Button1: TButton
      Left = 232
      Top = 144
      Width = 75
      Height = 25
      Caption = 'O&K'
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object Button2: TButton
      Left = 144
      Top = 144
      Width = 75
      Height = 25
      Caption = 'An&nuler'
      ModalResult = 2
      TabOrder = 2
    end
    object StaticText1: TStaticText
      Left = 2
      Top = 2
      Width = 318
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Option'
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
    object Speed1: TComboBox
      Left = 160
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        'Lent'
        'Normale'
        'Un peu rapide'
        'Rapide'
        'Tr'#232's rapide'
        'Ultra rapide(D'#233'conseill'#233')')
    end
    object Difficulty: TComboBox
      Left = 8
      Top = 96
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        'Faible'
        'Moyenne'
        'El'#233'v'#233'e')
    end
  end
end
