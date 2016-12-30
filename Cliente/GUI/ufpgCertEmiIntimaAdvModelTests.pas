unit ufpgCertEmiIntimaAdvModelTests;

interface

uses
  ufpgCertEmiIntimaAdv, ufpgModelTests, ADODB;

type
  TffpgCertEmiIntimaAdvModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FsVara: string;
    FsSeqRelacao: string;
    FsAnoRelacao: string;
    FsCertificado: string;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgVara: string read FsVara write FsVara;
    property fpgSeqRelacao: string read FsSeqRelacao write FsSeqRelacao;
    property fpgAnoRelacao: string read FsAnoRelacao write FsAnoRelacao;
    property fpgCertificado: string read FsCertificado write FsCertificado;
  end;

implementation

{ TffpgCertEmiIntimaAdvModelTests }

end.

