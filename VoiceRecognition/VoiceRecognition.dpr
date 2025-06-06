program VoiceRecognition;

uses
  Vcl.Forms,
  ufrmVoiceRecognition in 'ufrmVoiceRecognition.pas' {frmVoiceRecognition},
  uLLM.OpenAI in '..\Libs\LLM\uLLM.OpenAI.pas',
  uTTS.Windows.Engine in '..\Libs\TextToSpeech\uTTS.Windows.Engine.pas',
  uTTS.Microsoft.Cognitive.Voices.DTO in '..\Libs\TextToSpeech\uTTS.Microsoft.Cognitive.Voices.DTO.pas',
  uTTS.Microsoft.Cognitive in '..\Libs\TextToSpeech\uTTS.Microsoft.Cognitive.pas',
  uTTS.GoogleSpeech in '..\Libs\TextToSpeech\uTTS.GoogleSpeech.pas',
  uTTS.GoogleSpeech.DTO in '..\Libs\TextToSpeech\uTTS.GoogleSpeech.DTO.pas',
  uTTS.OpenAI in '..\Libs\TextToSpeech\uTTS.OpenAI.pas',
  uElevenLabs.Voices.DTO in '..\Libs\TextToSpeech\uElevenLabs.Voices.DTO.pas',
  uTTS.ElevenLabs in '..\Libs\TextToSpeech\uTTS.ElevenLabs.pas',
  uTTS in '..\Libs\TextToSpeech\uTTS.pas',
  uTTS.Amazon.Polly in '..\Libs\TextToSpeech\uTTS.Amazon.Polly.pas',
  SpeechLib_TLB in '..\Libs\TextToSpeech\SpeechLib_TLB.pas',
  uAssemblyAI.SpeechToText in '..\Libs\SpeechToText\uAssemblyAI.SpeechToText.pas',
  uDeepGram.SpeechToText in '..\Libs\SpeechToText\uDeepGram.SpeechToText.pas',
  uBaseSpeechRecognition in '..\Libs\SpeechToText\uBaseSpeechRecognition.pas',
  REST.Authenticator.EnhancedOAuth in '..\Libs\REST.Authenticator.EnhancedOAuth.pas',
  ufrmChatSession in 'ufrmChatSession.pas' {frmNewChatSession},
  uLLM.Azure in '..\Libs\LLM\uLLM.Azure.pas',
  uLLM in '..\Libs\LLM\uLLM.pas',
  uEngineManager in '..\Libs\uEngineManager.pas',
  BubbleText in '..\Libs\Bubble\BubbleText.pas',
  uAudioRecorder in '..\Libs\SpeechToText\uAudioRecorder.pas',
  uRevAI.SpeechToText in '..\Libs\SpeechToText\uRevAI.SpeechToText.pas',
  uAttributes in '..\Libs\LLM\uAttributes.pas',
  uLLM.Functions in '..\Libs\LLM\uLLM.Functions.pas',
  ApiKeyStore in '..\Libs\ApiKeyStore\ApiKeyStore.pas',
  ApiKeyStore.Windows in '..\Libs\ApiKeyStore\ApiKeyStore.Windows.pas',
  uAPIKeyNameList in '..\Libs\ApiKeyStore\uAPIKeyNameList.pas',
  frmApiKeyStore in '..\Libs\ApiKeyStore\frmApiKeyStore.pas' {frmApiKeyStores};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVoiceRecognition, frmVoiceRecognition);
  Application.CreateForm(TfrmNewChatSession, frmNewChatSession);
  Application.Run;
end.
