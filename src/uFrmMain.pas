unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCCustomWEBControl, VCL.TMSFNCCustomWEBComponent,
  VCL.TMSFNCWXBarcodeDecoder,
  JSON, VCL.TMSFNCCloudImage, AdvEdit;

type
  TForm1 = class(TForm)
    Decoder: TTMSFNCWXBarcodeDecoder;
    Image: TImage;
    txtUPC: TEdit;
    btnDecode: TButton;
    txtArtist: TAdvEdit;
    txtTitle: TAdvEdit;
    imgCover: TTMSFNCCloudImage;
    procedure btnDecodeClick(Sender: TObject);
  private
    FUPC: String;
    procedure SetUPC(const Value: String);
    function GetUPC: String;

    procedure DecodeUPC;
    procedure DownloadInformation;

    property UPC: String read GetUPC write SetUPC;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  TMSFNCCloudBase,
  System.Threading
  ;

resourcestring
  URL_ITUNES_LOOKUP_UPC = 'https://itunes.apple.com/lookup?upc=';

{$R *.dfm}

{ TForm1 }

procedure TForm1.SetUPC(const Value: String);
begin
  txtUPC.Text := Value;

  DownloadInformation;
end;

procedure TForm1.btnDecodeClick(Sender: TObject);
begin
  DecodeUPC;
end;

procedure TForm1.DecodeUPC;
var
  LBitmap: TTMSFNCBitmap;

begin
  // create a FNC specific image type
  LBitmap := TTMSFNCBitmap.Create;

  // assign image from UI
  LBitmap.Assign( Image.Picture );

  try
    // decode barcode
    Decoder.DecodeFromImage( LBitmap,
      procedure(const AFound: Boolean; const AResult: string)
      begin
        if AFound then
        begin
          // assign property
          // note that property change may affect UI, so better force
          // main thread execution...
          //
          TThread.Queue( nil,
            procedure
            begin
              UPC := AResult;
            end
          );
        end;
      end
    );
  finally
    LBitmap.Free;
  end;
end;

procedure TForm1.DownloadInformation;
var
  LInfo: String;
  LUrl: String;

  LJson: TJsonValue;
  LArray: TJsonArray;
  LAlbum: TJsonValue;

  LTitle,
  LArtist : String;
  LImageUrl: String;
  LBigImageUrl: String;

begin
  // build URL
  LUrl := URL_ITUNES_LOOKUP_UPC + UPC;

  // download JSON data
  LInfo := TTMSFNCCloudBase.SimpleGETSyncAsString( LUrl );

  if not LInfo.IsEmpty then
  begin
    // gets results
    LJson := TJsonObject.ParseJSONValue( LInfo );
    LArray := LJson.GetValue<TJsonArray>('results');

    // get first item of results
    if LArray.Count > 0 then
    begin
      LAlbum := LArray[0];

      LTitle := LAlbum.GetValue<string>('collectionName');
      LArtist := LAlbum.GetValue<string>('artistName');
      LImageUrl := LAlbum.GetValue<string>('artworkUrl100');

      // amend URL for bigger size image
      LBigImageUrl := LImageUrl.Replace('100x100', '500x500' );

      // assign to UI
      imgCover.URL := LBigImageUrl;
      txtTitle.Text := LTitle;
      txtArtist.Text := LArtist;
    end;
  end;
end;

function TForm1.GetUPC: String;
begin
  Result := txtUPC.Text;
end;

end.

end;
