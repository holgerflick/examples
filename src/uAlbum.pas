unit uAlbum;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Threading,
  System.Generics.Collections,

  Neslib.Json,

  uArtwork,
  uTrack;

type
  {$M+}
  TAlbumNotes = class
  private
    FStandard: String;
    FShort: String;
  public
    constructor Create( AValue: TJsonValue ); overload;

    procedure ReadFromJson( AValue: TJsonValue );
  published

    property Standard: String read FStandard;
    property Short: String read FShort;
  end;

  {$M+}
  TAlbum = class
  private
    FNotes: TAlbumNotes;

    FId: Integer;
    FHref: String;
    FName: String;
    FArtwork: TArtwork;
    FGenres: TArray<string>;
    FGenresCount: Integer;
    FUrl: String;
    FTrackCount: Integer;
    FIsMasteredForItunes: Boolean;
    FReleaseDate: String;
    FRecordLabel: String;
    FUpc: String;
    FCopyright: String;
    FArtistName: String;
    FIsSingle: Boolean;
    FIsComplete: Boolean;
    FIsCompilation: Boolean;

    FTracks: TTracks;

    FTask: ITask;

    function GetGenre(Index: Integer): String;
    procedure SetGenre(Index: Integer; const Value: String);
    function GetGenresCount: Integer;

  public
    constructor Create; overload;
    constructor Create( AValue: TJsonValue ); overload;
    destructor Destroy; override;

    procedure ReadFromJson( AValue: TJsonValue );

    procedure DownloadTracks( AFinishedProc: TProc<TTracks> = nil );

    property Genres[ Index: Integer ]: String read GetGenre write SetGenre;
    property GenresCount: Integer read GetGenresCount;

  published
    property Id: Integer read FId write FId;
    property Href: String read FHref write FHref;
    property Name: String read FName write FName;
    property Url: String read FUrl write FUrl;
    property ArtistName: String read FArtistName write FArtistName;
    property IsSingle: Boolean read FIsSingle write FIsSingle;
    property IsComplete: Boolean read FIsComplete write FIsComplete;
    property TrackCount: Integer read FTrackCount write FTrackCount;
    property IsMasteredForItunes: Boolean read FIsMasteredForItunes write FIsMasteredForItunes;
    property ReleaseDate: String read FReleaseDate write FReleaseDate;
    property RecordLabel: String read FRecordLabel write FRecordLabel;
    property Upc: String read FUpc write FUpc;
    property Copyright: String read FCopyright write FCopyright;
    property IsCompilation: Boolean read FIsCompilation write FIsCompilation;
    property Notes: TAlbumNotes read FNotes;

    property Artwork: TArtwork read FArtwork;
    property Tracks: TTracks read FTracks;

  end;

  TAlbums = TObjectList<TAlbum>;

implementation

uses
  Bcl.Utils,

  Sparkle.Http.Client,

  uMusicApiConst,
  uDeveloperToken
  ;

{ TAlbum }

constructor TAlbum.Create;
begin
  inherited;

  FNotes := TAlbumNotes.Create;
  FArtwork := TArtwork.Create;
  FTracks := TTracks.Create;
end;

constructor TAlbum.Create(AValue: TJsonValue);
begin
  Create;

  ReadFromJson( AValue );
end;

destructor TAlbum.Destroy;
begin
  FArtwork.Free;
  FNotes.Free;
  FTracks.Free;

  if Assigned( FTask ) then
  begin
    FTask.Cancel;
  end;

  FTask := nil;

  inherited;
end;

procedure TAlbum.DownloadTracks( AFinishedProc: TProc<TTracks> = nil );
var
  LTask: ITask;
  LUrl: String;

begin
    // ...
end;

function TAlbum.GetGenre(Index: Integer): String;
begin
  Result := FGenres[Index];
end;

function TAlbum.GetGenresCount: Integer;
begin
  Result := Length( FGenres );
end;

procedure TAlbum.ReadFromJson(AValue: TJsonValue);
var
  LAttr: TJsonValue;

begin
	// ...
end;

procedure TAlbum.SetGenre(Index: Integer; const Value: String);
begin
  if Index >= Length( FGenres ) then
  begin
    SetLength( FGenres, Index + 1 );
  end;

  FGenres[ Index ] := Value;
end;

{ TAlbumNotes }

constructor TAlbumNotes.Create(AValue: TJsonValue);
begin
  Create;

  ReadFromJson( AValue );
end;

procedure TAlbumNotes.ReadFromJson(AValue: TJsonValue);
begin
  FStandard := AValue['standard'].ToString;
  FShort := AValue['short'].ToString;
end;

end.
