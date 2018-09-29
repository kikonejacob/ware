object Form3: TForm3
  Left = 274
  Top = 213
  BorderStyle = bsDialog
  Caption = 'Fin de la partie'
  ClientHeight = 213
  ClientWidth = 319
  Color = 16762623
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object P_count: TLabel
    Left = 8
    Top = 164
    Width = 40
    Height = 13
    Caption = 'P_count'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 153
    Caption = 'Resultats de la partie'
    TabOrder = 0
    object p0_title: TLabel
      Left = 8
      Top = 16
      Width = 145
      Height = 19
      AutoSize = False
      Caption = 'p0_title'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object p1_title: TLabel
      Left = 144
      Top = 16
      Width = 153
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'p1_title'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = 4570402
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object p0_points: TLabel
      Left = 8
      Top = 40
      Width = 145
      Height = 13
      AutoSize = False
      Caption = 'p0_points'
    end
    object p0_cases: TLabel
      Left = 8
      Top = 64
      Width = 145
      Height = 13
      AutoSize = False
      Caption = 'p0_cases'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object p1_points: TLabel
      Left = 144
      Top = 40
      Width = 153
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'p1_points'
    end
    object p1_cases: TLabel
      Left = 144
      Top = 64
      Width = 153
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'p1_cases'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object whowin: TLabel
      Left = 2
      Top = 120
      Width = 301
      Height = 25
      Alignment = taCenter
      AutoSize = False
      Caption = 'Vous avez perdu'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 8
      Top = 112
      Width = 289
      Height = 9
      Shape = bsTopLine
    end
    object P0_winparts: TLabel
      Left = 8
      Top = 88
      Width = 153
      Height = 13
      AutoSize = False
      Caption = 'P0_winparts'
    end
    object P1_winparts: TLabel
      Left = 160
      Top = 88
      Width = 137
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'P1_winparts'
    end
  end
  object Button1: TButton
    Left = 240
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Continuer'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 160
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Arr'#234'ter'
    ModalResult = 2
    TabOrder = 2
  end
end
