unit ufpgProcMvCompensaServModelTests;

interface

uses
  ufpgZerarPesoVara, ufpgDataModelTests, SysUtils, usajConstante;

type
  TffpgProcMvCompensaServModelTests = class(TfpgDataModelTests)
  public
    /// <summary>
    ///  Consulta a existencia de processo(s) a partir do Foro e Tipo Cartório referido.
    /// </summary>
    /// <param name="pnCdForo">
    /// </param>
    /// <param name="pnCdTipoCartorio">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  12/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    class function ConsultarProcMvCompensaPorForoETipoCartorio(
      const pnCdForo, pnCdTipoCartorio: integer): boolean;
    /// <summary>
    ///  Teste se há registro de compensação por processo.
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    class function ConsultarProcMvCompensaPorCdProcesso(const psCdProcesso: string;
      const pnNuSeqProcessoMv: integer = NUMERO_INDEFINIDO): boolean;
  end;

implementation

uses
  usegRepositorio;

{ TffpgProcMvCompensaServModelTests }

// 21/06/2013 - cleber.gomes - SALT: 61989/1
class function TffpgProcMvCompensaServModelTests.ConsultarProcMvCompensaPorCdProcesso(
  const psCdProcesso: string; const pnNuSeqProcessoMv: integer): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL := 'SELECT COUNT(A.CDPROCESSO) AS QUANTIDADE FROM EFPGPROCMVCOMPENSA A WHERE A.CDPROCESSO = '''
      + psCdProcesso + '''';
    if (pnNuSeqProcessoMv <> NUMERO_INDEFINIDO) then
      sSQL := sSQL + ' AND A.NUSEQPROCESSOMV = ' + IntToStr(pnNuSeqProcessoMv);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('QUANTIDADE').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

// 21/06/2013 - cleber.gomes - SALT: 61989/1
class function TffpgProcMvCompensaServModelTests.ConsultarProcMvCompensaPorForoETipoCartorio(
  const pnCdForo, pnCdTipoCartorio: integer): boolean;
var
  osegRepositorio: TesegRepositorio;
  sSQL: string;
begin
  oSegRepositorio := TesegRepositorio.Create(nil);
  try
    sSQL :=
      'SELECT COUNT(A.CDPROCESSO) AS QUANTIDADE FROM EFPGPROCMVCOMPENSA A JOIN EFPGDISTPROCESSO B ON A.CDPROCESSO = B.CDPROCESSO WHERE B.FLULTDISTRIBUICAO = ''' + sFLAG_SIM + '''' + ' AND B.CDFORO = ' + IntToStr(pnCdForo);
    if pnCdTipoCartorio <> NUMERO_INDEFINIDO then
      sSQL := sSQL + '   AND B.CDTIPOCARTORIO = ' + IntToStr(pnCdTipoCartorio);
    oSegRepositorio.SQLOpen(sSQL);
    result := oSegRepositorio.FieldByName('QUANTIDADE').AsInteger > 0;
  finally
    FreeAndNil(oSegRepositorio);
  end;
end;

end.

