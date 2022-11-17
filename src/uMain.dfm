object FrmMain: TFrmMain
  Width = 778
  Height = 682
  Caption = 'NASA: Astronomical Picture of the Day'
  CSSLibrary = cssBootstrap
  ElementFont = efCSS
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  OnCreate = WebFormCreate
  object Image: TWebImageControl
    Left = 24
    Top = 8
    Width = 713
    Height = 545
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object txtAuthor: TWebLabel
    Left = 24
    Top = 575
    Width = 713
    Height = 18
    AutoSize = False
    Caption = 'txtAuthor'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WidthPercent = 100.000000000000000000
  end
  object txtExplanation: TWebLabel
    Left = 24
    Top = 615
    Width = 713
    Height = 59
    AutoSize = False
    Caption = 'txtExplanation'
    ElementFont = efCSS
    HeightStyle = ssAuto
    HeightPercent = 100.000000000000000000
    WordWrap = True
    WidthPercent = 100.000000000000000000
  end
  object Request: TWebHttpRequest
    Headers.Strings = (
      'Cache-Control=no-cache, no-store, must-revalidate')
    ResponseType = rtJSON
    Left = 56
    Top = 88
  end
end
