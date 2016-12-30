unit ufpgCtrlEmissaoDocProcNaoDistribuidoTests;

{*****************************************************************************
Projeto/Sistema: FPG / Componentes
Objetivo: Classe de teste da controller emissão de documentos para processos sem distribuíção
Criação: 16/12/2014 - douglas.delapria
*****************************************************************************}

interface

uses
  uspTestCase, ufpgCtrlEmissaoDocProcNaoDistribuidoFake, ufpgCtrlEmissaoDocProcNaoDistribuido,
  ufpgCtrlEmissaoDocProcNaoDistribuidoModelTests;

type

  TfpgCtrlEmissaoDocProcNaoDistribuidoTests = class(TspTestCase)
  private
    FoCtrlEmissaoDocProcNaoDistribuido: TfpgCtrlEmissaoDocProcNaoDistribuidoFake;

    /// <summary>
    ///  Executa teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure ExecutarTesteValidarComportamentoDigitalParaDocumento;
    /// <summary>
    ///  Executa teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure ExecutarTesteVerificarCategoriaPermitidaProcSemDistribuicao;
    /// <summary>
    ///  Executa teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure ExecutarTesteValidarProcessosNaoDistribuidos;
  protected
    /// <summary>
    ///  Método executado ao iniciar teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure SetUp; override;
    /// <summary>
    ///  Método executado ao fechar teste
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure TearDown; override;

  published
    /// <summary>
    ///  Testa validar comportamento digital para documento
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure TestarValidarComportamentoDigitalParaDocumento;
    /// <summary>
    ///  Testa método verificar categoria permitida processo sem distribuíção
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure TestarVerificarCategoriaPermitidaProcSemDistribuicao;
    /// <summary>
    ///  Testa validar processo não distribuído
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
    /// </remarks>
    procedure TestarValidarProcessosNaoDistribuidos;
  end;

implementation

uses
  SysUtils, uspClientDataSet, usajConstante;

{ TfpgCtrlEmissaoDocProcNaoDistribuidoTests }


// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.TestarValidarComportamentoDigitalParaDocumento;
begin
  ExecutarRoteiroTestes(ExecutarTesteValidarComportamentoDigitalParaDocumento);
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.TestarValidarProcessosNaoDistribuidos;
begin
  ExecutarRoteiroTestes(ExecutarTesteValidarProcessosNaoDistribuidos);
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.
TestarVerificarCategoriaPermitidaProcSemDistribuicao;
begin
  ExecutarRoteiroTestes(ExecutarTesteVerificarCategoriaPermitidaProcSemDistribuicao);
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.SetUp;
begin
  spCarregarDadosSetUp := False;
  inherited;
  FoCtrlEmissaoDocProcNaoDistribuido := //ql
    TfpgCtrlEmissaoDocProcNaoDistribuidoFake.Create(trDocumentos); //PC_OK
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoCtrlEmissaoDocProcNaoDistribuido); //PC_OK
end;

// 16/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.
ExecutarTesteValidarComportamentoDigitalParaDocumento;
var
  oModel: TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests;
  bRetorno: boolean;
begin
  oModel := TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests(FoModelTests);

  FoCtrlEmissaoDocProcNaoDistribuido.fpgNuProtocolo := oModel.fpgNuProtocolo;
  FoCtrlEmissaoDocProcNaoDistribuido.fpgOrigemProtocolo := oModel.fpgOrigemProtocolo;
  FoCtrlEmissaoDocProcNaoDistribuido.fpgValorExpediente := oModel.fpgValorExpediente;

  bRetorno := FoCtrlEmissaoDocProcNaoDistribuido.ValidarComportamentoDigitalParaDocumento(
    oModel.fpgExpediente1, oModel.fpgExpediente2, oModel.fpgHabilita);

  CheckEquals(bRetorno, oModel.fpgResultado, oModel.fpgMsgErro);
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.
ExecutarTesteVerificarCategoriaPermitidaProcSemDistribuicao;
var
  oModel: TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests;
  bRetorno: boolean;
begin
  oModel := TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests(FoModelTests);

  bRetorno := FoCtrlEmissaoDocProcNaoDistribuido.
    VerificarCategoriaPermitidaMovimentacaoDocumentoProcessoSemDistribuicao(oModel.fpgCdCategoria);

  CheckEquals(bRetorno, oModel.fpgResultado, oModel.fpgMsgErro);
end;

// 17/12/2014 - Douglas.Delapria - SALT: 156525/1
procedure TfpgCtrlEmissaoDocProcNaoDistribuidoTests.ExecutarTesteValidarProcessosNaoDistribuidos;
var
  oModel: TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests;
  ocdsDadosProcesso: TspClientDataSet;
  bRetorno: boolean;
  vDadosProcesso: olevariant;
begin
  oModel := TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests(FoModelTests);
  ocdsDadosProcesso := TspClientDataSet.Create(nil);
  try
    FoCtrlEmissaoDocProcNaoDistribuido.AdicionarDocumento(oModel.fpgCdProcesso,
      oModel.fpgNuProcesso, oModel.fpgFlDistribuido, 0, STRING_INDEFINIDO, STRING_INDEFINIDO);

    vDadosProcesso := ocdsDadosProcesso.Data;
    bRetorno := FoCtrlEmissaoDocProcNaoDistribuido.ValidarProcessosNaoDistribuidos(vDadosProcesso);
    ocdsDadosProcesso.Data := vDadosProcesso;

    CheckEquals(bRetorno, oModel.fpgResultado, oModel.fpgMsgErro);

    CheckEquals(ocdsDadosProcesso.IsEmpty, oModel.fpgResultadoDados, oModel.fpgMsgErro);
  finally
    FreeAndNil(ocdsDadosProcesso);
  end;
end;

initialization
  TspTestCase.RegisterTestXLS('Unitário\PG5\Componentes\ufpgCtrlEmissaoDocProcNaoDistribuidoTests',
    TfpgCtrlEmissaoDocProcNaoDistribuidoTests, 'DadosPrincipal',
    TfpgCtrlEmissaoDocProcNaoDistribuidoModelTests);

end.

