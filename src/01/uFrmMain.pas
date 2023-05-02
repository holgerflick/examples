unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, VCL.TMSFNCEdgeWebBrowser, Vcl.StdCtrls;

type
  TFrmMain = class(TForm)
    Browser: TTMSFNCEdgeWebBrowser;
    txtURL: TEdit;
    btnGo: TButton;
    procedure BrowserInitialized(Sender: TObject);
    procedure BrowserNavigateComplete(Sender: TObject; var Params:
        TTMSFNCCustomWebBrowserNavigateCompleteParams);
    procedure btnGoClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetUrl;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.SetUrl;
begin
  Browser.Navigate( txtURL.Text );
end;

procedure TFrmMain.BrowserInitialized(Sender: TObject);
begin
  SetUrl;
end;

procedure TFrmMain.BrowserNavigateComplete(Sender: TObject; var Params:
    TTMSFNCCustomWebBrowserNavigateCompleteParams);
begin
  if Params.Success then
  begin
    txtURL.Text := Params.URL;
  end
  else
  begin
    MessageDlg('Error browsing to URL.', mtError, [mbOK], 0 );
  end;
end;

procedure TFrmMain.btnGoClick(Sender: TObject);
begin
  SetUrl;
end;

end.
