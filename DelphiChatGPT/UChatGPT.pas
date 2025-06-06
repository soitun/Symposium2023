unit UChatGPT;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IniFiles,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.Menus,
  System.IOUtils,
  uLLM,
  uLLM.OpenAI,
  uLLM.Azure,
  uTTS,
  uTTS.ElevenLabs,
  uTTS.Microsoft.Cognitive,
  uTTS.Amazon.Polly,
  uTTS.GoogleSpeech,
  uTTS.Windows.Engine,
  frmApiKeyStore,
  ApiKeyStore,
  uEngineManager
  ;

type
  TForm1 = class(TForm)
    btnAskTheMachine: TButton;
    mmoOutput: TMemo;
    Image1: TImage;
    mmoPrompt: TMemo;
    chkSpeak: TCheckBox;
    btnSpeakQuestion: TButton;
    mmMainMenu: TMainMenu;
    miFile: TMenuItem;
    miExit: TMenuItem;
    miTextToSpeechEngine: TMenuItem;
    miMicrosoftSpeechEngine: TMenuItem;
    miAmazonSpeechEngine: TMenuItem;
    miGoogleSpeechEngine: TMenuItem;
    miElevenLabsSpeechEngine: TMenuItem;
    miWindowsSpeechEngine: TMenuItem;
    miModelMenu: TMenuItem;
    miTextDavinci003: TMenuItem;
    miTextCurie0011: TMenuItem;
    miTextBabbage001: TMenuItem;
    miTextAda0011: TMenuItem;
    miSettings: TMenuItem;
    miAPIKeys: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAskTheMachineClick(Sender: TObject);
    procedure btnGoogleAuthClick(Sender: TObject);
    procedure btnSpeakQuestionClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miTextDavinci003Click(Sender: TObject);
    procedure SelectSpeechEngine(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miAPIKeysClick(Sender: TObject);
  private
    FTextToSpeechEngine : TEngineManager<TBaseTextToSpeech, TMenuItem>;
    FSettings : TIniFile;
    FApiKeyStore : TApiKeyStore;
    FOpenAI : TBaseLLM;
    function SelectedModel: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  lSpeechEngine: string;
  i: Integer;
  currentModel : string;
begin
  FApiKeyStore := TApiKeyStore.GetInstance;
  FTextToSpeechEngine := TEngineManager<TBaseTextToSpeech, TMenuItem>.Create;
  FSettings := TIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));
  FOpenAI := TOpenAI.Create(FApiKeyStore.LoadApiKey('chatgpt_apikey'));


  FTextToSpeechEngine.RegisterEngine(
     TMicrosoftCognitiveService.Create(FApiKeyStore.LoadApiKey('ms_cognative_service_resource_key'), 'australiaeast.tts.speech.microsoft.com'), miMicrosoftSpeechEngine);
  FTextToSpeechEngine.RegisterEngine(
     TElevenLabsService.Create(FApiKeyStore.LoadApiKey('ElevenLabsAPIKey')), miElevenLabsSpeechEngine);
  FTextToSpeechEngine.RegisterEngine(
     TAmazonPollyService.Create(FApiKeyStore.LoadApiKey('AWSAccessKey'), FApiKeyStore.LoadApiKey('AWSSecretkey'), FApiKeyStore.LoadSetting('AWSRegion')), miAmazonSpeechEngine);//'ADUG Demo', '');
  FTextToSpeechEngine.RegisterEngine(
     TWindowsSpeechService.Create, miWindowsSpeechEngine);
  FTextToSpeechEngine.RegisterEngine(
     TGoogleSpeechService.Create( FApiKeyStore.LoadApiKey('google_clientid'),  FApiKeyStore.LoadApiKey('google_clientsecret'), 'ADUG Demo', '', FSettings), miGoogleSpeechEngine);

  lSpeechEngine := FSettings.ReadString('Speech', 'SelectedEngine', 'TWindowsSpeechService');
  FTextToSpeechEngine.SelectEngine(lSpeechEngine);
  FTextToSpeechEngine.ActiveMenuItem.Checked := True;
  currentModel := FSettings.ReadString('ChatGPT', 'Model', 'text-davinci-003').Replace('&', '');
  for i := 0 to miModelMenu.Count - 1 do
  begin
    if miModelMenu.Items[i].Caption = currentModel then
    begin
      miModelMenu.Items[i].Click;
      break;
    end;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTextToSpeechEngine);
  FreeAndNil(FSettings);
  FreeAndNil(FOpenAI);
end;

function TForm1.SelectedModel: string;
var
  i : Integer;
begin
  for i := 0 to miModelMenu.Count - 1 do
  begin
    if miModelMenu.Items[i].Checked then
    begin
      Result := miModelMenu.Items[i].Caption.Replace('&', '');
    end;
  end;
end;

procedure TForm1.SelectSpeechEngine(Sender: TObject);
begin
  FTextToSpeechEngine.SelectEngine(Sender as TMenuItem);
  (Sender as TMenuItem).Checked := True;
  FSettings.WriteString('Speech', 'SelectedEngine', FTextToSpeechEngine.ActiveEngine.ClassName);
end;

procedure TForm1.btnAskTheMachineClick(Sender: TObject);
var
  OldCursor : TCursor;
  Config : TChatSettings;
  msgs: TObjectList<TChatMessage>;
  msg: TChatMessage;
begin
  OldCursor := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    msgs := TObjectList<TChatMessage>.Create;
    msg := TChatMessage.Create;
    msg.Role := 'System';
    msg.Content := 'You are a helpful assistant';
    msgs.Add(msg);

    msg := TChatMessage.Create;
    msg.Role := 'User';
    msg.Content := mmoPrompt.Text;
    msgs.Add(msg);

//    mmoOutput.Lines.Text := FOpenAI.Completion(mmoPrompt.Text, SelectedModel);
    config.model := SelectedModel;
    config.n := 1;
    config.max_tokens := 6200;
    config.json_mode := False;
    mmoOutput.Lines.Text := FOpenAI.ChatCompletion(Config, msgs).Content;
    Update;
    if chkSpeak.Checked then
    begin
      FTextToSpeechEngine.ActiveEngine.PlayText(mmoOutput.Lines.Text);
    end;
  finally
    Screen.Cursor := OldCursor;
  end;
end;

procedure TForm1.btnGoogleAuthClick(Sender: TObject);
begin
  (FTextToSpeechEngine.ActiveEngine as TGoogleSpeechService).Authenticate;
end;

procedure TForm1.btnSpeakQuestionClick(Sender: TObject);
begin
  FTextToSpeechEngine.ActiveEngine.PlayText(mmoPrompt.Lines.Text);
end;

procedure TForm1.miAPIKeysClick(Sender: TObject);
var
  frmApiKeyStores : TfrmApiKeyStores;
begin
  frmApiKeyStores := TfrmApiKeyStores.Create(nil);
  try
    frmApiKeyStores.ShowModal;
  finally
    FreeAndNil(frmApiKeyStores)
  end;
end;

procedure TForm1.miExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.miTextDavinci003Click(Sender: TObject);
var
  modelMenuItem : TMenuItem;
begin
  modelMenuItem := Sender as TMenuItem;
  FSettings.WriteString('ChatGPT', 'Model', modelMenuItem.Caption.Replace('&', ''));
end;

end.
