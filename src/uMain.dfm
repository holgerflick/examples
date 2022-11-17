object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object dtFinished: TDateTimePicker
    Left = 40
    Top = 56
    Width = 217
    Height = 23
    Date = 44879.000000000000000000
    Time = 0.540066388886771100
    DateFormat = dfLong
    TabOrder = 0
  end
  object cbFinished: TCheckBox
    Left = 40
    Top = 33
    Width = 217
    Height = 17
    Caption = 'Finished'
    TabOrder = 1
    OnClick = cbFinishedClick
  end
  object btnGetDate: TButton
    Left = 40
    Top = 112
    Width = 217
    Height = 49
    Caption = 'What is the date?'
    TabOrder = 2
    OnClick = btnGetDateClick
  end
end
