unit uMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Vcl.Controls, WEBLib.ExtCtrls, WEBLib.REST,
  Data.DB, WEBLib.CDS, Vcl.StdCtrls, WEBLib.StdCtrls;

type
  TFrmMain = class(TWebForm)
    Image: TWebImageControl;
    Request: TWebHttpRequest;
    txtAuthor: TWebLabel;
    txtExplanation: TWebLabel;
    procedure WebFormCreate(Sender: TObject);
  private
    { Private declarations }
    [async]
    procedure LoadImage;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  uNasaApodService
  ;

procedure TFrmMain.LoadImage;
var
  LReq : TJSXMLHttpRequest;
  LObj: TJSObject;

begin
   Request.URL := TNasaApodService.GetUrl;
   LReq := await(TJSXMLHttpRequest, Request.Perform());

   LObj := TJSObject( LReq.response );
   Image.URL := string( LObj['url'] );
   txtExplanation.Caption := string( LObj['explanation'] );
   txtAuthor.Caption := string( LObj['copyright'] );
end;

procedure TFrmMain.WebFormCreate(Sender: TObject);
begin
  LoadImage;
end;

end.
