unit ufpgRelComunicDPModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRelComunicDPModelTests = class(TfpgModelTests)
  private
    FsDataInicio: string;
    FsDataFim: string;
    FsNuProcesso: string;
    FsDocumento: string;
  published
    property fpgDataInicio: string read FsDataInicio write FsDataInicio;
    property fpgDataFim: string read FsDataFim write FsDataFim;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgDocumento: string read FsDocumento write FsDocumento;
  end;

implementation

{ TffpgRelExtratoProcModelTests }

end.

