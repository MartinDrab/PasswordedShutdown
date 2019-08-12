object MainFrm: TMainFrm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Passworded Shutdown'
  ClientHeight = 152
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainPanel: TPanel
    Left = 0
    Top = 0
    Width = 328
    Height = 113
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 11
      Width = 35
      Height = 13
      Caption = 'Domain'
    end
    object Label2: TLabel
      Left = 32
      Top = 38
      Width = 51
      Height = 13
      Caption = 'User name'
    end
    object Label3: TLabel
      Left = 32
      Top = 65
      Width = 46
      Height = 13
      Caption = 'Password'
    end
    object DomainEdit: TEdit
      Left = 120
      Top = 8
      Width = 185
      Height = 21
      TabOrder = 0
    end
    object UserEdit: TEdit
      Left = 120
      Top = 35
      Width = 185
      Height = 21
      TabOrder = 1
    end
    object PasswordEdit: TEdit
      Left = 120
      Top = 62
      Width = 185
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
    object ForceCheckBox: TCheckBox
      Left = 120
      Top = 89
      Width = 81
      Height = 17
      Caption = 'Force'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object ShutdownButton: TButton
    Tag = 1
    Left = 248
    Top = 119
    Width = 65
    Height = 33
    Caption = 'Shutdown'
    TabOrder = 1
    OnClick = ActionButtonClick
  end
  object RebootButton: TButton
    Left = 177
    Top = 117
    Width = 65
    Height = 33
    Caption = 'Reboot'
    TabOrder = 2
    OnClick = ActionButtonClick
  end
end
