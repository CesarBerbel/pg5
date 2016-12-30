unit ufpgConfigIntimaAdvModelTests;

interface

uses
  ufpgConfigIntimaAdv, ufpgModelTests, ADODB;

type
  TffpgConfigIntimaAdvModelTests = class(TfpgModelTests)
  private
    FbAbrirDoMenu: boolean;
    FbFecharTela: boolean;
    FbNovaRelacao: boolean;
    FbFinalizar: boolean;
    FbConsultaProcPublicar: boolean;
    FbCertifica: boolean;
    FsNuProcesso: string;
    FsCdVara: string;
    FsCdJuiz: string;
    FsCdEscrivao: string;
    FsJuiz: string;
    FsEscrivao: string;
    FsCertificado: string;
    FsCdForo: string;
    FsNuRelacao: string;
    FsCdProcesso: string;
    FsPessoa: string;
  public
    class function VerificarGeraIntimacao(psCdForo, psCdProcesso, psCdVara, psPessoa,
      psNuRelacao: string): boolean;
  published
    property fpgAbrirDoMenu: boolean read FbAbrirDoMenu write FbAbrirDoMenu;
    property fpgFecharTela: boolean read FbFecharTela write FbFecharTela;
    property fpgNovaRelacao: boolean read FbNovaRelacao write FbNovaRelacao;
    property fpgFinalizar: boolean read FbFinalizar write FbFinalizar;
    property fpgConsultaProcPublicar: boolean read FbConsultaProcPublicar 
      write FbConsultaProcPublicar;
    property fpgCertifica: boolean read FbCertifica write FbCertifica;
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdVara: string read FsCdVara write FsCdVara;
    property fpgCdJuiz: string read FsCdJuiz write FsCdJuiz;
    property fpgCdEscrivao: string read FsCdEscrivao write FsCdEscrivao;
    property fpgJuiz: string read FsJuiz write FsJuiz;
    property fpgEscrivao: string read FsEscrivao write FsEscrivao;
    property fpgCertificado: string read FsCertificado write FsCertificado;
    property fpgCdForo: string read FsCdForo write FsCdForo;
    property fpgCdProcesso: string read FsCdProcesso write FsCdProcesso;
    property fpgNuRelacao: string read FsNuRelacao write FsNuRelacao;
    property fpgPessoa: string read FsPessoa write FsPessoa;
  end;

implementation

{ TffpgConfigIntimaAdvModelTests }


uses
  usegrepositorio, ufpgFuncoesGUISQLTests, SysUtils;

class function TffpgConfigIntimaAdvModelTests.VerificarGeraIntimacao(
  psCdForo, psCdProcesso, psCdVara, psPessoa, psNuRelacao: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarGeraIntimacaoSQL(psCdForo, psCdProcesso, psCdVara, psPessoa, psNuRelacao);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

