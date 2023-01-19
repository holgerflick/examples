unit uFrmMain;

interface

uses
  System.SysUtils, System.Classes, JS, Web, WEBLib.Graphics, WEBLib.Controls,
  WEBLib.Forms, WEBLib.Dialogs, Data.DB, WEBLib.CDS, WEBLib.RadServerCDS,
  Vcl.Controls, Vcl.Grids, WEBLib.DBCtrls, WEBLib.DB, Vcl.StdCtrls,
  WEBLib.StdCtrls;

type
  TForm1 = class(TWebForm)
    Dataset: TWebRadServerClientDataset;
    Datasource: TWebDataSource;
    Grid: TWebDBGrid;
    WebButton1: TWebButton;
    DatasetID: TIntegerField;
    DatasetNAME: TStringField;
    procedure WebButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WebButton1Click(Sender: TObject);
begin
  DataSet.Open;
end;

end.
