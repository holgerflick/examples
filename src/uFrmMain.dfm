object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Example'
  ClientHeight = 571
  ClientWidth = 762
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    762
    571)
  TextHeight = 21
  object Memo: TMemo
    Left = 8
    Top = 16
    Width = 746
    Height = 496
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo')
    TabOrder = 0
  end
  object btnLearnGenerics: TButton
    Left = 8
    Top = 522
    Width = 225
    Height = 41
    Anchors = [akLeft, akBottom]
    Caption = 'Learn Generics'
    TabOrder = 1
    OnClick = btnLearnGenericsClick
  end
end
