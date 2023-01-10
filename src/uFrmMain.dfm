object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 556
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    848
    556)
  TextHeight = 20
  object btnGenerate: TButton
    Left = 8
    Top = 8
    Width = 137
    Height = 41
    Caption = 'Generate Report'
    TabOrder = 0
    OnClick = btnGenerateClick
  end
  object Preview: TFlexCelPreviewer
    Left = 8
    Top = 55
    Width = 832
    Height = 493
    HorzScrollBar.Range = 20
    HorzScrollBar.Tracking = True
    VertScrollBar.Range = 503
    VertScrollBar.Tracking = True
    Zoom = 1.000000000000000000
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
end
