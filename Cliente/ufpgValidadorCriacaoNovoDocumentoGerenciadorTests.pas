unit ufpgValidadorCriacaoNovoDocumentoGerenciadorTests;

interface

uses
  SysUtils, Classes, ufpgValidadorCriacaoNovoDocumentoGerenciador,
  ufpgValidadorCriacaoNovoDocumentoGerenciadorFake, TestFrameWork, uspTestCase, DB, DBClient;

type
  TfpgValidadorCriacaoNovoDocumentoGerenciadorTests = class(TSpTestCase)

  private
    FoValidador: TfpgValidadorCriacaoNovoDocumentoGerenciadorFake;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Testando pré-condições.
    procedure TestValidarComValoresInvalidosTodos;
    procedure TestValidarComValoresInvalidosSemUsuCriacao;
    procedure TestValidarComValoresInvalidosSemModelo;
    procedure TestValidarComValoresInvalidosSemTipoDoc;
    // Testando modelos de usuário.
    procedure TestValidarDocUsuarioUsuNaoCriouDoc;
    procedure TestValidarDocUsuarioUsuCriouDoc;
    procedure TestValidarDocUsuarioModeloInstituicaoUsuNaoCriou;
    // Testando modelos de instituição.
    procedure TestValidarDocInstituicaoUsuCriou;
    procedure TestValidarDocInstituicaoUsuNaoCriou;
    procedure TestValidarDocInstituicaoUsuCriouGrupoIgual;
    // Testando modelos de grupo
    procedure TestValidarDocGrupoUsuCriouMesmoGrupo;
    procedure TestValidarDocGrupoUsuCriouGruposDiferentes;
    procedure TestValidarDocGrupoUsuNaoCriouGruposIguais;
    procedure TestValidarDocGrupoUsuNaoCriouGruposDiferentes;
    // Testando exceções.
    procedure TestValidarCriandoAPartirModelo;
    procedure TestValidarCriandoAPartirFake;

  end;

implementation

uses
  usajConstante, uspExcecao, uedtModelo;

const
  sNOME_MODELO_PADRAO = 'MODELO DOCUMENTO PADRÃO ALVARÁ';
  sUSUARIO_PADRAO_CRIACAO_MODELO = 'M00001';
  sUSUARIO_LOGADO_PADRAO = 'M001';
  sTIPO_DOCUMENTO = 'D';
  sTIPO_PASTA = 'P';
  sTIPO_MODELO = 'M';
  sGRUPO_FAKE = '0';
  nCDMODELO = 1;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarComValoresInvalidosTodos;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, STRING_INDEFINIDO,
      STRING_INDEFINIDO, STRING_INDEFINIDO, 'D', nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checktrue(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TearDown;
begin
  FreeAndNil(FoValidador);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.SetUp;
begin
  FoValidador := TfpgValidadorCriacaoNovoDocumentoGerenciadorFake.Create;
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarDocUsuarioUsuNaoCriouDoc;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_LOGADO_PADRAO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmUsuario, sUSUARIO_PADRAO_CRIACAO_MODELO,
      STRING_INDEFINIDO, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checktrue(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarDocUsuarioUsuCriouDoc;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_PADRAO_CRIACAO_MODELO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmUsuario, sUSUARIO_PADRAO_CRIACAO_MODELO,
      STRING_INDEFINIDO, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarDocInstituicaoUsuCriou;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_PADRAO_CRIACAO_MODELO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_PADRAO_CRIACAO_MODELO,
      STRING_INDEFINIDO, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarDocInstituicaoUsuCriouGrupoIgual;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_PADRAO_CRIACAO_MODELO;
    FoValidador.fpgUsuarioNaListaDeGrupos := True;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_PADRAO_CRIACAO_MODELO,
      STRING_INDEFINIDO, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarDocInstituicaoUsuNaoCriou;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_LOGADO_PADRAO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_PADRAO_CRIACAO_MODELO,
      STRING_INDEFINIDO, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarDocGrupoUsuCriouMesmoGrupo;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_PADRAO_CRIACAO_MODELO;
    FoValidador.fpgUsuarioNaListaDeGrupos := True;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmGrupo, sUSUARIO_PADRAO_CRIACAO_MODELO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarDocGrupoUsuCriouGruposDiferentes;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_PADRAO_CRIACAO_MODELO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmGrupo, sUSUARIO_LOGADO_PADRAO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkTrue(bExcecao);
end;


procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarDocGrupoUsuNaoCriouGruposIguais;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_LOGADO_PADRAO;
    FoValidador.fpgUsuarioNaListaDeGrupos := True;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmGrupo, sUSUARIO_PADRAO_CRIACAO_MODELO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarDocGrupoUsuNaoCriouGruposDiferentes;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_LOGADO_PADRAO;
    FoValidador.fpgUsuarioNaListaDeGrupos := False;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmGrupo, sUSUARIO_PADRAO_CRIACAO_MODELO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkTrue(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarDocUsuarioModeloInstituicaoUsuNaoCriou;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.fpgCdUsuarioLogado := sUSUARIO_LOGADO_PADRAO;
    FoValidador.fpgUsuarioNaListaDeGrupos := True;
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmGrupo, sUSUARIO_PADRAO_CRIACAO_MODELO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarComValoresInvalidosSemUsuCriacao;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, STRING_INDEFINIDO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkTrue(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarComValoresInvalidosSemModelo;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_LOGADO_PADRAO,
      sGRUPO_FAKE, STRING_INDEFINIDO, sTIPO_DOCUMENTO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkTrue(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.
TestValidarComValoresInvalidosSemTipoDoc;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_LOGADO_PADRAO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, STRING_INDEFINIDO, nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;
  // Mudança de regra: não emite exceção.
  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarCriandoAPartirModelo;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_LOGADO_PADRAO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, 'M', nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

procedure TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.TestValidarCriandoAPartirFake;
var
  bExcecao: boolean;
begin
  bExcecao := False;
  try
    FoValidador.ValidarUsuarioPodeCriarDocumento(ftmInstituicao, sUSUARIO_LOGADO_PADRAO,
      sGRUPO_FAKE, sNOME_MODELO_PADRAO, 'JJJJ', nCDMODELO);
  except
    on e: EspRegraNegocio do
      bExcecao := True;
  end;

  checkFalse(bExcecao);
end;

initialization
  TestFramework.RegisterTest(
    'Unitário\PG5\Cliente\ufpgValidadorCriacaoNovoDocumentoGerenciadorTests',
    TfpgValidadorCriacaoNovoDocumentoGerenciadorTests.Suite);

end.

