unit ufpgTipoSelecaoPessoaAtoTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, uspTestCase,
  ufpgTipoSelecaoPessoaAtoFactory, ufpgFiltroTipoSelecaoAto;

type
  TfpgTipoSelecaoPessoaAtoTests = class(TspTestCase)
  protected
  published
    procedure TestarCriacaoInterfaceTratamentoFiltroNaoCriada;
    procedure TestarRetornarInstanciaDefensoria;
    procedure TestarRetornarInstanciaAdvPartes;
    procedure TestarRetornarInstanciaRepresentante;
    procedure TestarRetornarInstanciaRepresentanteRepresentante;
  end;

implementation

uses
  uedtConstantes, ufpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentante,
  ufpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes,
  ufpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublica;

{ TfpgTipoSelecaoPessoaAtoTests }

procedure TfpgTipoSelecaoPessoaAtoTests.TestarCriacaoInterfaceTratamentoFiltroNaoCriada;
var
  oTratamentoFiltro: IfpgFiltroTipoSelecaoAto;
begin
  //deve retornar nil
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null, '');
  try
    CheckTrue((not Assigned(oTratamentoFiltro)),
      'Nenhuma classe de tratamento foi criada, pois o tipo de sele��o n�o foi informado');
  finally
    oTratamentoFiltro := nil;
  end;
end;

procedure TfpgTipoSelecaoPessoaAtoTests.TestarRetornarInstanciaAdvPartes;
var
  oTratamentoFiltro: IfpgFiltroTipoSelecaoAto;
begin
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_PARTE_TODOS_ADVS_ATIVA);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes'),
      'A classe respons�vel pelos Advs da Parte era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_PARTE_TODOS_ADVS_PASSIVA);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes'),
      'A classe respons�vel pelos Advs da Parte era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_PARTE_ADV_ATIVA_PRINC);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes'),
      'A classe respons�vel pelos Advs da Parte era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_PARTE_ADV_PASSIVA_PRINC);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoAdvogadosPartes'),
      'A classe respons�vel pelos Advs da Parte era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
end;

procedure TfpgTipoSelecaoPessoaAtoTests.TestarRetornarInstanciaDefensoria;
var
  oTratamentoFiltro: IfpgFiltroTipoSelecaoAto;
begin
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPOPARTEDEFENSORIAPUBLICA);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoDefensoriaPublica'),
      'A classe respons�vel pela defensoria p�blica era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
end;

procedure TfpgTipoSelecaoPessoaAtoTests.TestarRetornarInstanciaRepresentante;
var
  oTratamentoFiltro: IfpgFiltroTipoSelecaoAto;
begin
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_SELECAO_ATO_ADV_REPRESENTANTE);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoAdvogadoRepresentante'),
      'A classe respons�vel pelo representante era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
end;

procedure TfpgTipoSelecaoPessoaAtoTests.TestarRetornarInstanciaRepresentanteRepresentante;
var
  oTratamentoFiltro: IfpgFiltroTipoSelecaoAto;
begin
  oTratamentoFiltro := TfpgTipoSelecaoPessoaAtoFactory.PegarTratamentoTpSelecaoPessoaAto(null,
    sTIPO_SELECAO_ATO_REPRESENTANTE_REPRESENTANTE);
  try
    CheckTrue((oTratamentoFiltro.GetClassName =
      'TfpgTratamentoTipoSelecaoPessoaAtoRepresentanteRepresentante'),
      'A classe respons�vel pelo representante era esperada');
  finally
    oTratamentoFiltro := nil;
  end;
end;

initialization
  TestFrameWork.RegisterTest('Unit�rio\PG5\Servidor\ufpgTipoSelecaoPessoaAtoTests',
    TfpgTipoSelecaoPessoaAtoTests.Suite);

end.

