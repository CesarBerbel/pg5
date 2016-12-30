unit ufpgCadGuiaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgCadGuiaModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsValorAjudaCusto: string;
    FsNuMandado: string;
    FsNuMandandoPrisao: string;
    FsNuGuia: string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNuMandado: string read FsNuMandado write FsNuMandado;
    property fpgNuGuia: string read FsNuGuia write FsNuGuia;
    property fpgNuMandandoPrisao: string read FsNuMandandoPrisao write FsNuMandandoPrisao;
    property fpgValorAjudaCusto: string read FsValorAjudaCusto write FsValorAjudaCusto;
  end;

implementation

end.

