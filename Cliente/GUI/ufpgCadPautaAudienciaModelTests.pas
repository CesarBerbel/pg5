// 22/12/2015 - cesar.almeida - SALT: 186660/23/2
// Refatoração da classe
unit ufpgCadPautaAudienciaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadPautaAudienciaModelTests = class(TfpgModelTests)
  private
    FsCdVara: string;
    FsCdTipoAudiencia: string;
    FsDtPeriodoInicial: string;
    FsAudienciaBloco: boolean;
    FsNuProcesso: string;
    FsNuDias: string;
  published
    property fpgCdVara: string read FsCdVara write FsCdVara;
    property fpgCdTipoAudiencia: string read FsCdTipoAudiencia write FsCdTipoAudiencia;
    property fpgDtPeriodoInicial: string read FsDtPeriodoInicial write FsDtPeriodoInicial;
    property fpgAudienciaBloco: boolean read FsAudienciaBloco write FsAudienciaBloco;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuDias: string read FsNuDias write FsNuDias;

  end;

implementation

{ TffpgCadPautaAudienciaModelTests }

end.

