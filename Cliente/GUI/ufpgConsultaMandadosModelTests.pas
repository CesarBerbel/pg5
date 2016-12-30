unit ufpgConsultaMandadosModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgConsultaMandadosModelTests = class(TfpgModelTests)
  private
    FbPesquisarNuProcesso: boolean;
    FsNuProcesso: string;
    FbPesquisarNuMandado: boolean;
    FsNuMandado: string;
    FbPesquisarDtEmissao: boolean;
    FbPesquisarDtDistribuicao: boolean;
    FsTipoDistribuicao: string;
    FbPesquisarPessoa: boolean;
    FsNomePessoa: string;
  published
    property fpgPesquisarNuProcesso: boolean read FbPesquisarNuProcesso 
      write FbPesquisarNuProcesso;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgPesquisarNuMandado: boolean read FbPesquisarNuMandado write FbPesquisarNuMandado;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
    property fpgPesquisarDtEmissao: boolean read FbPesquisarDtEmissao write FbPesquisarDtEmissao;
    property fpgPesquisarDtDistribuicao: boolean 
      read FbPesquisarDtDistribuicao   write FbPesquisarDtDistribuicao;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgPesquisarPessoa: boolean read FbPesquisarPessoa write FbPesquisarPessoa;
    property fpgNomePessoa: string read FsNomePessoa write FsNomePessoa;
  end;

implementation

{ TffpgConsultaMandadosModelTests }


end.

