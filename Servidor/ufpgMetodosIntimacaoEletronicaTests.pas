unit ufpgMetodosIntimacaoEletronicaTests;

interface

uses
  ufpgMetodosIntimacaoEletronica, TestFrameWork, Windows, Forms, FutureWindows,
  SysUtils, uspClientDataSet, DB, usajConstante, uspExcecao, usajMensagemObjeto,
  uspConjuntoDados, usajPendenciaPrazo, uspControleTestesUnitarios,
  ufpgMetodosIntimacaoEletronicaFake;

const
  sCDOBJETO_TESTE_1 = '0N0000000D1HM';
  sCDOBJETO_TESTE_2 = '0N0000000D2HM';
  sCDOBJETO_TESTE_3 = '0N0000000D3HM';

  nNUSEQPENDENCIA_TESTE_1 = 1;
  nNUSEQPENDENCIA_TESTE_2 = 2;
  nNUSEQPENDENCIA_TESTE_3 = 3;

  sCDPROCESSO_TESTE_1 = '1N00525250000';
  sCDPROCESSO_TESTE_2 = '2N00525250000';
  sCDPROCESSO_TESTE_3 = '3N00525250000';

  sNOME_USUARIO = 'Softplan';

type
  TfpgMetodosIntimacaoEletronicaTests = class(TTestCase)
  private
    FoForm: TfpgMetodosIntimacaoEletronicaFake;
    FocdsAgentes: TspClientDataSet;

    /// <summary>
    ///  Método para auxilio de teste de exceção ao incluir pendencia
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarExceptionIncluirPendenciaDeErroDeProcessamento;

    /// <summary>
    ///  Método para auxilio de teste de exceção ao gravar mensagem objeto
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  14/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarExceptionGravarMensagemPendenciaErroProcessamento;

    /// <summary>
    ///  Verifica se encerrou a pendencia
    /// </summary>
    /// <param name="psCdProcesso">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  14/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function VerificarSeAPendenciaEstaEncerrada(psCdProcesso: string): boolean;

    /// <summary>
    ///  Verifica se enviou recado para todos agentes
    /// </summary>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  14/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    function VerificarSeTemRecadoParaTodosUsuariosDestino: boolean;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    /// <summary>
    ///  Teste de inclusão de pendência em caso de erro no processamento
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarIncluirPendenciaDeErroDeProcessamentoComObjetoEmAberto;

    /// <summary>
    ///  Teste de inclusão com sucesso de pendência em caso de erro no processamento
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarIncluirPendenciaDeErroDeProcessamentoComSucesso;

    /// <summary>
    ///  Teste de exceção na inclusão de pendência em caso de erro no processamento
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarIncluirPendenciaDeErroDeProcessamentoComExcecao;

    /// <summary>
    ///  Teste ao encerrar pendência
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarAlterarPendenciaParaEncerrada;

    /// <summary>
    ///  Notificação ao agentes
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  07/05/2013 - cleber.gomes - SALT: 103463/84
    /// </remarks>
    procedure TestarEnviarRecadoDeErroProcessamentoParaEscrivaoCartorio;

    /// <summary>
    ///  Teste se houve inclusão com sucesso da mensagem de erro do processamento
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarIncluirMensagemDeErroDeProcessamento;

    /// <summary>
    ///  Teste de encarramento da mensagem de erro
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarAlterarMensagemDeErroParaEncerrada;

    /// <summary>
    ///  Teste de comportamento quando não há mensagem a ser encerrada
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarAlterarMensagemDeErroParaEncerradaSemMensagemEmAberto;

    /// <summary>
    ///  Teste de comportamento quando não há agentes a ser notificados
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  13/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarEnviarRecadoDeErroProcessamentoParaEscrivaoCartorioSemAgentes;

    /// <summary>
    ///  Teste ao gravar mensagem objeto
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  14/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarGravarMensagemPendenciaErroProcessamento;

    /// <summary>
    ///  Teste ao gravar mensagem objeto com exceção
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  14/05/2013 - cleber.gomes - SALT: 103463/1
    /// </remarks>
    procedure TestarGravarMensagemPendenciaErroProcessamentoComExcecao;
  end;

implementation

uses
  usajRecado;

{ TfpgMetodosIntimacaoEletronicaTests }

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.SetUp;
begin
  inherited;
  goControleTestesUnitarios.spAmbienteEmModoDeTestes := True;
  FoForm := TfpgMetodosIntimacaoEletronicaFake.Create(); //PC_OK
  FocdsAgentes := TspClientDataSet.Create(nil); //PC_OK
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TearDown;
begin
  inherited;
  FreeAndNil(FocdsAgentes); //PC_OK
  FreeAndNil(FoForm); //PC_OK
  goControleTestesUnitarios.spAmbienteEmModoDeTestes := False;
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TestarAlterarMensagemDeErroParaEncerrada;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_1, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  FoForm.AlterarMensagemDeErroParaEncerrada(sCDOBJETO_TESTE_1);

  CheckTrue(FoForm.TestarSeMensagemFoiEncerradaComSucesso);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarAlterarMensagemDeErroParaEncerradaSemMensagemEmAberto;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_1, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  FoForm.AlterarMensagemDeErroParaEncerrada(sCDOBJETO_TESTE_2);

  CheckFalse(FoForm.TestarSeMensagemFoiEncerradaComSucesso);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TestarAlterarPendenciaParaEncerrada;
var
  sCdProcesso: string;
  nNuSeqSequencia: integer;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_2,
    'TestAlterarPendenciaParaEncerrada', sCDPROCESSO_TESTE_1, nNUSEQPENDENCIA_TESTE_1);
  sCdProcesso := sCDPROCESSO_TESTE_1;
  FoForm.IncluirPendenciaDeErroDeProcessamento(sCDOBJETO_TESTE_1, sNOME_USUARIO,
    sCdProcesso, nNuSeqSequencia);

  FoForm.AlterarPendenciaParaEncerrada(sCDOBJETO_TESTE_2);

  CheckTrue(VerificarSeAPendenciaEstaEncerrada(sCDPROCESSO_TESTE_1));
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarEnviarRecadoDeErroProcessamentoParaEscrivaoCartorio;
begin
  FoForm.fpgQntdUsuarios := 2;

  FoForm.EnviarRecadoDeErroProcessamentoParaEscrivaoCartorio(NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO);

  FocdsAgentes.Data := FoForm.PegarAgentesInterno(NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO, nCDTIPO_AGENTE_ESCRIVAO);

  CheckTrue(VerificarSeTemRecadoParaTodosUsuariosDestino);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarEnviarRecadoDeErroProcessamentoParaEscrivaoCartorioSemAgentes;
begin
  FoForm.fpgQntdUsuarios := 0;

  FoForm.EnviarRecadoDeErroProcessamentoParaEscrivaoCartorio(NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO);

  CheckTrue(FoForm.fpgTabelaVirtualRecado.IsEmpty);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarExceptionGravarMensagemPendenciaErroProcessamento;
begin
  FoForm.GravarMensagemPendenciaErroProcessamento(sCDOBJETO_TESTE_1, sCDPROCESSO_TESTE_1,
    'SAJ', 'Teste gravar mensagem de erro no processamento de pendência');
end;

// 14/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TestarExceptionIncluirPendenciaDeErroDeProcessamento;
var
  nNuSeqPendencia: integer;
  sCdProcesso: string;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_2, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  sCdProcesso := sCDPROCESSO_TESTE_3;
  FoForm.IncluirPendenciaDeErroDeProcessamento(sCDOBJETO_TESTE_3, 'SAJ', sCdProcesso,
    nNuSeqPendencia);
end;

// 14/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TestarGravarMensagemPendenciaErroProcessamento;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_2, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  FoForm.GravarMensagemPendenciaErroProcessamento(sCDOBJETO_TESTE_1,
    sCDPROCESSO_TESTE_1, 'SAJ', 'Teste gravar mensagem de erro no processamento de pendência');

  CheckTrue(not FoForm.fpgTabelaVirtualMensagemObjeto.IsEmpty);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarGravarMensagemPendenciaErroProcessamentoComExcecao;
begin
  CheckException(TestarExceptionGravarMensagemPendenciaErroProcessamento, EDatabaseError);
end;

// 14/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.TestarIncluirMensagemDeErroDeProcessamento;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_1, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  CheckTrue(FoForm.TestarSeMensagemFoiIncluidaComSucesso);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarIncluirPendenciaDeErroDeProcessamentoComExcecao;
begin
  CheckException(TestarExceptionIncluirPendenciaDeErroDeProcessamento, EspRegraNegocio);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarIncluirPendenciaDeErroDeProcessamentoComObjetoEmAberto;
var
  nNuSeqPendencia: integer;
  sCdProcesso: string;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_1, 'teste',
    sCDPROCESSO_TESTE_1, nNUSEQPENDENCIA_TESTE_1);

  CheckFalse(FoForm.IncluirPendenciaDeErroDeProcessamento(sCDOBJETO_TESTE_1,
    'SAJ', sCdProcesso, nNuSeqPendencia));

  CheckEqualsString(sCDPROCESSO_TESTE_1, sCdProcesso);
  CheckEquals(nNUSEQPENDENCIA_TESTE_1, nNuSeqPendencia);
end;

// 13/05/2013 - cleber.gomes - SALT: 103463/1
procedure TfpgMetodosIntimacaoEletronicaTests.
TestarIncluirPendenciaDeErroDeProcessamentoComSucesso;
var
  nNuSeqPendencia: integer;
  sCdProcesso: string;
begin
  FoForm.IncluirMensagemDeErroDeProcessamento(sCDOBJETO_TESTE_2, 'teste',
    STRING_INDEFINIDO, NUMERO_INDEFINIDO);

  sCdProcesso := sCDPROCESSO_TESTE_1;
  CheckTrue(FoForm.IncluirPendenciaDeErroDeProcessamento(sCDOBJETO_TESTE_1, 'SAJ',
    sCdProcesso, nNuSeqPendencia));
end;

// 14/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaTests.VerificarSeAPendenciaEstaEncerrada(
  psCdProcesso: string): boolean;
begin
  if FoForm.fpgTabelaVirtualPendenciaPrazo.Locate('CDPROCESSO', psCdProcesso, []) then
  begin
    if not (FoForm.fpgTabelaVirtualPendenciaPrazo.FieldByName('CDUSUARIOCUMP').IsNull and
      FoForm.fpgTabelaVirtualPendenciaPrazo.FieldByName('DTCUMPRIMENTO').IsNull) then
    begin
      result := True;
      Exit;
    end;
  end;
  result := False;
end;

// 14/05/2013 - cleber.gomes - SALT: 103463/1
function TfpgMetodosIntimacaoEletronicaTests.VerificarSeTemRecadoParaTodosUsuariosDestino: boolean;
begin
  FocdsAgentes.First;
  while not FocdsAgentes.EOF do
  begin
    if not FoForm.fpgTabelaVirtualRecado.Locate('CDUSUARIODESTINO',
      FocdsAgentes.FieldByName('CDUSUARIO').AsString, []) then
    begin
      result := False;
      exit;
    end;
    FocdsAgentes.Next;
  end;
  result := True;
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Servidor\ufpgMetodosIntimacaoEletronicaTests',
    TfpgMetodosIntimacaoEletronicaTests.Suite);
end.

