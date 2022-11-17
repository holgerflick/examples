unit uTrack;

interface

uses
  System.Generics.Collections,
  System.Classes,
  System.SysUtils,

  Neslib.Json,

  uArtwork
  ;

type
  {$M+}
  TTrack = class
  private
    FUrlPreview: String;
    FArtwork: TArtwork;
    FArtistName: String;
    FUrl: String;
    FDiscNumber: Integer;
    FGenres: TArray<string>;
    FDurationInMillis: Integer;
    FReleaseDate: String;
    FIsAppleDigitalMaster: Boolean;
    FName: String;
    FIsrc: String;
    FHasLyrics: Boolean;
    FAlbumName: String;
    FTrackNumber: Integer;
    FComposerName: String;
    FId: Integer;
    FHref: String;

    procedure ReadFromJson( AValue: TJsonValue );
    function GetGenre(Index: Integer): String;
    procedure SetGenre(Index: Integer; const Value: String);
    function GetDurationInSecs: Integer;
    function GetDurationReadable: String;

  public
    constructor Create; overload;
    constructor Create( AValue: TJsonValue ); overload;
    destructor Destroy; override;

    property Genres[ Index: Integer ]: String read GetGenre write SetGenre;

  published

    property Id: Integer read FId write FId;
    property Href: String read FHref write FHref;

    property UrlPreview: String
      read FUrlPreview write FUrlPreview;
    property Artwork: TArtwork read FArtwork;
    property ArtistName: String
      read FArtistName write FArtistName;
    property Url: String read FUrl write FUrl;
    property DiscNumber: Integer
      read FDiscNumber write FDiscNumber;
    property DurationInMillis: Integer
      read FDurationInMillis write FDurationInMillis;
    property DurationInSecs: Integer read GetDurationInSecs;

    property DurationReadable: String read GetDurationReadable;

    property ReleaseDate: String
      read FReleaseDate write FReleaseDate;
    property IsAppleDigitalMaster: Boolean
      read FIsAppleDigitalMaster write FIsAppleDigitalMaster;
    property Name: String read FName write FName;
    property Isrc: String read FIsrc write FIsrc;
    property HasLyrics: Boolean read FHasLyrics write FHasLyrics;
    property AlbumName: String read FAlbumName write FAlbumName;
    property TrackNumber: Integer read FTrackNumber write FTrackNumber;
    property ComposerName: String read FComposerName write FComposerName;
  end;

  TTracks = TObjectList<TTrack>;

implementation

{ TTrack }

constructor TTrack.Create;
begin
  FArtwork := TArtwork.Create;
end;

constructor TTrack.Create(AValue: TJsonValue);
begin
  Create;

  ReadFromJson( AValue );
end;

destructor TTrack.Destroy;
begin
  FArtwork.Free;

  inherited;
end;

function TTrack.GetDurationInSecs: Integer;
begin
  Result := DurationInMillis DIV 1_000;
end;

function TTrack.GetDurationReadable: String;
begin
  Result :=  Format( '%.2d:%.2d',
      [
        DurationInSecs DIV 60, DurationInSecs MOD 60
       ] );
end;

function TTrack.GetGenre(Index: Integer): String;
begin
  Result := FGenres[Index];
end;

procedure TTrack.ReadFromJson(AValue: TJsonValue);
var
  i: Integer;

begin
  FId := AValue['id'].ToInteger;
  FHref := AValue['href'].ToString;

  var LAttr := AValue['attributes'];

  FArtistName := LAttr['artistName'].ToString;
  FUrl := LAttr['url'].ToString;
  FDiscNumber := LAttr['discNumber'].ToInteger;

  for i := 0 to LAttr['genreNames'].Count-1 do
  begin
    var LGenre := LAttr['genreNames'].Items[i];
    Genres[i] := LGenre.ToString;
  end;

  FUrlPreview := LAttr.Values['previews'].Items[0].Values['url'].ToString;

  FDurationInMillis := LAttr['durationInMillis'].ToInteger;
  FReleaseDate := LAttr['releaseDate'].ToString;
  FIsAppleDigitalMaster := LAttr['isAppleDigitalMaster'].ToBoolean;
  FName := LAttr['name'].ToString;
  FIsrc := LAttr['isrc'].ToString;
  FHasLyrics := LAttr['hasLyrics'].ToBoolean;
  FAlbumName := LAttr['albumName'].ToString;
  FTrackNumber := LAttr['trackNumber'].ToInteger;
  FComposerName := LAttr['composerName'].ToString;

end;

procedure TTrack.SetGenre(Index: Integer; const Value: String);
begin
  if Index >= Length(FGenres) then
  begin
    SetLength( FGenres, Index + 1 );
  end;

  FGenres[Index] := Value;
end;

end.
