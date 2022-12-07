unit uFrmMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.TMSFNCMapsCommonTypes, FMX.TMSFNCTypes, FMX.TMSFNCUtils,
  FMX.TMSFNCCustomComponent, FMX.TMSFNCCloudBase, FMX.TMSFNCDirections,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TMSFNCCustomControl,
  FMX.TMSFNCWebBrowser, FMX.TMSFNCMaps, FMX.TMSFNCHereDirections, FMX.TMSFNCGraphicsTypes,
  FMX.Edit, FMX.ListBox, FMX.TMSFNCGraphics;

type
  TFrmMain = class(TForm)
    Map: TTMSFNCMaps;
    Panel1: TPanel;
    btnRoute: TButton;
    HereDirections: TTMSFNCHereDirections;
    Label1: TLabel;
    rbFast: TRadioButton;
    rbShort: TRadioButton;
    btnClear: TButton;
    cbUseWeight: TCheckBox;
    edWeight: TEdit;
    Label3: TLabel;
    cbUseWidth: TCheckBox;
    edWidth: TEdit;
    Label5: TLabel;
    cbUseHeight: TCheckBox;
    edHeight: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    cbUseSpeedCap: TCheckBox;
    edSpeedCap: TEdit;
    Label6: TLabel;
    cbTunnelCategory: TComboBox;
    Label7: TLabel;
    cbAvoidTunnels: TCheckBox;
    cbAvoidDirtRoads: TCheckBox;
    cbAvoidDifficultTurns: TCheckBox;
    Label8: TLabel;
    cbHazard: TCheckBox;
    procedure btnRouteClick(Sender: TObject);
    procedure DirectionsGetDirections(Sender: TObject;
      const ARequest: TTMSFNCDirectionsRequest;
      const ARequestResult: TTMSFNCCloudBaseRequestResult);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

procedure TFrmMain.btnRouteClick(Sender: TObject);
var
  Origin, Destination: TTMSFNCMapsCoordinateRec;
  gw, w, h, s: Integer;
begin
//France
//  Origin.Latitude := 49;
//  Origin.Longitude := 4;
//  Destination.Latitude := 54;
//  Destination.Longitude := 9;

//Denmark-Sweden
//  Origin.Latitude := 55.39;
//  Origin.Longitude := 10.38;
//  Destination.Latitude := 55.60;
//  Destination.Longitude := 13;

//Antwerp-Ghent
//  Origin.Latitude := 51.26;
//  Origin.Longitude := 4.40;
//  Destination.Latitude := 51.04;
//  Destination.Longitude := 3.73;

//Seattle-Vancouver
//  Origin.Latitude := 47.60;
//  Origin.Longitude := -122.33;
//  Destination.Latitude := 49.24;
//  Destination.Longitude := -123.11;

// Atlanta-Los Angeles
  Origin.Latitude := 33.748889;
  Origin.Longitude := -84.39;
  Destination.Latitude := 34.05;
  Destination.Longitude := -118.25;


  // transfer UI control settings to options for routing

  if rbFast.IsChecked then
    HereDirections.Options.RoutingMode := rmFast
  else
    HereDirections.Options.RoutingMode := rmShort;

  HereDirections.Options.Truck.GrossWeight := 0;
  if cbUseWeight.IsChecked and TryStrToInt(edWeight.Text, gw) then
  begin
    HereDirections.Options.Truck.GrossWeight := gw;
  end;

  HereDirections.Options.Truck.Width := 0;
  if cbUseWidth.IsChecked and TryStrToInt(edWidth.Text, w) then
  begin
    HereDirections.Options.Truck.Width := w;
  end;

  HereDirections.Options.Truck.Height := 0;
  if cbUseHeight.IsChecked and TryStrToInt(edHeight.Text, h) then
  begin
    HereDirections.Options.Truck.Height := h;
  end;

  HereDirections.Options.Truck.SpeedCap := 0;
  if cbUseSpeedCap.IsChecked and TryStrToInt(edSpeedCap.Text, s) then
  begin
    HereDirections.Options.Truck.SpeedCap := s;
  end;

  HereDirections.Options.Truck.TunnelCategory := tcNone;
  if cbTunnelCategory.ItemIndex = 1 then
    HereDirections.Options.Truck.TunnelCategory := tcB;
  if cbTunnelCategory.ItemIndex = 2 then
    HereDirections.Options.Truck.TunnelCategory := tcC;
  if cbTunnelCategory.ItemIndex = 3 then
    HereDirections.Options.Truck.TunnelCategory := tcD;
  if cbTunnelCategory.ItemIndex = 4 then
    HereDirections.Options.Truck.TunnelCategory := tcE;

  HereDirections.Options.AvoidTunnels := cbAvoidTunnels.IsChecked;
  HereDirections.Options.AvoidDirtRoads := cbAvoidDirtRoads.IsChecked;
  HereDirections.Options.Truck.AvoidDifficultTurns := cbAvoidDifficultTurns.IsChecked;

  HereDirections.Options.Truck.HazardousMaterials := cbHazard.IsChecked;

  Map.AddMarker(Origin);
  Map.AddMarker(Destination);

  // ask for directions
  // remember: asynchronous call, deal with response in GetDirections event
  HereDirections.GetDirections(Origin, Destination, nil, '', nil, False, tmTruck);
end;

procedure TFrmMain.btnClearClick(Sender: TObject);
begin
  Map.Clear;
end;

procedure TFrmMain.DirectionsGetDirections(Sender: TObject;
  const ARequest: TTMSFNCDirectionsRequest;
  const ARequestResult: TTMSFNCCloudBaseRequestResult);
var
  p: TTMSFNCMapsPolyline;
begin
  // check if request was successful and at least one route has been found
  if (ARequestResult.Success) and (ARequest.Items.Count > 0) then
  begin
    // show approx. duration in hours
    Label4.Text := IntToStr(ARequest.Items[0].Duration DIV 3600 ) + ' h';

    // draw route
    p := Map.AddPolyline(ARequest.Items[0].Coordinates.ToArray);
    p.StrokeOpacity := 0.8;
    p.StrokeWidth := 5;
    p.StrokeColor := gcBlue;

    // focus map to show route
    Map.ZoomToBounds(ARequest.Items[0].Coordinates.ToArray);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  HereDirections.APIKey := '';
  Map.APIKey := '';
end;

end.
