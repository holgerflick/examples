unit uDbController;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TDbController = class(TDataModule)
    Connection: TFDConnection;
    QInstructors: TFDQuery;
    QClasses: TFDQuery;
    srcinstructors: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses
  System.IOUtils
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDbController.DataModuleCreate(Sender: TObject);
begin
  // Connection.Params.Database := 'workouts.db';

end;

end.
