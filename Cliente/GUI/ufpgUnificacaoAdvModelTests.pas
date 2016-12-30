unit ufpgUnificacaoAdvModelTests;

interface

uses
  ufpgUnificacaoAdv, ufpgModelTests, usajConstante;

type
  TffpgUnificacaoAdvModelTests = class(TfpgModelTests)

  private
    FsnmAdvogado: string;
  public
    class function VerificarAdvogadoUnificado(psNuFormatado, psCDPessoa: string): boolean;
  published
    property fpgnmAdvogado: string read FsnmAdvogado write FsnmAdvogado;
  end;

implementation

uses
  ufpgFuncoesGUISQLTests, ufpgFuncoesSQLTests, SysUtils, usegRepositorio;

class function TffpgUnificacaoAdvModelTests.VerificarAdvogadoUnificado(
  psNuFormatado, psCDPessoa: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin

  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := VerificarAdvogadoUnificado2(psNuFormatado, psCDPessoa);
    oSegRepositorio.SQLOpen(sSQL);
    result := (oSegRepositorio.FieldByName('FLUNIFICADO').AsString = 'S');
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

