object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Polygon Demo'
  ClientHeight = 442
  ClientWidth = 629
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'JetBrains Mono'
  Font.Style = []
  DesignSize = (
    629
    442)
  TextHeight = 21
  object btnAdd: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 34
    Caption = 'Add polygon'
    TabOrder = 0
    OnClick = btnAddClick
  end
  object btnHole: TButton
    Left = 191
    Top = 8
    Width = 177
    Height = 34
    Caption = 'Add hole'
    TabOrder = 1
    OnClick = btnHoleClick
  end
  object Maps: TTMSFNCGoogleMaps
    Left = 8
    Top = 48
    Width = 613
    Height = 386
    ParentDoubleBuffered = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    DoubleBuffered = True
    TabOrder = 2
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    Options.DefaultZoomLevel = 12.000000000000000000
    Options.BackgroundColor = clBlack
    Options.DisablePOI = False
    Options.Version = 'beta'
    ElementContainers = <>
    HeadLinks = <>
    KMLLayers = <>
    Directions = <>
    Clusters = <>
    OverlayViews = <>
  end
end
