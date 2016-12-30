unit ufpgTesteFactory;

interface

uses
  Classes,
  SysUtils,
  ufpgGuiTestCase,
  ufpgCadApensamentoTests,
  ufpgCadArmasBensPG5Tests,
  ufpgCadContatoTests,
  ufpgCadCorrecaoClasseTests,
  ufpgCadEntranhamentoTests,
  ufpgCadGrjBaixaTests,
  ufpgCadGuiaTests,
  ufpgCadHistoricoParteTests,
  ufpgCadJuntadaPetTests,
  ufpgCadMandadoExcepcionalTests,
  ufpgCadMovimentacaoLoteTests,
  ufpgCadMovimentacaoUnitariaTests,
  ufpgCadMultaTests,
  ufpgCadParteRepresTests,
  ufpgCadPautaAudienciaTests,
  ufpgCadPendenciaPrazoTests,
  ufpgCadPessoaTests,
  ufpgCadProcessoDependenteTests,
  ufpgCadProcessoTests,
  ufpgCadProcExcepcionalTests,
  ufpgCadRegSentencaTests,
  ufpgCadUnificacaoTests,
  ufpgCancelamentoProcessoTests,
  ufpgCancelamentoTests,
  ufpgCancelaRedistForoTests,
  ufpgCancelJuntadaPetTests,
  ufpgConfirmacaoMovTests,
  ufpgConsCargaTests,
  ufpgConsPeticaoIntermEletronicaTests,
  ufpgConsProcAvancadaTests,
  ufpgConsProcBasicaTests,
  ufpgConsProcessoCargaTests,
  ufpgConsRegSentencaTests,
  ufpgConsultaDadosMandadoTests,
  ufpgConsultaMandadosTests,
  ufpgDesmembraProcTests,
  ufpgDigPecaProcessualTests,
  ufpgDistribLoteTests,
  ufpgEdicaoDocumentoTests,
  ufpgEditorTests,
  ufpgExecutarRoteiroPROTests,
  ufpgGerenciadorArquivoTests,
  ufpgImportacaoArquivosMultimidiaTests,
  ufpgLogFluxoTests,
  ufpgMaterializaProcessoTests,
  ufpgReativacaoProcessoTests,
  ufpgRecebimentoTests,
  ufpgRecebRedistForoTests,
  ufpgRedistribLoteVagaTests,
  ufpgRedistribLoteVaraTests,
  ufpgRedistribuicaoForoTests,
  ufpgRegMvJuntadaTests,
  ufpgRelAnaliticoDistribTests,
  ufpgRelComunicDPTests,
  ufpgRelDemoDistribTests,
  ufpgRelExtratoProcTests,
  ufpgRelFichaProcTests,
  ufpgRemessaTests,
  ufpgRetificacaoProcessoTests,
  ufpgVincUsuProcSigilosoTests,
  ufpgVirtualizarProcessoTests,
  ufpgVisualizaFluxoTrabalhoTests,
  uggpCadAutoTextoTests,
  uggpConfirmacaoMovUnitariaTests,
  uggpPautaAudienciaBlocoTests,
  uggpRelPautaAudienciaCorridoTests,
  usajCadRecadoTests,
  usajConsRecadoRPDevTests;

var
  FlNomeTeste: TStringList;

type
  TffpgTesteFactory = class
  public
    function CriarTeste(psNomeTeste: string): TfpgGuiTestCase;
    function PegarTestes: TStringList;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TffpgTesteFactory }

constructor TffpgTesteFactory.Create;
begin
  FlNomeTeste := TStringList.Create;

  FlNomeTeste.add('fpgCadApensamentoTests');
  FlNomeTeste.add('fpgCadArmasBensPG5Tests');
  FlNomeTeste.add('fpgCadContatoTests');
  FlNomeTeste.add('fpgCadCorrecaoClasseTests');
  FlNomeTeste.add('fpgCadEntranhamentoTests');
  FlNomeTeste.add('fpgCadGrjBaixaTests');
  FlNomeTeste.add('fpgCadGuiaTests');
  FlNomeTeste.add('fpgCadHistoricoParteTests');
  FlNomeTeste.add('fpgCadJuntadaPetTests');
  FlNomeTeste.add('fpgCadMandadoExcepcionalTests');
  FlNomeTeste.add('fpgCadMovimentacaoLoteTests');
  FlNomeTeste.add('fpgCadMovimentacaoUnitariaTests');
  FlNomeTeste.add('fpgCadMultaTests');
  FlNomeTeste.add('fpgCadParteRepresTests');
  FlNomeTeste.add('fpgCadPautaAudienciaTests');
  FlNomeTeste.add('fpgCadPendenciaPrazoTests');
  FlNomeTeste.add('fpgCadPessoaTests');
  FlNomeTeste.add('fpgCadProcessoDependenteTests');
  FlNomeTeste.add('fpgCadProcessoTests');
  FlNomeTeste.add('fpgCadProcExcepcionalTests');
  FlNomeTeste.add('fpgCadRegSentencaTests');
  FlNomeTeste.add('fpgCadUnificacaoTests');
  FlNomeTeste.add('fpgCancelamentoProcessoTests');
  FlNomeTeste.add('fpgCancelamentoTests');
  FlNomeTeste.add('fpgCancelaRedistForoTests');
  FlNomeTeste.add('fpgCancelJuntadaPetTests');
  FlNomeTeste.add('fpgConfirmacaoMovTests');
  FlNomeTeste.add('fpgConsCargaTests');
  FlNomeTeste.add('fpgConsPeticaoIntermEletronicaTests');
  FlNomeTeste.add('fpgConsProcAvancadaTests');
  FlNomeTeste.add('fpgConsProcBasicaTests');
  FlNomeTeste.add('fpgConsProcessoCargaTests');
  FlNomeTeste.add('fpgConsRegSentencaTests');
  FlNomeTeste.add('fpgConsultaDadosMandadoTests');
  FlNomeTeste.add('fpgConsultaMandadosTests');
  FlNomeTeste.add('fpgDesmembraProcTests');
  FlNomeTeste.add('fpgDigPecaProcessualTests');
  FlNomeTeste.add('fpgDistribLoteTests');
  FlNomeTeste.add('fpgEdicaoDocumentoTests');
  FlNomeTeste.add('fpgEditorTests');
  FlNomeTeste.add('fpgExecutarRoteiroPROTests');
  FlNomeTeste.add('fpgGerenciadorArquivoTests');
  FlNomeTeste.add('fpgImportacaoArquivosMultimidiaTests');
  FlNomeTeste.add('fpgLogFluxoTests');
  FlNomeTeste.add('fpgMaterializaProcessoTests');
  FlNomeTeste.add('fpgReativacaoProcessoTests');
  FlNomeTeste.add('fpgRecebimentoTests');
  FlNomeTeste.add('fpgRecebRedistForoTests');
  FlNomeTeste.add('fpgRedistribLoteVagaTests');
  FlNomeTeste.add('fpgRedistribLoteVaraTests');
  FlNomeTeste.add('fpgRedistribuicaoForoTests');
  FlNomeTeste.add('fpgRegMvJuntadaTests');
  FlNomeTeste.add('fpgRelAnaliticoDistribTests');
  FlNomeTeste.add('fpgRelComunicDPTests');
  FlNomeTeste.add('fpgRelDemoDistribTests');
  FlNomeTeste.add('fpgRelExtratoProcTests');
  FlNomeTeste.add('fpgRelFichaProcTests');
  FlNomeTeste.add('fpgRemessaTests');
  FlNomeTeste.add('fpgRetificacaoProcessoTests');
  FlNomeTeste.add('fpgVincUsuProcSigilosoTests');
  FlNomeTeste.add('fpgVirtualizarProcessoTests');
  FlNomeTeste.add('fpgVisualizaFluxoTrabalhoTests');
  FlNomeTeste.add('ggpCadAutoTextoTests');
  FlNomeTeste.add('ggpConfirmacaoMovUnitariaTests');
  FlNomeTeste.add('ggpPautaAudienciaBlocoTests');
  FlNomeTeste.add('ggpRelPautaAudienciaCorridoTests');
  FlNomeTeste.add('sajCadRecadoTests');
  FlNomeTeste.add('sajConsRecadoRPDevTests');

end;

function TffpgTesteFactory.CriarTeste(psNomeTeste: string): TfpgGuiTestCase;
begin
  case FlNomeTeste.IndexOf(psNomeTeste) of
    00: result:= TffpgCadApensamentoTests.Create('TestarApensarProcesso');
    01: result:= TffpgCadArmasBensPG5Tests.Create('TestarCadastroDeArmasEBens');
    02: result:= TffpgCadContatoTests.Create('TestarCadastroBasicoContato');
    03: result:= TffpgCadCorrecaoClasseTests.Create('TestarCorrecaoDeClasse');
    04: result:= TffpgCadEntranhamentoTests.Create('TestarCadastroEntranhamento');
    05: result:= TffpgCadGrjBaixaTests.Create('TestarBaixaDeGuias');
    06: result:= TffpgCadGuiaTests.Create('TestarCadastrarGuia');
    07: result:= TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes');
    08: result:= TffpgCadJuntadaPetTests.Create('TestarCadastroBasicoJuntadaPet');
    09: result:= TffpgCadMandadoExcepcionalTests.Create('TestarEmissaodeMandadoExcepcional');
    10: result:= TffpgCadMovimentacaoLoteTests.Create('TestarLancarMovimentacaoLote');
    11: result:= TffpgCadMovimentacaoUnitariaTests.Create('TestarCadastrarMovUnitaria');
    12: result:= TffpgCadMultaTests.Create('TestarCadMulta');
    13: result:= TffpgCadParteRepresTests.Create('TestarCadastroPartesRepresentantes');
    14: result:= TffpgCadPautaAudienciaTests.Create('TestarCadPautaAudiencia');
    15: result:= TffpgCadPendenciaPrazoTests.Create('TestarCadastroPendenciaPrazo');
    16: result:= TffpgCadPessoaTests.Create('TestarCadastrarPessoa');
    17: result:= TffpgCadProcessoDependenteTests.Create('TestarCadProcessoDependente');
    18: result:= TffpgCadProcessoTests.Create('TestarCadastroProcesso');
    19: result:= TffpgCadProcExcepcionalTests.Create('TestarCadastroProcExepcional');
    20: result:= TffpgCadRegSentencaTests.Create('TestarCadRegSenteca');
    21: result:= TffpgCadUnificacaoTests.Create('TestarUnificacaoProcessos');
    22: result:= TffpgCancelamentoProcessoTests.Create('TestarCancelamentoProcesso');
    23: result:= TffpgCancelamentoTests.Create('TestarRealizarCancelamento');
    24: result:= TffpgCancelaRedistForoTests.Create('TestarCancelarRedistForo');
    25: result:= TffpgCancelJuntadaPetTests.Create('TestarCancelamentoJuntada');
    26: result:= TffpgConfirmacaoMovTests.Create('TestarConfirmacaoMovimentacao');
    27: result:= TffpgConsCargaTests.Create('TestarConsultarCarga');
    28: result:= TffpgConsPeticaoIntermEletronicaTests.Create('TestarCadastrarPeticaoIntermediaria');
    29: result:= TffpgConsProcAvancadaTests.Create('TestarConsultaProcessoAvancadaNomeCompleto');
    30: result:= TffpgConsProcBasicaTests.Create('TestarConsultaBasicaProcessso');
    31: result:= TffpgConsProcessoCargaTests.Create('TestarConsProcessoCarga');
    32: result:= TffpgConsRegSentencaTests.Create('TestarConsultaRegistroSentenca');
    33: result:= TffpgConsultaDadosMandadoTests.Create('TestarConsultaBasicaMandado');
    34: result:= TffpgConsultaMandadosTests.Create('TestarConsultaAvancadaMandado');
    35: result:= TffpgDesmembraProcTests.Create('TestarDesmembramentoDeProcessos');
    36: result:= TffpgDigPecaProcessualTests.Create('TestarDigitalizacaoPeca');
    37: result:= TffpgDistribLoteTests.Create('TestarDistribuicao');
    38: result:= TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento');
    39: result:= TffpgEditorTests.Create('TestarEditor');
    40: result:= TffpgExecutarRoteiroPROTests.Create('');
    41: result:= TffpgGerenciadorArquivoTests.Create('TestarGerenciadorArquivos');
    42: result:= TffpgImportacaoArquivosMultimidiaTests.Create('TestarImportacaoArquivosMultimidia');
    43: result:= TffpgLogFluxoTests.Create('TestarRelHistoricoProcessoFluxo');
    44: result:= TffpgMaterializaProcessoTests.Create('TestarMaterializaProcesso');
    45: result:= TffpgReativacaoProcessoTests.Create('TestarReativacaoProcessoCancelado');
    46: result:= TffpgRecebimentoTests.Create('TestarReceberRemessa');
    47: result:= TffpgRecebRedistForoTests.Create('TestarRecebRedistForo');
    48: result:= TffpgRedistribLoteVagaTests.Create('TestarRedistribuicaoEntreVaga');
    49: result:= TffpgRedistribLoteVaraTests.Create('TestarRedistribuicaoEntreVara');
    50: result:= TffpgRedistribuicaoForoTests.Create('TestarRedistribuicaoForo');
    51: result:= TffpgRegMvJuntadaTests.Create('TestarRegMvJuntada');
    52: result:= TffpgRelAnaliticoDistribTests.Create('TestarRelAnaliticoDistrib');
    53: result:= TffpgRelComunicDPTests.Create('TestarRelComunicadoDelegaciaPolicia');
    54: result:= TffpgRelDemoDistribTests.Create('TestarProcessoDemonsDistribVara');
    55: result:= TffpgRelExtratoProcTests.Create('TestarRelExtratoProcesso');
    56: result:= TffpgRelFichaProcTests.Create('TestarRelFichaProcesso1_2_31');
    57: result:= TffpgRemessaTests.Create('TestarRemessaCarga');
    58: result:= TffpgRetificacaoProcessoTests.Create('TestarRetificarProcesso');
    59: result:= TffpgVincUsuProcSigilosoTests.Create('TestarVincularUsuario');
    60: result:= TffpgVirtualizarProcessoTests.Create('TestarVirtualizarProcesso');
    61: result:= TffpgVisualizaFluxoTrabalhoTests.Create('TestarFluxoTrabalho');
    62: result:= TfggpCadAutoTextoTests.Create('TestarCadAutoTexto');
    63: result:= TfggpConfirmacaoMovUnitariaTests.Create('TestarConfirmacaoMovimentacao');
    64: result:= TfggpPautaAudienciaBlocoTests.Create('TestarPautaAudienciaBloco');
    65: result:= TfggpRelPautaAudienciaCorridoTests.Create('TestarRelPautaAudienciaCorrido');
    66: result:= TfsajCadRecadoTests.Create('TestarCadastroDeRecado');
    67: result:= TfsajConsRecadoRPDevTests.Create('TestarConsultarRecado');
  else
    result := nil;
  end;
end;

destructor TffpgTesteFactory.Destroy;
begin
  FreeAndNil(FlNomeTeste);
  inherited;
end;

function TffpgTesteFactory.PegarTestes: TStringList;
begin
  result := FlNomeTeste;
end;

end.

