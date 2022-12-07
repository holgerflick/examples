unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  VCL.TMSFNCTypes, VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser, VCL.TMSFNCMaps,
  VCL.TMSFNCGoogleMaps, VCL.TMSFNCMapsCommonTypes, CloudBase, CloudGoogleLookup;

type
  TFrmMain = class(TForm)
    btnAdd: TButton;
    btnHole: TButton;

    Maps: TTMSFNCGoogleMaps;

    procedure btnAddClick(Sender: TObject);
    procedure btnHoleClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.btnAddClick(Sender: TObject);
var
  LArr: TTMSFNCMapsCoordinateRecArray;
  LPoly: TTMSFNCMapsPolygon;

begin
  Maps.Polygons.Clear;

  Setlength(LArr, 3);
  LArr[0].Longitude := -80.19; LArr[0].Latitude := 25.774;
  LArr[1].Longitude := -66.118; LArr[1].Latitude := 18.466;
  LArr[2].Longitude := -64.757; LArr[2].Latitude := 32.321;

  LPoly := Maps.AddPolygon(LArr);
  LPoly.FillColor := gcCadetblue;
  LPoly.StrokeColor := gcBlue;
  LPoly.StrokeWidth := 0;
  LPoly.FillOpacity := 0.5;

  Maps.ZoomToBounds(LArr);
end;

procedure TFrmMain.btnHoleClick(Sender: TObject);
var
  LArr: TTMSFNCMapsCoordinateRecArray;
  LPoly: TTMSFNCGoogleMapsPolygon;

begin
  if Maps.Polygons.Count > 0 then
  begin
    LPoly := Maps.Polygons[0];

    Setlength(LArr, 3);
    LArr[0].Longitude := -66.668; LArr[0].Latitude := 27.339;
    LArr[1].Longitude := -67.514; LArr[1].Latitude := 29.57;
    LArr[2].Longitude := -70.579; LArr[2].Latitude := 28.745;

    LPoly.AddHole( LArr );
  end;
end;

end.
