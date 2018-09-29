object Form7: TForm7
  Left = 261
  Top = 202
  BorderStyle = bsDialog
  Caption = 'Ouvri session jeu'
  ClientHeight = 334
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageCtrl: TPageControl
    Left = 8
    Top = 16
    Width = 289
    Height = 305
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Connexion'
      object Label1: TLabel
        Left = 8
        Top = 56
        Width = 28
        Height = 13
        Caption = 'Email:'
      end
      object Label2: TLabel
        Left = 8
        Top = 104
        Width = 67
        Height = 13
        Caption = 'Mot de passe:'
      end
      object msg_label: TLabel
        Left = 8
        Top = 144
        Width = 161
        Height = 57
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 8
        Top = 136
        Width = 257
        Height = 17
        Shape = bsTopLine
      end
      object email: TEdit
        Left = 72
        Top = 48
        Width = 185
        Height = 21
        TabOrder = 0
        Text = 'jacobk@yahoo.fr'
      end
      object psw: TEdit
        Left = 80
        Top = 104
        Width = 177
        Height = 21
        PasswordChar = '*'
        TabOrder = 1
        Text = 'jacobk'
      end
      object Button1: TButton
        Left = 174
        Top = 156
        Width = 75
        Height = 25
        Caption = 'Connexion'
        Default = True
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Joueurs en ligne'
      ImageIndex = 1
      TabVisible = False
      object ListBox1: TListBox
        Left = 16
        Top = 8
        Width = 249
        Height = 225
        ItemHeight = 13
        TabOrder = 0
      end
      object Button2: TButton
        Left = 128
        Top = 240
        Width = 139
        Height = 25
        Caption = 'Envoyer demande de jeu'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
end
