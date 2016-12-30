unit ufpgRedistribLoteVagaModelTests;

interface

uses
  ufpgModelTests;

type
  TffpgRedistribLoteVagaModelTests = class(TfpgModelTests)
  private
    FsNuProcesso: string;
    FnCdForoDestino: string;
    FnCdVagaDestino: string;
    FnCdVaraDestino: string;
    FsMotivo: string;
    FbDistSorteio: boolean;
    FbJuizProcesso: string;
  public
    class function VerificarVaraProcesso(psVaraDestino, psVagaDestino: string;
      psCDProcesso: string): boolean;
    class function VerificarJuizVaga(psCdProcesso, psCdJuiz, psCdVaga, psCdVara,
      psCdForo: string): boolean;
    class procedure VerificarDadosDistProcesso(psCdProcesso: string);
  published
    property fpgNuProcesso: string read FsNuProcesso write FsNuProcesso;
    property fpgCdForoDestino: string read FnCdForoDestino write FnCdForoDestino;
    property fpgCdVaraDestino: string read FnCdVaraDestino write FnCdVaraDestino;
    property fpgCdVagaDestino: string read FnCdVagaDestino write FnCdVagaDestino;
    property fpgMotivo: string read FsMotivo write FsMotivo;
    property fpgDistSorteio: boolean read FbDistSorteio write FbDistSorteio;
    property fpgJuizProcesso: string read FbJuizProcesso write FbJuizProcesso;
  end;

implementation

uses
  usegRepositorio, ufpgFuncoesGUISQLTests, SysUtils, ufpgVariaveisTestesGUI;

class function TffpgRedistribLoteVagaModelTests.VerificarVaraProcesso(
  psVaraDestino, psVagaDestino: string; psCDProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarMudouVagaSql(psVaraDestino, psVagaDestino, psCDProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger = 1;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class function TffpgRedistribLoteVagaModelTests.VerificarJuizVaga(psCdProcesso,
  psCdJuiz, psCdVaga, psCdVara, psCdForo: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarJuizVaga(psCdProcesso, psCdJuiz, psCdVaga, psCdVara, psCdForo);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('ACHOU').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

class procedure TffpgRedistribLoteVagaModelTests.VerificarDadosDistProcesso(psCdProcesso: string);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := RetornarVerificarDadosDistProcesso(psCdProcesso);
    oSegRepositorio.SQLOpen(sSQL);
    gsVaga := oSegRepositorio.FieldByName('CDVAGA').AsString;
    gsVara := oSegRepositorio.FieldByName('CDVARA').AsString;
    gsForo := oSegRepositorio.FieldByName('CDFORO').AsString;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

