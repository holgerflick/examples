object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'TMS FNC Edge Web Browser Demo'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    624
    441)
  TextHeight = 15
  object Browser: TTMSFNCEdgeWebBrowser
    Left = 0
    Top = 42
    Width = 624
    Height = 399
    ParentDoubleBuffered = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = True
    TabOrder = 0
    OnInitialized = BrowserInitialized
    OnNavigateComplete = BrowserNavigateComplete
    Settings.EnableContextMenu = True
    Settings.EnableShowDebugConsole = True
    Settings.EnableAcceleratorKeys = True
    Settings.UsePopupMenuAsContextMenu = False
  end
  object txtURL: TEdit
    Left = 8
    Top = 8
    Width = 521
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'https://www.tmssoftware.com/site/default.asp'
  end
  object btnGo: TButton
    Left = 544
    Top = 8
    Width = 65
    Height = 28
    Anchors = [akTop, akRight]
    Caption = 'Go'
    TabOrder = 2
    OnClick = btnGoClick
  end
end
