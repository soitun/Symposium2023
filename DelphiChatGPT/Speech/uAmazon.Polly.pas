unit uAmazon.Polly;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  Data.Cloud.AmazonAPI,
  Data.Cloud.CloudAPI,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.NetEncoding,
  System.Hash,
  uBaseSpeech,
  AWS.Polly,  // need to install AWS SDK For Delphi Preview
  AWS.Core    // Need Delphi Enterprise or above and install from
              // GetIt
  ;

type
  TAmazonPollyService = class(TBaseSpeech)
  private
    FAccountName : string;
    FAccountKey: string;
  public
    constructor Create(AccountName:string; AccountKey: string);
    destructor Destroy; override;
    function TextToSpeech(text: string; VoiceName: string = ''): TMemoryStream; override;
    function SpeechEngineName: string; override;
  end;

implementation

constructor TAmazonPollyService.Create(AccountName:string; AccountKey: string);
begin
  FAccountName := AccountName;
  FAccountKey := AccountKey;
end;

destructor TAmazonPollyService.Destroy;
begin
  inherited;
end;

function TAmazonPollyService.SpeechEngineName: string;
begin
  Result := 'Amazon.Polly';
end;

function TAmazonPollyService.TextToSpeech(text, VoiceName: string): TMemoryStream;
var
  polly : TPollyClient;
  request : TPollySynthesizeSpeechRequest;
  response : IPollySynthesizeSpeechResponse;
  options : IAWSOptions;
begin
  options := TAWSOptions.Create;
  options.AccessKeyId := FAccountName;
  options.SecretAccessKey := FAccountKey;
  options.Region := 'ap-southeast-2';
  polly := TPollyClient.Create(options);
  try
    request := TPollySynthesizeSpeechRequest.Create;
    request.Text := text;
    request.OutputFormat := 'mp3';
    request.VoiceId := 'Olivia';
    request.SetEngine('neural');
    response := polly.SynthesizeSpeech(request);
    Result := TMemoryStream.Create;
    Result.CopyFrom(response.AudioStream, response.AudioStream.Size);
  finally
    FreeAndNil(polly);
  end;
end;

end.
