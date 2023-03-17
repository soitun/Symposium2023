unit uElevenLabs.Voices.DTO;

//  *************************************************
//    Generated By: JsonToDelphiClass - 0.65
//    Project link: https://github.com/PKGeorgiev/Delphi-JsonToDelphiClass
//    Generated On: 2023-02-08 14:15:01
//  *************************************************
//    Created By  : Petar Georgiev - 2014
//    WebSite     : http://pgeorgiev.com
//  *************************************************

interface

uses Generics.Collections, Rest.Json;

type

TVoicesClass = class
private
  FAvailable_for_tiers: TArray<String>;
  FCategory: String;
  FName: String;
  FPreview_url: String;
  FSamples: TArray<String>;
  FVoice_id: String;
public
  property available_for_tiers: TArray<String> read FAvailable_for_tiers write FAvailable_for_tiers;
  property category: String read FCategory write FCategory;
  property name: String read FName write FName;
  property preview_url: String read FPreview_url write FPreview_url;
  property samples: TArray<String> read FSamples write FSamples;
  property voice_id: String read FVoice_id write FVoice_id;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TVoicesClass;
end;

TRootClass = class
private
  FVoices: TArray<TVoicesClass>;
public
  property voices: TArray<TVoicesClass> read FVoices write FVoices;
  destructor Destroy; override;
  function ToJsonString: string;
  class function FromJsonString(AJsonString: string): TRootClass;
end;

implementation

{TVoicesClass}


function TVoicesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVoicesClass.FromJsonString(AJsonString: string): TVoicesClass;
begin
  result := TJson.JsonToObject<TVoicesClass>(AJsonString)
end;

{TRootClass}

destructor TRootClass.Destroy;
var
  LvoicesItem: TVoicesClass;
begin

 for LvoicesItem in FVoices do
   LvoicesItem.free;

  inherited;
end;

function TRootClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRootClass.FromJsonString(AJsonString: string): TRootClass;
begin
  result := TJson.JsonToObject<TRootClass>(AJsonString)
end;

end.
