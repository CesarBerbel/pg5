unit ufpgCargaDocumentoServUtilsTests;

interface

uses
  ufpgCargaDocumentoServUtils, TestFrameWork;

type
  TfpgCargaDocumentoServUtilsTests = class(TTestCase)
  private
    FoCargaDocumentoServUtils: TfpgCargaDocumentoServUtils;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_condicao_simples;
    procedure TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_nenhuma_condicao;
    procedure TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_condicao_in;
    procedure TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_parametro_simples;
    procedure TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_nenhum_parametro;
    procedure TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_tres_parametros;
    procedure TestarTestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto;
  end;

implementation

{ TfpgCargaDocumentoServUtilsTests }

uses
  usajConstante, uspSelectSQL, uspQuery, uspDatabase, SysUtils, ufpgVariaveisTestes;

procedure TfpgCargaDocumentoServUtilsTests.SetUp;
begin
  inherited;
  gbLogarNoSetup := False;
  FoCargaDocumentoServUtils := TfpgCargaDocumentoServUtils.Create; //PC_OK
end;

procedure TfpgCargaDocumentoServUtilsTests.TearDown;
begin
  inherited;
  FreeAndNil(FoCargaDocumentoServUtils); //PC_OK
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_condicao_simples;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := STRING_INDEFINIDO;
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);
    //Espera-se que haja a condição abaixo na consulta
    CheckTrue(Pos('C.CDTIPOOBJETO = :CDTIPOOBJETOCAT', qy.SQL.Text) > 0,
      'Esperava-se que houvesse condição "C.CDTIPOOBJETO = :CDTIPOOBJETOCAT" criada no texto ' +
      'da query. O texto gerado foi: ' + qy.SQL.Text);
  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_nenhuma_condicao;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := IntToStr(nObjQualquerObjeto);
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);
    //Espera-se que não haja as condições abaixo na consulta
    CheckFalse(Pos('C.CDTIPOOBJETO = :CDTIPOOBJETOCAT', qy.SQL.Text) > 0);
    CheckFalse(Pos('C.CDTIPOOBJETO IN (', qy.SQL.Text) > 0,
      'Esperava-se que não houvesse condição "C.CDTIPOOBJETO IN (" criada no texto da query. ' +
      'O texto gerado foi: ' + qy.SQL.Text);
  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarCondicaoDeTiposDeObjetosSeNecessario_com_condicao_in;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := IntToStr(nOBJPROCESSO) + ',' + IntToStr(nOBJPROTOCOLO) +
      ',' + IntToStr(nOBJAR);
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);
    //Espera-se que haja a condição abaixo na consulta
    CheckTrue(Pos('C.CDTIPOOBJETO IN (', qy.SQL.Text) > 0,
      'Esperava-se que houvesse condição "C.CDTIPOOBJETO IN (" criada no texto da query. ' +
      'O texto gerado foi: ' + qy.SQL.Text);
  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_nenhum_parametro;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := IntToStr(nObjQualquerObjeto);
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);

    FoCargaDocumentoServUtils.AdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario(
      sListaDeObjetosParaTeste, qy);
    //Espera-se que não haja as condições abaixo na consulta
    CheckTrue(qy.ParamCount = 0, 'Esperava-se que não houvesse parâmetros na query');
    CheckFalse(Assigned(qy.Params.FindParam('CDTIPOOBJETOCAT')),
      'Esperava-se que não houvesse o parâmetro CDTIPOOBJETOCAT na query');
  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_parametro_simples;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := STRING_INDEFINIDO;
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);

    FoCargaDocumentoServUtils.AdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario(
      sListaDeObjetosParaTeste, qy);

    //Espera-se que haja um parâmetro na query
    CheckTrue(qy.ParamCount = 1, 'Esperava-se que houvesse um parâmetro definido na query.');
    CheckTrue(Assigned(qy.Params.FindParam('CDTIPOOBJETOCAT')),
      'Esperava-se que o parâmetro CDTIPOOBJETOCAT estivesse definido na query');
    CheckTrue(qy.ParamByName('CDTIPOOBJETOCAT').AsInteger = NUMERO_INDEFINIDO,
      'Esperava-se que o valor do parâmetro CDTIPOOBJETOCAT fosse igual a STRING_INDEFINIDO');

  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarAdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario_com_tres_parametros;
var
  oSelect: TspSelectSQL;
  sListaDeObjetosParaTeste: WideString;
  qy: TspQuery;
begin
  oSelect := TspSelectSQL.Create(tbOracle);
  qy := TspQuery.Create(nil);
  try
    sListaDeObjetosParaTeste := IntToStr(nOBJPROCESSO) + ',' + IntToStr(nOBJPROTOCOLO) +
      ',' + IntToStr(nOBJAR);
    oSelect.AddColuna('C.CDOBJETO');
    oSelect.AddColuna('C.CDTIPOOBJETO');
    oSelect.AddTabela('SAJ.ESAJOBJETO C');
    FoCargaDocumentoServUtils.AdicionarCondicaoDeTiposDeObjetosSeNecessario(
      sListaDeObjetosParaTeste, oSelect);

    oSelect.GeraSelect(qy);

    FoCargaDocumentoServUtils.AdicionarParametrosDeTiposDeObjetosNaQuerySeNecessario(
      sListaDeObjetosParaTeste, qy);
    //Espera-se que haja a condição abaixo na consulta
    CheckTrue(qy.ParamCount = 3, 'Esperava-se que houvesse três parâmetros definidos na query.');
    CheckTrue(Assigned(qy.Params.FindParam('CDTIPOOBJETOCAT1')),
      'Esperava-se que o parâmetro CDTIPOOBJETOCAT1 estivesse presente na query');
    CheckTrue(Assigned(qy.Params.FindParam('CDTIPOOBJETOCAT2')),
      'Esperava-se que o parâmetro CDTIPOOBJETOCAT1 estivesse presente na query');
    CheckTrue(Assigned(qy.Params.FindParam('CDTIPOOBJETOCAT3')),
      'Esperava-se que o parâmetro CDTIPOOBJETOCAT1 estivesse presente na query');
    CheckTrue(qy.ParamByName('CDTIPOOBJETOCAT1').AsInteger = nOBJPROCESSO,
      'Esperava-se que o valor do parâmetro CDTIPOOBJETOCAT1 fosse igual a ' +
      IntToStr(nOBJPROCESSO) + ' mas estava igual a: ' +
      qy.ParamByName('CDTIPOOBJETOCAT1').AsString);
    CheckTrue(qy.ParamByName('CDTIPOOBJETOCAT2').AsInteger = nOBJPROTOCOLO,
      'Esperava-se que o valor do parâmetro CDTIPOOBJETOCAT2 fosse igual a ' +
      IntToStr(nOBJPROTOCOLO) + ' mas estava igual a: ' +
      qy.ParamByName('CDTIPOOBJETOCAT2').AsString);
    CheckTrue(qy.ParamByName('CDTIPOOBJETOCAT3').AsInteger = nOBJAR,
      'Esperava-se que o valor do parâmetro CDTIPOOBJETOCAT2 fosse igual a ' +
      IntToStr(nOBJAR) + ' mas estava igual a: ' + qy.ParamByName('CDTIPOOBJETOCAT3').AsString);
  finally
    FreeAndNil(oSelect);
    FreeAndNil(qy);
  end;
end;

procedure TfpgCargaDocumentoServUtilsTests.
TestarTestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto;
var
  sListaDeObjetosParaTeste: WideString;
begin
  //Se não for especificado nenhum tipo de objeto, deve retorar true.
  sListaDeObjetosParaTeste := STRING_INDEFINIDO;
  CheckTrue(FoCargaDocumentoServUtils.TestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto(
    sListaDeObjetosParaTeste));

  //Se for especificado o tipo de objeto "Qualquer objeto" deve retornar false
  sListaDeObjetosParaTeste := IntToStr(nObjQualquerObjeto);
  CheckFalse(FoCargaDocumentoServUtils.TestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto(
    sListaDeObjetosParaTeste));

  //Com uma lista contendo o tipo de objeto "Qualquer objeto" e outros tipos, deve retornar true.
  sListaDeObjetosParaTeste := IntToStr(nObjQualquerObjeto) + ',' + IntToStr(nOBJPROCESSO) +
    ',' + IntToStr(nOBJPROTOCOLO) + ',' + IntToStr(nOBJAR);
  CheckTrue(FoCargaDocumentoServUtils.TestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto(
    sListaDeObjetosParaTeste));

  //Com uma lista que não contém o tipo de objeto "Qualquer objeto" deve retornar true.
  sListaDeObjetosParaTeste := IntToStr(nOBJPROCESSO) + ',' + IntToStr(nOBJPROTOCOLO) +
    ',' + IntToStr(nOBJAR);
  CheckTrue(FoCargaDocumentoServUtils.TestarSeListaDeObjetosEhDiferenteDoObjetoQualquerObjeto(
    sListaDeObjetosParaTeste));
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Servidor\ufpgCargaDocumentoServUtilsTests',
    TfpgCargaDocumentoServUtilsTests.Suite);

end.

