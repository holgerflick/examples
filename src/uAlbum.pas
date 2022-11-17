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
  LUrl := TMusicApiConst.BaseUrl +
    TMusicApiConst.PathGetTracksForAlbum( Id );

  FTracks.Clear;

  LTask := TTask.Create(
    procedure
    var
      LClient: THttpClient;
      LRes: THttpResponse;
      LDoc: IJsonDocument;
      LData: TJsonValue;
      LTrack: TTrack;

    begin
      LRes := nil;

      LClient := THttpClient.Create;
      try
        LClient.OnSendingRequest := TDeveloperToken.Shared.OnSendingRequest;

        LRes := LClient.Get( LUrl );
        if LRes.StatusCode = 200 then
        begin
          TMonitor.Enter(self);
          try
            FTracks.Clear;
          finally
            TMonitor.Exit(self);
          end;

          LDoc := TJsonDocument.Parse( TEncoding.UTF8.GetString( LRes.ContentAsBytes  ) );
          LData := LDoc.Root.Values['data'];
          for var i := 0 to LData.Count - 1 do
          begin
            LTrack := TTrack.Create( LData[i] );
            TMonitor.Enter(self);
            try
              FTracks.Add(LTrack);
            finally
              TMonitor.Exit(self);
            end;
          end;

          TThread.Queue( nil,
            procedure
            begin
              if Assigned( AFinishedProc ) then
              begin
                AFinishedProc( FTracks );
              end;
            end
          );
        end;
      finally
        LRes.Free;
        LClient.Free;
      end;
    end
  );

  FTask := LTask;
  LTask.Start;
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
  LAttr := AValue.Values['attributes'];

  FId := AValue['id'].ToInteger;
  FHref := AValue['href'].ToString;

  FArtistName := LAttr['artistName'].ToString;
  FIsSingle := LAttr['isSingle'].ToBoolean;
  FIsComplete := LAttr['isComplete'].ToBoolean;
  FUrl := LAttr['url'].ToString;

  var LGenreNames := LAttr['genreNames'];
  for var i := 0 to LGenreNames.Count-1 do
  begin
    var LGenre := LGenreNames[i].ToString;
    Genres[i] := LGenre;
  end;

  FTrackCount := LAttr['trackCount'].ToInteger;
  FIsMasteredForItunes := LAttr['isMasteredForItunes'].ToBoolean;
  FReleaseDate := LAttr['releaseDate'].ToString;
  FName := LAttr['name'].ToString;
  FRecordLabel := LAttr['recordLabel'].ToString;
  FUpc := LAttr['upc'].ToString;
  FCopyright := LAttr['copyright'].ToString;

  FArtwork.ReadFromJson( LAttr['artwork'] );
  FNotes.ReadFromJson( LAttr['editorialNotes'] );

  FIsCompilation := LAttr['isCompilation'].ToBoolean;
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
