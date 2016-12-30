unit ufpgCadPecModelTests;

interface

uses
  ufpgCadPec, ufpgModelTests, ADODB;

type
  TffpgCadPecModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FsCdClasse: string;
    FsCdAssunto: string;
    FsCdCompetencia: string;
    FsQtdeDoctos: string;
    FsTipoDistribuicao: string;
    FsMotivo: string;
    FsCdVara: string;
  public
    class function VerificarPecCadastrado(psCdProcesso: string): string;
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdClasse: string read FsCdClasse write FsCdClasse;
    property fpgCdAssunto: string read FsCdAssunto write FsCdAssunto;
    property fpgCdCompetencia: string read FsCdCompetencia write FsCdCompetencia;
    property fpgQtdeDoctos: string read FsQtdeDoctos write FsQtdeDoctos;
    property fpgTipoDistribuicao: string read FsTipoDistribuicao write FsTipoDistribuicao;
    property fpgCdVara: string read FsCdVara write FsCdVara;
    property fpgMotivo: string read FsMotivo write FsMotivo;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils;

{ TffpgCadPecModelTests }

class function TffpgCadPecModelTests.VerificarPecCadastrado(psCdProcesso: string): string;
var
  oSegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarPecCadastradoSQL(psCdProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('DEOCORRENCIA').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

