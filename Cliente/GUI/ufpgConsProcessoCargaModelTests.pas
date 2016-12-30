unit ufpgConsProcessoCargaModelTests;

interface

uses
  ufpgConsProcessoCarga, ufpgModelTests, ADODB, SysUtils;

type
  TffpgConsProcessoCargaModelTests = class(TfpgModelTests)
  private
    FbPreencherDiasAtraso: boolean;
    FbNaoRecebidos: boolean;
    FsDataRecebimentoInicial: string;
    fsDataRecebimentoFinal: string;
    FsNuProcesso: string;
    FsDiasAtraso: string;
    FsTipoLocalDestino: string;
    FsLocalDestino: string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgTipoLocalDestino: string read FsTipoLocalDestino write FsTipoLocalDestino;
    property fpgLocalDestino: string read FsLocalDestino write FsLocalDestino;
    property fpgPreencherDiasAtraso: boolean read FbPreencherDiasAtraso
      write FbPreencherDiasAtraso;
    property fpgDiasAtraso: string read FsDiasAtraso write FsDiasAtraso;
    property fpgDataRecebimentoInicial: string read FsDataRecebimentoInicial   
      write FsDataRecebimentoInicial;
    property fpgDataRecebimentoFinal: string read fsDataRecebimentoFinal 
      write FsDataRecebimentoFinal;
    property fpgNaoRecebidos: boolean read FbNaoRecebidos write FbNaoRecebidos;
  end;

implementation

{ TffpgConsProcessoCargaModelTests }

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;


end.

