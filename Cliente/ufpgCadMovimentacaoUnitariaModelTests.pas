unit ufpgCadMovimentacaoUnitariaModelTests;

interface

uses
  ufpgDataModelTests, usajConstante, SysUtils;

type
  TffpgCadMovimentacaoUnitariaModelTests = class(TfpgDataModelTests)
  private
    FsNuProcesso: string;
    procedure SetfpgNuProcesso(const Value: string);
  public
    //-----
    class function ConsultarTipoMvProcessoCompensaPeso(const psCdTipoMvProcesso: string): boolean;

    class procedure PegarPesoCartorio(const pnCdForo, pnCdCartorio, pnCdGrupoPeso: integer;
      out pnQtSaidoMoviment, pnQtTotal: integer);

    class procedure PegarPesoVaga(const pnCdForo, pnCdVara, pnCdVaga, pnCdGrupoPeso: integer;
      out pnQtSaidoMoviment, pnQtTotal: integer);


    class procedure PegarPesoVara(const pnCdForo, pnCdVara, pnCdGrupoPeso: integer;
      out pnQtSaidoMoviment, pnQtTotal: integer);

    class procedure PegarPesoGlobalVara(const pnCdForo, pnCdVara: integer;
      out pnQtPesoGlobal: integer);

    class procedure PegarPesoGlobalCartorio(const pnCdForo, pnCdCartorio: integer;
      out pnQtPesoGlobal: integer);

  published
    property fpgNuProcesso: string read FsNuProcesso write SetfpgNuProcesso;
  end;

implementation

uses
  usegRepositorio;

{ TffpgConsProcBasicaModelTests }

//***********************************************************************************************//
//                                       TESTES ANTERIORES                                       //
//***********************************************************************************************//
// 13/06/2013 - cleber.gomes - SALT: 61989/1
class function TffpgCadMovimentacaoUnitariaModelTests.ConsultarTipoMvProcessoCompensaPeso(
  const psCdTipoMvProcesso: string): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'SELECT FLCOMPENSAPESO FROM EFPGTIPOMVPROCESSO A WHERE A.CDTIPOMVPROCESSO = ' +
      Chr(39) + psCdTipoMvProcesso + Chr(39);
    oSegRepositorio.SQLOpen(sSQL);
    result := Trim(oSegRepositorio.FieldByName('FLCOMPENSAPESO').AsString) = 'S';
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 13/06/2013 - cleber.gomes - SALT: 61989/1
class procedure TffpgCadMovimentacaoUnitariaModelTests.PegarPesoCartorio(
  const pnCdForo, pnCdCartorio, pnCdGrupoPeso: integer; out pnQtSaidoMoviment, pnQtTotal: integer);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'select a.qtSaidoMoviment, a.qtTotal from EFPGPESOCARTORIO a where a.cdForo = ' +
      IntToStr(pnCdForo) + ' and a.cdCartorio = ' + IntToStr(pnCdCartorio) +
      ' and a.cdGrupoPeso = ' + IntToStr(pnCdGrupoPeso);
    oSegRepositorio.SQLOpen(sSQL);
    pnQtSaidoMoviment := oSegRepositorio.FieldByName('qtSaidoMoviment').AsInteger;
    pnQtTotal := oSegRepositorio.FieldByName('qtTotal').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 18/06/2013 - cleber.gomes - SALT: 61989/1
class procedure TffpgCadMovimentacaoUnitariaModelTests.PegarPesoGlobalCartorio(
  const pnCdForo, pnCdCartorio: integer; out pnQtPesoGlobal: integer);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'select a.qtPesoGlobal from efpgPesoGlobalCart a where a.cdForo = ' +
      IntToStr(pnCdForo) + ' and a.cdCartorio = ' + IntToStr(pnCdCartorio);
    oSegRepositorio.SQLOpen(sSQL);
    pnQtPesoGlobal := oSegRepositorio.FieldByName('qtPesoGlobal').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 18/06/2013 - cleber.gomes - SALT: 61989/1
class procedure TffpgCadMovimentacaoUnitariaModelTests.PegarPesoGlobalVara(
  const pnCdForo, pnCdVara: integer; out pnQtPesoGlobal: integer);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'select a.qtPesoGlobal from efpgPesoGlobalVara a where a.cdForo = ' +
      IntToStr(pnCdForo) + ' and a.cdVara = ' + IntToStr(pnCdVara);
    oSegRepositorio.SQLOpen(sSQL);
    pnQtPesoGlobal := oSegRepositorio.FieldByName('qtPesoGlobal').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 18/06/2013 - cleber.gomes - SALT: 61989/1
class procedure TffpgCadMovimentacaoUnitariaModelTests.PegarPesoVaga(
  const pnCdForo, pnCdVara, pnCdVaga, pnCdGrupoPeso: integer;
  out pnQtSaidoMoviment, pnQtTotal: integer);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'select a.qtSaidoMoviment, a.qtTotal from EFPGPESOVAGA a where a.cdForo = ' +
      IntToStr(pnCdForo) + ' and a.cdVara = ' + IntToStr(pnCdVara) + ' and a.cdVaga = ' +
      IntToStr(pnCdVaga) + ' and a.cdGrupoPeso = ' + IntToStr(pnCdGrupoPeso);
    oSegRepositorio.SQLOpen(sSQL);
    pnQtSaidoMoviment := oSegRepositorio.FieldByName('qtSaidoMoviment').AsInteger;
    pnQtTotal := oSegRepositorio.FieldByName('qtTotal').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 18/06/2013 - cleber.gomes - SALT: 61989/1
class procedure TffpgCadMovimentacaoUnitariaModelTests.PegarPesoVara(
  const pnCdForo, pnCdVara, pnCdGrupoPeso: integer; out pnQtSaidoMoviment, pnQtTotal: integer);
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'select a.qtSaidoMoviment, a.qtTotal from EFPGPESOVARA a where a.cdForo = ' +
      IntToStr(pncdForo) + ' and a.cdVara = ' + IntToStr(pncdVara) + ' and a.cdGrupoPeso = ' +
      IntToStr(pncdGrupoPeso);
    oSegRepositorio.SQLOpen(sSQL);
    pnQtSaidoMoviment := oSegRepositorio.FieldByName('qtSaidoMoviment').AsInteger;
    pnQtTotal := oSegRepositorio.FieldByName('qtTotal').AsInteger;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 13/06/2013 - cleber.gomes - SALT: 61989/1
procedure TffpgCadMovimentacaoUnitariaModelTests.SetfpgNuProcesso(const Value: string);
begin
  FsNuProcesso := Trim(Value);
end;

//***********************************************************************************************//
//***********************************************************************************************//

end.

