unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TAnimal = class
  private
    FName: String;
  public
    constructor Create( AName: String );

    property Name: String read FName write FName;
  end;


  TPerson = class
  private
    FName: String;
  public
    property Name: String read FName write FName;
  end;

type
  TFrmMain = class(TForm)
    Memo: TMemo;
    btnLearnGenerics: TButton;
    procedure btnLearnGenericsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  System.Generics.Collections
  ;

{$R *.dfm}

type
  TAnimalList = TObjectList<TAnimal>;


procedure TFrmMain.btnLearnGenericsClick(Sender: TObject);
var
  LList: TAnimalList;
  LDict: TAnimalDict;
  LPerson: TPerson;

begin
  LList := TAnimalList.Create;

  try
    LList.Add( TAnimal.Create( 'Dog' ) );
    LList.Add( TAnimal.Create( 'Cat' ) );

    for var LAnimal in LList do
    begin
      Memo.Lines.Add( LAnimal.Name );
    end;

  finally
    LList.Free;
  end;

end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Memo.Lines.Clear;



end;

{ TAnimal }

constructor TAnimal.Create(AName: String);
begin
  inherited Create;

  FName := AName;
end;

end.
