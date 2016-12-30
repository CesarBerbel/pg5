unit ufpgNumeroMandadoRegrasTests;

interface

uses
  ufpgNumeroMandadoRegras, usmdNumeroMandado, ufpgNumeroMandadoRegrasFake,
  ufpgRegrasCartorioUnicoFake, ufpgRegrasLotacaoUnificadaFake, TestFrameWork,
  usmdNumeroMandadoFake, ufpgAdapterLotacaoUnica;

type
  TfpgNumeroMandadoRegrasTests = class(TTestCase)
  private
    FoNumeroMandadoFake: TsmdNumeroMandadoFake;
    FoNumeroMandadoRegrasFake: TfpgNumeroMandadoRegrasFake;
    FoControleCartorioUnicoFake: TfpgRegrasCartorioUnicoFake;

    procedure CriarObjetoRegraMandadoComParametroIncorreto;
    procedure LimparNumeroMandadoRegrasFake;
    function CriarObjetoRegraMandadoComParametroCorreto: boolean;
  protected

    procedure SetUp; override;
    procedure TearDown; override;

  published

    // Test methods
    // Teste Create
    procedure TestCreateComParametroIncorreto;
    procedure TestCreateComParametroCorreto;

    // Teste método ExecutarRegraAntesValidarMandado
    procedure TestExecutarRegraAntesValidarMandadoComExcecaoPararExecucao;
    procedure TestExecutarRegraAntesValidarMandadoComExcecaoRegraNegocio;
    procedure TestExecutarRegraAntesValidarMandadoComExcecaoExcecaoGenerica;
    procedure TestExecutarRegraAntesValidarMandadoSemPermissaoTela;

    // Teste método AlternarLotacaoUnificada
    procedure TestAlternarLotacaoCartorioTipoRegraNaoSeAplica;
    procedure TestAlternarLotacaoCartorioTipoLotacaoDiferenteCartorio;
    procedure TestAlternarLotacaoCartorioTipoRegraTrocaLotacaoTipoLotacaoDiferenteCartorio;
    procedure TestAlternarLotacaoCartorioTipoRegraTrocaLotacaoTipoLotacaoCartorio;
    procedure TestarAlternarLotacaoUsuarioSemPermissaoTela;

    procedure TestarTelaNaoTrabalhaComoCartorioUnico;
    procedure TestarTelaTrabalhaComoCartorioUnicoMasUsuarioNaoLotadoEmCartorio;
    procedure TestarSistemaHabilitadoParaNaoTrabalharComoCartorioUnico;
    procedure TestarAlternarLotacaoUsuarioMesmaLotacao;
  end;

implementation

uses
  SysUtils, uspExcecao, ufpgRegrasCartorioUnico, usajLotacao, usajConstante;

{ TfpgNumeroMandadoRegrasTests }

procedure TfpgNumeroMandadoRegrasTests.CriarObjetoRegraMandadoComParametroIncorreto;
var
  oNumeroMandadoRegras: TfpgNumeroMandadoRegras;
  oQualquer: TObject;
begin
  oQualquer := TObject.Create;
  try
    oNumeroMandadoRegras := TfpgNumeroMandadoRegras.Create(oQualquer);
    try

    finally
      FreeAndNil(oNumeroMandadoRegras);
    end;
  finally
    FreeAndNil(oQualquer);
  end;
end;

function TfpgNumeroMandadoRegrasTests.CriarObjetoRegraMandadoComParametroCorreto: boolean;
var
  oNumeroMandadoRegras: TfpgNumeroMandadoRegras;
  oMandado: TsmdNumeroMandadoFake;
begin
  result := True;
  try
    oMandado := TsmdNumeroMandadoFake.Create(nil);
    try
      oNumeroMandadoRegras := TfpgNumeroMandadoRegras.Create(oMandado);
      try

      finally
        FreeAndNil(oNumeroMandadoRegras);
      end;
    finally
      FreeAndNil(oMandado);
    end;
  except
    result := False;
  end;
end;

procedure TfpgNumeroMandadoRegrasTests.SetUp;
begin
  inherited;
  FoNumeroMandadoFake := TsmdNumeroMandadoFake.Create(nil); //PC_OK
  FoNumeroMandadoRegrasFake := TfpgNumeroMandadoRegrasFake.Create(FoNumeroMandadoFake); //PC_OK

  // TfpgRegrasCartorioUnicoFake.CriarInstanciaControleCartorioUnico(null); //PC_OK
  // FoControleCartorioUnicoFake := TfpgRegrasCartorioUnicoFake(
  //   TfpgRegrasCartorioUnico.PegarControleCartorioUnico);

  FoControleCartorioUnicoFake.AtualizarPropriedades(nil);
end;

procedure TfpgNumeroMandadoRegrasTests.TearDown;
begin
  FreeAndNil(FoNumeroMandadoFake); //PC_OK
  LimparNumeroMandadoRegrasFake;
  FreeAndNil(FoControleCartorioUnicoFake); //PC_OKs
  // TfpgRegrasCartorioUnicoFake.DestruirInstanciaControleCartorioUnico;
  inherited;
end;

procedure TfpgNumeroMandadoRegrasTests.TestCreateComParametroIncorreto;
begin
  CheckException(CriarObjetoRegraMandadoComParametroIncorreto, EspRegraNegocio,
    'Teste para garantir que será emitida exceção caso o parâmetro seja diferente de smdNumeroMandado'
    );
end;

procedure TfpgNumeroMandadoRegrasTests.TestarTelaNaoTrabalhaComoCartorioUnico;
begin
  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuNaoSeAplica;

  FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado;

  Check(FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica = trcuNaoSeAplica,
    'Testar se não foi alterado o tipo da regra do cartório único');
end;

procedure TfpgNumeroMandadoRegrasTests.
TestarTelaTrabalhaComoCartorioUnicoMasUsuarioNaoLotadoEmCartorio;
begin
  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlDistribuidor;

  FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado;

  Check(FoNumeroMandadoRegrasFake.FenTipoLotacao = tlDistribuidor,
    'Testar se nao foi alterada o tipo de lotação quando não lotado em cartório');
end;

procedure TfpgNumeroMandadoRegrasTests.TestarSistemaHabilitadoParaNaoTrabalharComoCartorioUnico;
begin
  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlCartorio;

  // TfpgRegrasCartorioUnicoFake(TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico).
  //   DefinirUtilizaCartorioUnico(False);

  FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado;

  // Check(TfpgRegrasCartorioUnicoFake(
  //   TfpgRegrasCartorioUnicoFake.PegarControleCartorioUnico).fpgUtilizaLotacaoUnificada = False,
  //   'Testar se não foi alterada a propriedade para trabalhar com cartório único');
end;


procedure TfpgNumeroMandadoRegrasTests.TestarAlternarLotacaoUsuarioMesmaLotacao;
const
  nCdForoValido = 23;
  nCdVaraValida = 5;
  nNuSeqLotacaoAtual = 44;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroMandadoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroMandadoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlCartorio;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := 'USUARIO3';

  FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado;

  Check(TfpgRegrasLotacaoUnificadaFake(
    FoControleCartorioUnicoFake.prpControleLotacao).fpgNuSeqLotacao = nNuSeqLotacaoAtual,
    'Teste para garantir que a lotação não foi trocada por ser o mesmo sequencial de lotacao.');
end;


procedure TfpgNumeroMandadoRegrasTests.TestExecutarRegraAntesValidarMandadoComExcecaoPararExecucao;
begin
  LimparNumeroMandadoRegrasFake;

  FoNumeroMandadoRegrasFake :=
    TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoPararExecucao.Create(nil); //PC_OK
  CheckException(FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado,
    Eabort, 'Teste para garantir que será disparado um abort quando a exceção for do tipo PararExecucao'
    );
end;

procedure TfpgNumeroMandadoRegrasTests.TestExecutarRegraAntesValidarMandadoComExcecaoRegraNegocio;
begin
  LimparNumeroMandadoRegrasFake;

  FoNumeroMandadoRegrasFake :=
    TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoRegraNegocio.Create(nil); //PC_OK
  CheckException(FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado,
    EspRegraNegocio,
    'Teste para verificar que não está escondendo exceção ao criar a regra de forma errada');
end;

procedure TfpgNumeroMandadoRegrasTests.
TestExecutarRegraAntesValidarMandadoComExcecaoExcecaoGenerica;
begin
  LimparNumeroMandadoRegrasFake;

  FoNumeroMandadoRegrasFake :=
    TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoGenerica.Create(nil); //PC_OK
  CheckException(FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado,
    Exception, 'Teste para verificar que não está escondendo exceção ao criar a regra de forma errada'
    );
end;

procedure TfpgNumeroMandadoRegrasTests.TestExecutarRegraAntesValidarMandadoSemPermissaoTela;
begin
  LimparNumeroMandadoRegrasFake;

  FoNumeroMandadoRegrasFake :=
    TfpgNumeroMandadoRegrasFakeAlternarLotacaoCartorioExcecaoSemPermissao.Create(nil); //PC_OK
  CheckException(FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado,
    Eabort, 'Teste para verificar que é disparado exceção quando usuário não tem permissão para acessar a tela na lotação corrente');
end;

procedure TfpgNumeroMandadoRegrasTests.LimparNumeroMandadoRegrasFake;
begin
  if Assigned(FoNumeroMandadoRegrasFake) then
    FreeAndNil(FoNumeroMandadoRegrasFake); //PC_OK
end;

procedure TfpgNumeroMandadoRegrasTests.TestAlternarLotacaoCartorioTipoRegraNaoSeAplica;
begin
  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuNaoSeAplica;
  CheckFalse(FoNumeroMandadoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para verificar que não será alterada a lotação com regra trcuNaoSeAplica');
end;

procedure TfpgNumeroMandadoRegrasTests.TestAlternarLotacaoCartorioTipoLotacaoDiferenteCartorio;
begin
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlVara;
  CheckFalse(FoNumeroMandadoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para verificar que não será alterada a lotação com lotação diferente de cartorio');
end;

procedure TfpgNumeroMandadoRegrasTests.
TestAlternarLotacaoCartorioTipoRegraTrocaLotacaoTipoLotacaoDiferenteCartorio;
begin
  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlVara;
  CheckFalse(FoNumeroMandadoRegrasFake.AlternarLotacaoCartorioPublico,
    'Teste para verificar que não será alterada a lotação com regra correta porem nao lotado em cartorio'
    );
end;

procedure TfpgNumeroMandadoRegrasTests.
TestAlternarLotacaoCartorioTipoRegraTrocaLotacaoTipoLotacaoCartorio;
const
  nCdForoValido = 23;
  nCdVaraValida = 1;
  nNuSeqLotacaoAtual = 2;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroMandadoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroMandadoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlCartorio;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  FoNumeroMandadoRegrasFake.FbTelaTemPermissao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := sUsuarioValido;
  FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado;

  Check(TfpgRegrasLotacaoUnificadaFake(
    FoControleCartorioUnicoFake.prpControleLotacao).fpgNuSeqLotacao <> nNuSeqLotacaoAtual,
    'Teste para garantir que a lotação foi trocada.');
end;

procedure TfpgNumeroMandadoRegrasTests.TestarAlternarLotacaoUsuarioSemPermissaoTela;
const
  nCdForoValido = 23;
  nCdVaraValida = 1;
  nNuSeqLotacaoAtual = 2;
  sUsuarioValido = 'USUARIO3';
begin
  FoNumeroMandadoRegrasFake.FncdForo := nCdForoValido;
  FoNumeroMandadoRegrasFake.FncdVara := nCdVaraValida;

  FoControleCartorioUnicoFake.DefinirUtilizaCartorioUnico(True);
  FoControleCartorioUnicoFake.FnNuSeqLotacao := nNuSeqLotacaoAtual;

  FoNumeroMandadoRegrasFake.fpgTipoRegraLotacaoUnica := trcuTrocarLotacao;
  FoNumeroMandadoRegrasFake.FenTipoLotacao := tlCartorio;
  FoNumeroMandadoRegrasFake.FbTelaTemPermissao := False;
  FoControleCartorioUnicoFake.FbRespostaUsuarioTrocaLotacao := True;
  TfpgRegrasLotacaoUnificadaFake(FoControleCartorioUnicoFake.prpControleLotacao)
    .FbUsuarioPossuiFuncaoAutorizada := True;
  FoControleCartorioUnicoFake.FsUsuario := 'USUARIO3';

  CheckException(FoNumeroMandadoRegrasFake.ExecutarRegraAntesValidarMandado,
    Eabort, 'Teste para verificar que a lotação será trocada porém será disparada exceção por o usuário não ter acesso a tela');
end;

procedure TfpgNumeroMandadoRegrasTests.TestCreateComParametroCorreto;
begin
  CheckTrue(CriarObjetoRegraMandadoComParametroCorreto);
end;

initialization
  TestFramework.RegisterTest('Unitário\PG5\Componentes\ufpgNumeroMandadoRegrasTests',
    TfpgNumeroMandadoRegrasTests.Suite);
end.
