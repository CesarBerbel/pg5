unit ufpgCadParteRepresModelTests;

interface

uses
  SysUtils, ufpgModelTests, ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests;

type
  TffpgCadParteRepresModelTests = class(TfpgModelTests)

  private
    FsNomeParte: string;
    FsCEP: string;
    FsNumero: string;
    FsNuProcesso: string;
    FbVerificarParteProcesso: boolean;
    FbExcluirParte: boolean;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgNomeParte: string read FsNomeParte write FsNomeParte;
    property fpgCEP: string read FsCEP write FsCEP;
    property fpgNumero: string read FsNumero write FsNumero;
    property fpgVerificarParteProcesso: boolean read FbVerificarParteProcesso   
      write FbVerificarParteProcesso;
    property fpgExcluirParte: boolean read FbExcluirParte write FbExcluirParte;
    class function VerificarCadastroParte(psNuProcesso, psNuPessoa: string): boolean;
    class function SelecionarProcessoPorSituacao(psSituacaoProcesso: string): string;

  end;

implementation

uses
  usegRepositorio;

{ TffpgCadParteRepresModelTests }

class function TffpgCadParteRepresModelTests.SelecionarProcessoPorSituacao(
  psSituacaoProcesso: string): string;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarProcessoSql(psSituacaoProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('NUPROCESSO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgCadParteRepresModelTests.VerificarCadastroParte(psNuProcesso: string;
  psNuPessoa: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarCadastroParteSql(psNuPessoa, psNuProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ENCONTROU').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

