object Form6: TForm6
  Left = 235
  Top = 112
  BorderStyle = bsNone
  Caption = 'Form6'
  ClientHeight = 302
  ClientWidth = 275
  Color = 16744703
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 275
    Height = 302
    Align = alClient
    BevelInner = bvRaised
    Color = 16744703
    TabOrder = 0
    OnMouseDown = Panel1MouseDown
    object StaticText1: TStaticText
      Left = 2
      Top = 2
      Width = 271
      Height = 17
      Align = alTop
      AutoSize = False
      Caption = 'Quick Help'
      Color = clFuchsia
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Transparent = False
      OnMouseDown = Panel1MouseDown
    end
    object RichEdit1: TRichEdit
      Left = 8
      Top = 24
      Width = 257
      Height = 233
      Lines.Strings = (
        'RichEdit1')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
    object Button1: TButton
      Left = 184
      Top = 264
      Width = 83
      Height = 25
      Caption = 'Fermer'
      Default = True
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
